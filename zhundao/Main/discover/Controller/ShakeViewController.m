//
//  ShakeViewController.m
//  zhundao
//
//  Created by zhundao on 2017/2/9.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ShakeViewController.h"
#import "ShakeTableViewCell.h"
#import "ShakeModel.h"
#import "UIView+TYAlertView.h"
#import "detailShakeViewController.h"
#import "bindingBeacon.h"
#import "UILabel+nullDataLabel.h"
@interface ShakeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableview;
     Reachability *r;
     NSString *accesskey;
    NSMutableArray *_dataArray;
    NSMutableArray *dataarr;
    ShakeTableViewCell *mycell;

}
@property(nonatomic,strong)UILabel *nullDataLabell;
@property(nonatomic,strong)UIImageView *nullImageView ;
@end
@implementation ShakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"准到Beacon";
    accesskey = [[ZDDataManager shareManager]getaccseekey];
    [self createTableView];
    [self firstload];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem scanItemWithTarget:self action:@selector(pushOtherWithIndex)];
    // Do any additional setup after loading the view.
}

- (void)pushOtherWithIndex
{

            bindingBeacon *bind = [[bindingBeacon alloc]init];
            [self presentViewController:bind animated:YES completion:nil];
            bind.backblock = ^(BOOL flag)
    {
        if (flag) {
            [self loadData];
        }
    };
}

- (void)firstload
{
    r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            NSLog(@"wu");
        {
            NSMutableArray *muarray = [NSMutableArray array];
            NSArray *arr = [[NSUserDefaults standardUserDefaults]objectForKey:@"shake"];
            for (NSDictionary *dic in arr) {
                ShakeModel *model = [ShakeModel yy_modelWithJSON:dic];
                [muarray addObject:model];
            }
            _dataArray = [muarray mutableCopy];
            [_tableview reloadData];
            [self shownull];
            break;
        }
            
        case ReachableViaWWAN:
            // 使用3G网络
            NSLog(@"wan");
            [self loadData];
            
            
            
            break;
        case ReachableViaWiFi:
            // 使用WiFi网络
            NSLog(@"wifi");
            [self loadData];
            
            
            break;
    }
}
- (UILabel *)nullDataLabell
{
    if (!_nullDataLabell) {
        _nullDataLabell =[self showNullLabelWithText:@"请添加微信号”izhundao”发送“Beacon”关键词了解更多" WithTextColor:[UIColor lightGrayColor]];
        _nullDataLabell.numberOfLines = 0;
    }
    return _nullDataLabell;
}
- (void)shownull
{
    if (_dataArray.count==0&&_nullDataLabell==nil) {
        _nullImageView =  [self showNullImage];
        [self.view addSubview:self.nullDataLabell];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:_nullDataLabell.text];
        [str addAttribute:NSForegroundColorAttributeName value:kColorA(98, 167, 245, 1) range:[_nullDataLabell.text rangeOfString:@"izhundao"]];
        [str addAttribute:NSForegroundColorAttributeName value:kColorA(98, 167, 245, 1) range:[_nullDataLabell.text rangeOfString:@"Beacon"]];
        _nullDataLabell.attributedText = str;
    }
    if (_dataArray.count>0&&_nullDataLabell!=nil) {
        [_nullDataLabell removeFromSuperview];
        [_nullImageView removeFromSuperview];
    }
}

- (void)loadData
{
    JQIndicatorView *indicator = [[JQIndicatorView alloc]initWithType:3 tintColor: [UIColor colorWithRed:9.00f/255.0f green:187.00f/255.0f blue:7.00f/255.0f alpha:1] size:CGSizeMake(90, 70)];
    indicator.center = self.view.center;
    [self.view addSubview:indicator];
    [indicator startAnimating];
//    api/Game/GetMybeaconList?accessKey={accessKey}
    NSString *shakeUrl = [NSString stringWithFormat:@"%@api/Game/GetMybeaconList?accessKey=%@",zhundaoApi,accesskey];
    [ZD_NetWorkM getDataWithMethod:shakeUrl parameters:nil succ:^(NSDictionary *obj) {
        NSLog(@"responseObject = %@",obj);
        NSDictionary *result = [NSDictionary dictionaryWithDictionary:obj];
        NSArray *array1 = result[@"Data"];
        NSMutableArray *muarray = [NSMutableArray array];
        dataarr = [NSMutableArray array];
        for (NSDictionary *acdic in array1) {
            NSMutableDictionary *dic = [acdic mutableCopy];
            NSMutableDictionary *e = [NSMutableDictionary dictionary];
            ShakeModel *model = [ShakeModel yy_modelWithJSON:acdic];
            [muarray addObject:model];
            for (NSString *keyStr in dic.allKeys) {
                if ([keyStr isEqualToString:@"User"]) {    //判断key是否为user 是就移除NSUserDefaults不能存空值
                    [dic removeObjectForKey:keyStr];
                }
                else if ([[dic objectForKey:keyStr] isEqual:[NSNull null]])  //判断value是否为null ，是则用空字符串替换
                {
                    [e setObject:@"" forKey:keyStr];
                }
                else
                {
                    [e setObject:[dic objectForKey:keyStr] forKey:keyStr];  //正常的照搬
                }
            }
            [dataarr addObject:e];
        }
        
        
        [[NSUserDefaults standardUserDefaults]setObject:[dataarr copy] forKey:@"shake"];
        
        [indicator stopAnimating];
        _dataArray = [muarray mutableCopy];
        [_tableview reloadData];
        [self shownull];
    } fail:^(NSError *error) {
        
    }];
}



- (void)createTableView
{
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
    [_tableview registerNib:[UINib nibWithNibName:@"ShakeTableViewCell" bundle:nil] forCellReuseIdentifier:@"shakeID"];
    _tableview.delegate = self;
    _tableview.dataSource =self;
    _tableview.backgroundColor = ZDBackgroundColor;
    _tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_tableview];
}
#pragma mark tableview Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShakeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shakeID"];
    if (cell==nil) {
        cell = [[ShakeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"shakeID"];
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cellTap:)];
    [cell addGestureRecognizer:tap];
    cell.model= _dataArray[indexPath.row];
    
    return  cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
- (void)cellTap:(UITapGestureRecognizer *)tap{
    mycell = (ShakeTableViewCell *)tap.view;
    NSInteger row = [_tableview indexPathForCell:mycell].row;   //取得选择cell的row
    NSMutableArray *pushArr = [[[NSUserDefaults standardUserDefaults]objectForKey:@"shake"]mutableCopy];
    NSDictionary *dic = [pushArr objectAtIndex:row];    //获取属性传值的字典dic
    detailShakeViewController *detailShake = [[detailShakeViewController alloc]init];
    detailShake.dataDic = dic;
    detailShake.DeviceId = mycell.model.DeviceId;
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:detailShake animated:YES];
    
    detailShake.block= ^(NSDictionary *dic)
    {
        [pushArr removeObjectAtIndex:row];
        [pushArr insertObject:dic atIndex:row];
        [[NSUserDefaults standardUserDefaults]setObject:[pushArr copy] forKey:@"shake"];
    };
    detailShake.jiebangBlock = ^(BOOL issucess)
    {
        if (issucess) {
            [self loadData];
        }
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
