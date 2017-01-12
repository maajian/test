//
//  LoadAllSignViewController.m
//  zhundao
//
//  Created by zhundao on 2016/12/20.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import "LoadAllSignViewController.h"
#import "LoadallsignModel.h"
#import "LoadAllSignTableViewCell.h"
#import "Reachability.h"
@interface LoadAllSignViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableview;
    NSString *accesskey;
    NSArray *_dataArray;
    NSMutableArray *dataarr;
    NSArray *_dataArray1;
    NSMutableArray *dataarr1;
    NSArray *_dataArray2;
    NSMutableArray *dataarr2;
    NSInteger flag;
     Reachability *r;
}
@property(nonatomic,strong)UIButton *starButton;
@end

@implementation LoadAllSignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    flag=0;
    self.title = @"签到名单";
    SignManager *manager = [SignManager shareManager];
    [manager createDatabase];
    accesskey = [manager getaccseekey];
    
    [self createTableView];
    [self firstload];
    
}

- (void)firstload
{
    r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            NSLog(@"wu");
            
        {
            NSMutableArray *muarray = [NSMutableArray array];
            NSArray *array1 = [[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"all%li",(long)_signID]];

            for (NSDictionary *acdic in array1) {
                LoadallsignModel *model = [LoadallsignModel yy_modelWithJSON:acdic];
                [muarray addObject:model];
            }
            _dataArray = [muarray mutableCopy];
            
            NSMutableArray *muarray1 = [NSMutableArray array];
            NSArray *array2 = [[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"signed%li",(long)_signID]];
            for (NSDictionary *acdic in array2) {
                LoadallsignModel *model = [LoadallsignModel yy_modelWithJSON:acdic];
                [muarray1 addObject:model];
            }
            _dataArray1 = [muarray1 mutableCopy];
            
            NSMutableArray *muarray2 = [NSMutableArray array];
            NSArray *array3 = [[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"sign%li",(long)_signID]];
            for (NSDictionary *acdic in array3) {
                LoadallsignModel *model = [LoadallsignModel yy_modelWithJSON:acdic];
                [muarray2 addObject:model];
            }
            _dataArray2 = [muarray2 mutableCopy];
            [_tableview reloadData];
            
//            self.netWorkingStatus=0;
            
            break;
        }
            
        case ReachableViaWWAN:
            // 使用3G网络
            NSLog(@"wan");
            [self loadData];
//            self.netWorkingStatus=1;
            break;
        case ReachableViaWiFi:
            // 使用WiFi网络
            NSLog(@"wifi");
            [self loadData];
//            self.netWorkingStatus=1;
            break;
    }
}
-(void)dealloc
{
    NSLog(@"dealloc");
}
- (void)loadData    //网络加载数据
{
    JQIndicatorView *indicator = [[JQIndicatorView alloc]initWithType:3 tintColor: [UIColor colorWithRed:9.00f/255.0f green:187.00f/255.0f blue:7.00f/255.0f alpha:1] size:CGSizeMake(90, 70)];
    indicator.center = self.view.center;
    [self.view addSubview:indicator];
    [indicator startAnimating];
    NSString *listurl = [NSString stringWithFormat:@"https://open.zhundao.net/api/CheckIn/PostCheckInList?accessKey=%@",accesskey];
    AFHTTPSessionManager *manager = [AFmanager shareManager];
    NSDictionary *dic = @{@"Type":@"0",
                          @"ID":[NSString stringWithFormat:@"%li",(long)_signID],
                          @"pageSize":@"10000",
                          @"curPage":@"1"};
    [manager POST:listurl parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSDictionary *result = [NSDictionary dictionaryWithDictionary:responseObject];
        [self createSignList];
        NSArray *array1 = result[@"Data"];
        NSMutableArray *muarray = [NSMutableArray array];
        NSMutableArray *muarray1 = [NSMutableArray array];
             NSMutableArray *muarray2 = [NSMutableArray array];
        dataarr = [NSMutableArray array];
        dataarr1 = [NSMutableArray array];
        dataarr2 = [NSMutableArray array];
        SignManager *manager = [SignManager shareManager];
        if ([manager.dataBase open]) {
//            NSString *updateSql = [NSString stringWithFormat:@"DROP TABLE signList"];
//            BOOL res = [manager.dataBase executeUpdate:updateSql];
      
        for (NSDictionary *acdic in array1) {
            LoadallsignModel *model = [LoadallsignModel yy_modelWithJSON:acdic];
            NSMutableDictionary *e = [NSMutableDictionary dictionary];
       
            NSString *insertSql =[NSString stringWithFormat:@"INSERT INTO signList(vcode, signID,Status)VALUES('%@',%li,%li)",model.VCode,(long)_signID,(long)model.Status];
            BOOL res = [manager.dataBase executeUpdate:insertSql];
            if (res) {
                NSLog(@"数据表插入成功");
            }
            else
            {
                NSLog(@"数据表插入失败");
            }
            
            
            
            for (NSString *keystr in acdic.allKeys) {
                
                if ([[acdic objectForKey:keystr] isEqual:[NSNull null]]) {
                    //
                    [e setObject:@"" forKey:keystr];
                }
                else
                {
                    [e setObject:[acdic objectForKey:keystr] forKey:keystr];
                }
            }
                [muarray addObject:model];
            
            if (model.Status==1) {              //签到完成的
                [muarray1 addObject:model];
                [dataarr1 addObject:e];
            }
            if (model.Status==0) {           //还未到场的
                [muarray2 addObject:model];
                [dataarr2 addObject:e];
            }
            
        [dataarr addObject:e];
        }
            [manager.dataBase close];
        }
        [[NSUserDefaults standardUserDefaults]setObject:dataarr forKey:[NSString stringWithFormat:@"all%li",(long)_signID]];
          [[NSUserDefaults standardUserDefaults]setObject:dataarr2 forKey:[NSString stringWithFormat:@"sign%li",(long)_signID]];
        [[NSUserDefaults standardUserDefaults]setObject:dataarr1 forKey:[NSString stringWithFormat:@"signed%li",(long)_signID]];
        [[NSUserDefaults standardUserDefaults]synchronize];
        _dataArray = [muarray copy];
        _dataArray1 = [muarray1 copy];
        _dataArray2 = [muarray2 copy];
        
        
       
        
        [indicator stopAnimating];
        [_tableview reloadData];
     
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
    
}
- (void)createSignList
{
    SignManager *manager = [SignManager shareManager];
    if ([manager.dataBase open]) {
        bool result = [manager.dataBase executeUpdate:@"CREATE TABLE IF NOT EXISTS signList(listid integer PRIMARY KEY AUTOINCREMENT,vcode TEXT NOT NULL,signID integer NOT NULL,Status integer,post integer DEFAULT 2);"];
        if (result) {
            NSLog(@"成功创建table");
        }
        else
        {
            NSLog(@"创建table失败");
        }
        [manager.dataBase close];
        
    }
}
- (void)createTableView
{
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
    [_tableview registerNib:[UINib nibWithNibName:@"LoadAllSignTableViewCell" bundle:nil] forCellReuseIdentifier:@"loadID"];
    _tableview.delegate = self ;
    _tableview.dataSource = self;
    _tableview.separatorStyle = NO;
    _tableview.backgroundColor = [UIColor colorWithRed:235.00f/255.00f green:235.00f/255.00f blue:235.00f/255.00f alpha:1];
    [self.view addSubview:_tableview];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (flag==0) {
         return _dataArray.count;
    }
    if (flag==1) {
        return _dataArray1.count;
    }
    if (flag==2) {
        return _dataArray2.count;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LoadAllSignTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"loadID"];
    if (cell==nil) {
        cell = [[LoadAllSignTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"loadID"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (flag==0) {
         cell.model = _dataArray[indexPath.row];
    }
    if (flag==1) {
        cell.model = _dataArray1[indexPath.row];
    }
    if (flag==2) {
        cell.model = _dataArray2[indexPath.row];
    }
    if (cell.model.Status==0) {
        cell.checkLabel.image = [ UIImage imageNamed:@"check"];
    }if (cell.model.Status==1) {
        cell.checkLabel.image = [ UIImage imageNamed:@"checked"];
        cell.nameLabel.frame = CGRectMake(0, 20, 100, 100);
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(callphone:)];
    cell.phoneLabel.userInteractionEnabled = YES;
    [cell.phoneLabel  addGestureRecognizer:tap];
    return cell;
}
- (void)callphone:(UITapGestureRecognizer *)tap
{
    LoadAllSignTableViewCell *cell = (LoadAllSignTableViewCell *) tap.view.superview.superview;
    NSString *str2 = [NSString stringWithFormat:@"tel:%@",cell.model.Mobile];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str2]]];
    [self.view addSubview:callWebview];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 60;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    float buttonWeith = kScreenWidth/3;
    for ( int i=0; i<3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*buttonWeith, 0, buttonWeith, 44);
        button.backgroundColor = [UIColor whiteColor];
        button.layer.borderWidth = 0.5;
        button.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, buttonWeith, 44)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:13];
        if (i==0) {
            //            label.text = [NSString stringWithFormat:@""]
            label.text = [NSString stringWithFormat:@"全部(%li)",(unsigned long)_dataArray.count];
            if (flag==0) {
                _starButton= button;
                
                button.backgroundColor = [UIColor colorWithRed:236.00f/255.0f green:236.00f/255.0f blue:236.00f/255.0f alpha:1];
            }
        }
        if (i==1) {
            label.text = [NSString stringWithFormat:@"签到人员(%li)",(unsigned long)_dataArray1.count];
            if (flag==1) {
                _starButton= button;
                
                button.backgroundColor = [UIColor colorWithRed:236.00f/255.0f green:236.00f/255.0f blue:236.00f/255.0f alpha:1];
            }
            
        } if (i==2) {
            label.text = [NSString stringWithFormat:@"未签到人员(%li)",(unsigned long)_dataArray2.count];
            if (flag==2) {
                _starButton= button;
                
                button.backgroundColor =  [UIColor colorWithRed:236.00f/255.0f green:236.00f/255.0f blue:236.00f/255.0f alpha:1];
            }
        }
        
        [button addSubview:label];
        [button addTarget:self  action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 100+i;
        [view1 addSubview:button];
    }
    return view1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}
- (void)buttonAction:(UIButton *)button
{
    if (button!=_starButton) {
         self.starButton.backgroundColor = [UIColor whiteColor];
        self.starButton.selected = NO;
        self.starButton = button;
    

    }
    else{
        self.starButton.selected=YES;
    }
    
    if (!self.starButton.selected) {
        self.starButton.backgroundColor = [UIColor redColor];

       
    }
    if (button.tag==100) {
        flag=0;
        [_tableview reloadData];
    }
    if (button.tag==101) {
        flag=1;
        [_tableview reloadData];
    }
    if (button.tag==102) {
        flag=2;
        [_tableview reloadData];
    }
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
