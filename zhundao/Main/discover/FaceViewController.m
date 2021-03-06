//
//  FaceViewController.m
//  zhundao
//
//  Created by zhundao on 2017/7/21.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "FaceViewController.h"
#import "FaceViewModel.h"
#import "ShakeTableViewCell.h"
#import "FaceDetailViewController.h"
@interface FaceViewController ()<UITableViewDelegate,UITableViewDataSource>{
    Reachability *r;;
}
@property(nonatomic,strong)UITableView *tableView ;

@property(nonatomic,strong)FaceViewModel *faceVM;

@property(nonatomic,strong)NSMutableArray *deviceArray ;

@property(nonatomic,strong)UILabel *nullDataLabell;
@property(nonatomic,strong)UIImageView *nullImageView ;

@end

@implementation FaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"人脸签到";
    [self.view addSubview:self.tableView];
    [self getData];
    // Do any additional setup after loading the view.
}
#pragma mark -------是否有网
- (void)firstload{
    r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:{
            if ([[NSUserDefaults standardUserDefaults]objectForKey:@"faceArray"]) {
                _deviceArray = [[self.faceVM getData]mutableCopy];
             }
            [_tableView reloadData];
            [self shownull];
            break;
        }
        case ReachableViaWWAN:
            [self getData];
            break;
        case ReachableViaWiFi:
            [self getData];
            break;
    }
}
#pragma mark 懒加载    

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.backgroundColor = ZDBackgroundColor;
        _tableView.sectionHeaderHeight = 0.1;
        _tableView.sectionFooterHeight = 30;
        _tableView.rowHeight = 70;
        [_tableView registerNib:[UINib nibWithNibName:@"ShakeTableViewCell" bundle:nil] forCellReuseIdentifier:@"shakeID"];
    }
    return _tableView;
}

-(FaceViewModel *)faceVM{
    if (!_faceVM) {
        _faceVM = [[FaceViewModel alloc]init];
    }
    return _faceVM;
}
- (NSMutableArray *)deviceArray{
    if (!_deviceArray) {
        _deviceArray = [NSMutableArray array];
    }
    return _deviceArray;
}
- (UILabel *)nullDataLabell{
    if (!_nullDataLabell) {
        _nullDataLabell =[self showNullLabelWithText:@"请添加微信号”izhundao”发送“人脸签到”关键词了解更多" WithTextColor:[UIColor lightGrayColor]];
        _nullDataLabell.numberOfLines = 0;
    }
    return _nullDataLabell;
}
- (void)shownull{
    if (_deviceArray.count==0&&_nullDataLabell==nil) {
        _nullImageView =  [self showNullImage];
        [self.view addSubview:self.nullDataLabell];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:_nullDataLabell.text];
        [str addAttribute:NSForegroundColorAttributeName value:kColorA(98, 167, 245, 1) range:[_nullDataLabell.text rangeOfString:@"izhundao"]];
        [str addAttribute:NSForegroundColorAttributeName value:kColorA(98, 167, 245, 1) range:[_nullDataLabell.text rangeOfString:@"人脸签到"]];
        _nullDataLabell.attributedText = str;
    }
    if (_deviceArray.count>0&&_nullDataLabell!=nil) {
        [_nullDataLabell removeFromSuperview];
        [_nullImageView removeFromSuperview];
    }
}

#pragma mark -------UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _deviceArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *faceID = @"shakeID";
    ShakeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:faceID];
    if (!cell) {
        cell = [[ShakeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:faceID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.faceModel = _deviceArray[indexPath.row];
    return cell;
}
#pragma mark -------UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FaceDetailViewController *faceDetail = [[FaceDetailViewController alloc]init];
    faceDetail.model = _deviceArray[indexPath.row];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:faceDetail animated:YES];
    __weak typeof(self) weakSelf = self;
    faceDetail.faceBlock = ^(BOOL ischange) {
        if (ischange) {
            [weakSelf getData];
        }
    };
}



#pragma mark -------获取数据 
- (void)getData{
    [self.deviceArray removeAllObjects];
    [self.faceVM getListWithBlock:^(NSArray *dataArray) {
        NSLog(@"dic1 = %@",dataArray);
            for (NSDictionary *dic in dataArray) {
                FaceModel *model = [FaceModel yy_modelWithJSON:dic];
                [self.deviceArray addObject:model];
            }
            if(dataArray.count>0)  [_faceVM saveData:_deviceArray];
            [_tableView reloadData];
            [self shownull];
    }];
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
