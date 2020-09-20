//
//  ZDAvtivityOneActivityVC.m
//  zhundao
//
//  Created by zhundao on 2017/3/21.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ZDAvtivityOneActivityVC.h"
//#import "ZDSignInSigninModel.h"
#import "ZDSignInSigninCell.h"
#import "ZDSaoYiSaoViewController.h"
#import "ZDSignInLoadallsignModel.h"
#import "ZDSignInXIugaisignVC.h"
#import "ZDSignInLoadAllSignVC.h"
#import "ZDSignInNewSignVC.h"
#import "ZDAvtivityPostSignVC.h"
#import "GZActionSheet.h"
#import "ZDAvtivityCodeVC.h"
#import "ZDActivityPostEmailVC.h"
@interface ZDAvtivityOneActivityVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger xiala;
    NSString *accesskey;
       Reachability *r;
     ZDSignInSigninCell  *mycell;
}
@property (strong, nonatomic) UITableView *tableView;
@property(nonatomic,strong)NSString *signUrlStr;//  网络请求url
@property(nonatomic,strong)NSMutableArray *dataarr;//本地的存储数组
@property(nonatomic,strong)NSMutableArray *dataArray; //tableview 的array
@property(nonatomic,strong)NSMutableArray *signarr; //扫码数组
@property(nonatomic,strong)NSMutableArray *signarr1;//扫码数组
@property(nonatomic,strong)NSMutableArray *signarr2;//扫码数组
@property(nonatomic,strong)NSMutableArray *modelArray;//上拉的model数组
@property(nonatomic,assign)BOOL isJuhua;
@end

@implementation ZDAvtivityOneActivityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    xiala=1;
    _isJuhua = NO;
    self.title = @"签到";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem activityAddItemWithTarget:self action:@selector(ZDSign)];
    accesskey = [[ZDSignManager shareManager]getaccseekey];
    self.view.backgroundColor = ZDBackgroundColor;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:ZDUserDefault_Update_Sign object:nil];
    [self createtableview];
    [self firstload];
    // Do any additional setup after loading the view.
}

#pragma mark 懒加载

- (NSMutableArray *)dataarr
{
    if (!_dataarr) {
        _dataarr = [NSMutableArray array];
    }
    return _dataarr;
}
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (NSMutableArray *)signarr
{
    if (!_signarr) {
        _signarr = [NSMutableArray array];
    }return _signarr;
}
- (NSMutableArray *)signarr1
{
    if (!_signarr1) {
        _signarr1 = [NSMutableArray array];
    }return _signarr1;
}
- (NSMutableArray *)signarr2
{
    if (!_signarr2) {
        _signarr2 = [NSMutableArray array];
    }return _signarr2;
}
- (void)ZDSign
{
    ZDAvtivityPostSignVC *one = [[ZDAvtivityPostSignVC alloc]init];
    [self setHidesBottomBarWhenPushed:YES];
    one.activityName = self.activityName;
    one.acID = self.acID;
    [self.navigationController pushViewController:one animated:YES];
}

- (void)createtableview
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    [_tableView registerNib:[UINib nibWithNibName:@"ZDSignInSigninCell" bundle:nil] forCellReuseIdentifier:@"signid"];
    _tableView.separatorStyle = NO;
    _tableView.delegate =self;
    _tableView.backgroundColor = ZDBackgroundColor;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}
- (void)firstload
{
    r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            NSLog(@"wu");
        {
            [self loadArray];
            break;
        }
            
        case ReachableViaWWAN:
            // 使用3G网络
            NSLog(@"wan");
             [self reflsh];
            [self ishaveArray];
            
            
            
            break;
        case ReachableViaWiFi:
            // 使用WiFi网络
            NSLog(@"wifi");
             [self reflsh];
            [self ishaveArray];
            
            
            break;
    }
}
- (void)reflsh
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    __weak typeof (self) weakSelf = self;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if ((manager.networkReachabilityStatus==AFNetworkReachabilityStatusReachableViaWiFi||manager.networkReachabilityStatus==AFNetworkReachabilityStatusReachableViaWWAN)) {
             __strong __typeof(self) strongSelf = weakSelf;
            strongSelf.isJuhua =YES;
            [strongSelf loadData];
        }
        else{
            weakSelf.tableView.mj_footer.state = MJRefreshStateNoMoreData;
            weakSelf.tableView.mj_header.state = MJRefreshStateNoMoreData;
            
            weakSelf.tableView.mj_header.hidden = YES;
            weakSelf.tableView.mj_insetT=0;
        }
    }];
    self.tableView.mj_header = header;
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"释放刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"加载中，请等待 ..." forState:MJRefreshStateRefreshing];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if ((manager.networkReachabilityStatus==AFNetworkReachabilityStatusReachableViaWiFi||manager.networkReachabilityStatus==AFNetworkReachabilityStatusReachableViaWWAN)) {
              __strong __typeof(self) strongSelf = weakSelf;
            strongSelf.isJuhua=YES;
            [strongSelf loadmoreData];
        }
        else{
            weakSelf.tableView.mj_footer.state = MJRefreshStateNoMoreData;
            weakSelf.tableView.mj_header.state = MJRefreshStateNoMoreData;
        }
    }];
}
- (void)loadmoreData
{
    xiala++;
    NSString *xialaStr = [NSString stringWithFormat:@"%li",(long)xiala];
    NSString *listurl =self.signUrlStr;
    NSDictionary *dic = @{@"Type":@"0",
                          @"pageSize":@"10",
                          @"curPage":xialaStr,
                           @"ID":@(self.acID)};
    [ZD_NetWorkM postDataWithMethod:listurl parameters:dic succ:^(NSDictionary *obj) {
        NSDictionary *result = [NSDictionary dictionaryWithDictionary:obj];
        NSArray *array1 = result[@"Data"];
        _dataarr = [[[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"oneActivity%li",(long)self.acID]] mutableCopy];
        if (!_modelArray) {
            _modelArray = [self.dataArray mutableCopy];
        }
        for (NSDictionary *acdic in array1) {
            ZDSignInModel *model = [ZDSignInModel yy_modelWithJSON:acdic];
            
            [_modelArray addObject:model];
            NSMutableDictionary *e = [NSMutableDictionary dictionary];
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
            [_dataarr addObject:e];
        }
        
        [[NSUserDefaults standardUserDefaults]setObject:_dataarr forKey:[NSString stringWithFormat:@"oneActivity%li",(long)self.acID]];
        
        [[NSUserDefaults standardUserDefaults]synchronize];
        _dataArray = [_modelArray mutableCopy];
        
        if (_isJuhua==YES) {
            [self.tableView.mj_footer endRefreshing];
            if (array1.count<20) {
                self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
                xiala=1;
            }
            _isJuhua=NO;
        }
        
        [_tableView reloadData];
    } fail:^(NSError *error) {
        
    }];
}
- (void)ishaveArray {
    [self loadData];
}

- (void)loadArray
{
    NSMutableArray *muarray = [NSMutableArray array];
    NSArray *array1 = [[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"oneActivity%li",(long)self.acID]];
    for (NSDictionary *acdic in array1) {
        ZDSignInModel *model = [ZDSignInModel yy_modelWithJSON:acdic];
        [muarray addObject:model];
    }
    _dataArray = [muarray mutableCopy];
    
    [_tableView reloadData];
    [self shownull:_dataArray WithText:@"暂时没有签到哦，请在右上方添加" WithTextColor:[UIColor lightGrayColor]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{if (scrollView == _tableView) {
    CGFloat sectionHeaderHeight = 10;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }
    else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}
}
- (NSString *)signUrlStr
{
        _signUrlStr =  [NSString stringWithFormat:@"%@api/CheckIn/PostCheckIn?accessKey=%@",zhundaoApi,accesskey];
    return _signUrlStr;
}

- (void)loadData    //网络加载数据
{    JQIndicatorView *indicator = [[JQIndicatorView alloc]initWithType:3 tintColor: [UIColor colorWithRed:9.00f/255.0f green:187.00f/255.0f blue:7.00f/255.0f alpha:1] size:CGSizeMake(90, 70)];
    if (_isJuhua==NO) {
        indicator.center = self.view.center;
        [self.view addSubview:indicator];
        [indicator startAnimating];
    }
    NSString *listurl =self.signUrlStr;
    NSDictionary *dic = @{@"Type":@"0",
                          @"pageSize":@"10",
                          @"curPage":@"1",
                          @"ID":@(self.acID)};
    [ZD_NetWorkM postDataWithMethod:listurl parameters:dic succ:^(NSDictionary *obj) {
        if (_isJuhua==NO) {
            [indicator stopAnimating];
        }
        NSDictionary *result = [NSDictionary dictionaryWithDictionary:obj];
        NSArray *array1 = result[@"Data"];
        _dataarr = [NSMutableArray array];
        NSMutableArray *muarray = [NSMutableArray array];
        for (NSDictionary *acdic in array1) {
            ZDSignInModel *model = [ZDSignInModel yy_modelWithJSON:acdic];
            [muarray addObject:model];
            NSMutableDictionary *e = [NSMutableDictionary dictionary];
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
            [self.dataarr addObject:e];
        }
        
        if (_isJuhua==NO) {
            [indicator stopAnimating];
        }
        [[NSUserDefaults standardUserDefaults]setObject:_dataarr forKey:[NSString stringWithFormat:@"oneActivity%li",(long)self.acID]];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        _dataArray = [muarray mutableCopy];
        
        _modelArray = [muarray mutableCopy];
        
        if (_isJuhua==YES) {
            [self.tableView.mj_header endRefreshing];
            self.tableView.mj_footer.state = MJRefreshStateIdle;
            _isJuhua=NO;
        }
        [_tableView reloadData];
        [self shownull:_dataArray WithText:@"暂时没有签到哦，请在右上方添加!" WithTextColor:[UIColor lightGrayColor]];
    } fail:^(NSError *error) {
        NSLog(@"error = %@",error);
        if (_isJuhua==YES) {
            [self.tableView.mj_header endRefreshing];
            self.tableView.mj_footer.state = MJRefreshStateIdle;
            _isJuhua=NO;
        }
        if (_isJuhua==NO) {
            [indicator stopAnimating];
        }
    }];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
        return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZDSignInSigninCell *cell = [tableView dequeueReusableCellWithIdentifier:@"signid"];
    if (cell==nil) {
        cell = [[ZDSignInSigninCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"signid"];
    }
    cell.model = _dataArray[indexPath.section];
    cell.signid  = cell.model.ID;
    [cell getData];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.signcountLabel addTarget:self action:@selector(pushSignList:) forControlEvents:UIControlEventTouchUpInside];
    [cell.switchButton addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventTouchUpInside];
    [cell.signname addTarget:self action:@selector(pushXiuGai:) forControlEvents:UIControlEventTouchUpInside];
     [cell.arrowButton addTarget:self action:@selector(pushXiuGai:) forControlEvents:UIControlEventTouchUpInside];
    if (cell.model.Status==1) {
        [cell.switchButton setOn:YES];
    }
    if (cell.model.Status==0) {
        [cell.switchButton setOn:NO];
    }
    return  cell;
}
- (void)pushXiuGai:(UIButton *)button
{
    UIResponder *nextResponder = button.nextResponder;
    while (nextResponder) {
        if ([nextResponder isKindOfClass:[UITableViewCell class]]) {
            
            mycell  = (ZDSignInSigninCell *)nextResponder;
            break;
        }
        
        nextResponder = nextResponder.nextResponder;
        
    }
    NSArray *array = @[@"删除签到",@"修改签到",@"微信签到二维码",@"手机号签到二维码",@"导出签到名单"];
   
    GZActionSheet *sheet = [[GZActionSheet alloc]initWithTitleArray:array WithRedIndex:1 andShowCancel:YES];
    
    // 2. Block 方式
    __weak typeof(self) weakSelf = self;
    sheet.ClickIndex = ^(NSInteger index){
        NSLog(@"Show Index %zi",index); //取消0
        if (index==1) {
              [weakSelf deleteSign];
            
        }
       else if (index==2) {
            ZDSignInXIugaisignVC *xiugai = [[ZDSignInXIugaisignVC alloc]init];
            xiugai.activityName = mycell.model.ActivityName;
            xiugai.acID = mycell.model.ActivityID;
            xiugai.signID = mycell.model.ID;
            xiugai.xiugaiArray =[self createXiuArray];
            [self setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:xiugai animated:YES];
        }
        // 微信签到二维码
       else if (index==3) {
           ZDAvtivityCodeVC *code = [[ZDAvtivityCodeVC alloc]init];
           NSString *imagestr =   [NSString stringWithFormat:@"%@ck/%li/%li/3",zhundaoH5Api,(long)mycell.model.ID,(long)mycell.model.ActivityID];
           code.imagestr = imagestr;
           code.titlestr = mycell.model.Name;
           code.labelStr = @"签到";
           [self presentViewController:code animated:YES completion:^{
               
           }];
       }
        // 手机号签到二维码
       else if(index==4){
           ZDAvtivityCodeVC *code = [[ZDAvtivityCodeVC alloc]init];
           NSString *imagestr =   [NSString stringWithFormat:@"%@ckp/%li/%li/11",zhundaoH5Api,mycell.model.ID,(long)mycell.model.ActivityID];
           code.imagestr = imagestr;
           code.titlestr = mycell.model.Name;
           code.labelStr = @"手机号签到";
           [self presentViewController:code animated:YES completion:^{
               
           }];
       } else{
           ZDActivityPostEmailVC *post = [[ZDActivityPostEmailVC alloc]init];
           post.signID = mycell.model.ID;
           [self setHidesBottomBarWhenPushed:YES];
           [self.navigationController pushViewController:post animated:YES];
           [self setHidesBottomBarWhenPushed:NO];
       }
    };
    
    [self.view.window addSubview:sheet];

}
- (NSArray *)createXiuArray
{
    NSArray *array1 = @[@"限报名人员",@"不限报名人员"];
    if (mycell.model.Name.length>0) {
        return @[mycell.model.Name,
                 [NSString stringWithFormat:@"%@",mycell.model.ActivityName],
                 [array1 objectAtIndex:mycell.model.SignObject]
                 ];
    }
    else{
        return @[[NSString stringWithFormat:@"%@[签到]",mycell.model.ActivityName],
                 [NSString stringWithFormat:@"%@",mycell.model.ActivityName],
                 [array1 objectAtIndex:mycell.model.SignObject]
                 ];
    }
}
- (void)deleteSign
{
    MBProgressHUD *hud = [ZDMyHud initWithAnimationType:MBProgressHUDAnimationFade showAnimated:YES UIView:self.view];
    NSString *str = [NSString stringWithFormat:@"%@api/v2/checkIn/deleteCheckIn?token=%@&checkInId=%li&from=iOS",zhundaoApi,[[ZDSignManager shareManager] getToken],(long)mycell.model.ID];
    [ZD_NetWorkM getDataWithMethod:str parameters:nil succ:^(NSDictionary *obj) {
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:obj];
        NSLog(@"dic = %@",dic);
        [hud hideAnimated:YES];
        MBProgressHUD *hud1 = [ZDMyHud initWithMode:MBProgressHUDModeCustomView labelText:@"删除成功" showAnimated:YES UIView:self.view imageName:@"签到打勾"];
        [hud1 hideAnimated:YES afterDelay:1.5];
        [[NSNotificationCenter defaultCenter] postNotificationName:ZDUserDefault_Update_Sign object:nil];
    } fail:^(NSError *error) {
        [hud hideAnimated:YES];
        NSLog(@"error = %@",error);
    }];
}

- (void)switchChange:(UISwitch *)button
{
     UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否改变签到状态" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIResponder *nextResponder = button.nextResponder;
        while (nextResponder) {
            if ([nextResponder isKindOfClass:[UITableViewCell class]]) {
                
                mycell  = (ZDSignInSigninCell *)nextResponder;
                break;
            }
            
            nextResponder = nextResponder.nextResponder;
            
        }
        NSString *listurl = [NSString stringWithFormat:@"%@api/CheckIn/UpdateCheckIn?accessKey=%@&checkInId=%li",zhundaoApi,accesskey,(long)mycell.model.ID];
        
        [ZD_NetWorkM getDataWithMethod:listurl parameters:nil succ:^(NSDictionary *obj) {
            
        } fail:^(NSError *error) {
            
        }];
        [self changeModelswitchButton:mycell.switchButton];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        button.on = !button.on;
    }]];
    [self presentViewController:alert  animated:YES completion:nil];
}

- (void)changeModelswitchButton :(UISwitch *)switchButton{
    NSString *changeStr = nil;
    if (switchButton.on) {
        changeStr = @"1";
    }
    else{
        changeStr = @"0";
    }
    NSInteger section = [_tableView indexPathForCell:mycell].section;
    NSArray *array1 = [[NSUserDefaults standardUserDefaults]objectForKey:[[NSString stringWithFormat:@"oneActivity%li",(long)self.acID]copy]];
    NSMutableDictionary *changeDic = [[array1 objectAtIndex:section]mutableCopy];
    [changeDic setObject:changeStr forKey:@"Status"];
    NSMutableArray *array2 = [array1 mutableCopy];
    [array2 removeObjectAtIndex:section];            //修改本地数据
    [array2 insertObject:changeDic atIndex:section];
    [[NSUserDefaults standardUserDefaults]setObject:[array2 copy]  forKey:[[NSString stringWithFormat:@"oneActivity%li",(long)self.acID]copy]];
    [[NSUserDefaults standardUserDefaults]synchronize];
    ZDSignInModel *model = [ZDSignInModel yy_modelWithDictionary:[changeDic copy] ];
    [_dataArray removeObjectAtIndex:section];   //修改——dataarray ，防止滑动改变
    [_dataArray insertObject:model atIndex:section];
}




- (void)pushSignList:(UIButton *)button
{
    UIResponder *nextResponder = button.nextResponder;
    while (nextResponder) {
        if ([nextResponder isKindOfClass:[UITableViewCell class]]) {
            
            mycell  = (ZDSignInSigninCell *)nextResponder;
            break;
        }
        
        nextResponder = nextResponder.nextResponder;
        
    }
    ZDSignInLoadAllSignVC *load = [[ZDSignInLoadAllSignVC alloc]init];
    load.signID = mycell.model.ID;
    load.activityID = mycell.model.ActivityID;
    load.signName = mycell.model.Name;
    load.signNumber = mycell.model.NumShould;
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:load animated:YES];
    load.block = ^(NSInteger a)
    {
        [self loadData];
    };
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return 176;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 20 ;
    }
    else
    {
        return 10;
    }
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_tableView reloadData];
}
- (void)dealloc{
    NSLog(@"没有内存泄露");
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
