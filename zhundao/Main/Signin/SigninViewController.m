

#import "SigninViewController.h"
#import "signinModel.h"
#import "signinTableViewCell.h"
#import "SaoYiSaoViewController.h"
#import "signinModel.h"
#import "LoadAllSignViewController.h"
#import "LoadallsignModel.h"
#import "NewSignViewController.h"
#import "xiugaisignViewController.h"
#import "ResultsViewController.h"
#import "CodeViewController.h"
#import "ZDActionSheet.h"
#import "SignInViewModel.h"
#import "PostEmailViewController.h"
@interface SigninViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_dataArray;
    NSMutableArray *_dataArray1;
    NSInteger status;
    NSInteger signid;
    Reachability *r;
    signinTableViewCell  *mycell;
    NSMutableArray *signarr;
       NSMutableArray *signarr1;
       NSMutableArray *signarr2;
    NSMutableArray *modelArray;
     NSMutableArray *modelArray1;
    NSInteger xiala;
    NSInteger flag;
    JQIndicatorView *indicator;
}
@property(nonatomic,strong)SignInViewModel *signInViewModel;

@property(nonatomic,assign)BOOL isJuhua;

@end

@implementation SigninViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self baseSetting];
    flag =0;
    [self getPage];
    _isJuhua = NO;
     [_segmented addTarget:self action:@selector(segmentedAction:) forControlEvents:UIControlEventValueChanged];
    [_tableView registerNib:[UINib nibWithNibName:@"signinTableViewCell" bundle:nil] forCellReuseIdentifier:@"signid"];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = NO;
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifi:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
    [self firstload];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadDataWithIsShowIndicator:) name:ZDNotification_Change_Account object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadDataWithIsShowIndicator:) name:ZDUserDefault_Update_Sign object:nil];
}
#pragma  mark ------baseSetting 

- (void)baseSetting
{
    [self.signInViewModel removeObject];
}

#pragma  mark ------懒加载 

- (SignInViewModel *)signInViewModel
{
    if (!_signInViewModel) {
        _signInViewModel = [[SignInViewModel alloc]init];
    }
    return _signInViewModel;
}
- (NSString *)signUrlStr
{
   _signUrlStr =  [NSString stringWithFormat:@"%@api/v2/checkIn/getCheckIns?token=%@",zhundaoApi,[[ZDDataManager shareManager] getToken]];
    return _signUrlStr;
}
#pragma mark ---数据和网络判断
- (void)ishaveArray
{
    NSArray *array1 = [[[ZDDataManager shareManager]getArray:@"signdata"]copy];
    NSArray *array2 = [[[ZDDataManager shareManager]getArray:@"signdata1"]copy];
    if (array1.count==0&&array2.count==0) {
        [self loadDataWithIsShowIndicator:YES];
    }
    else{
        [self loadArray];
    }
}
- (void)firstload
{
   r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
        {
            [self loadArray];
            break;
        }
    
        case ReachableViaWWAN:
             [self reflsh];
            [self ishaveArray];
            break;
        case ReachableViaWiFi:
            [self reflsh];
            [self ishaveArray];
            break;
    }
}
- (void)loadArray
{
    _dataArray = [[[ZDDataManager shareManager]getArray:@"signdata"]mutableCopy];
    _dataArray1 = [[[ZDDataManager shareManager]getArray:@"signdata1"]mutableCopy];
    [_tableView reloadData];
}
- (void)notifi:(NSNotification *)noti{
    NSDictionary *dic = noti.userInfo;
    //获取网络状态
    status = [[dic objectForKey:@"AFNetworkingReachabilityNotificationStatusItem"] integerValue];
    if (status==0){
        [self loadArray];
    }
    else if(status==2||status==1)
    {
         [self reflsh];
    }
    else
    {
        NSLog(@"error");
    }
    
}

#pragma mark -----下拉刷新
- (void)reflsh
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
         __weak typeof (self) weakSelf = self;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        __strong __typeof(self) strongSelf = weakSelf;
        if ((flag==1||flag==0||flag==2)&&(manager.networkReachabilityStatus==AFNetworkReachabilityStatusReachableViaWiFi||manager.networkReachabilityStatus==AFNetworkReachabilityStatusReachableViaWWAN)) {
            
            strongSelf.isJuhua =YES;
            [strongSelf loadDataWithIsShowIndicator:NO];
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
        __strong __typeof(self) strongSelf = weakSelf;
        if ((flag==1||flag==0||flag==2)&&(manager.networkReachabilityStatus==AFNetworkReachabilityStatusReachableViaWiFi||manager.networkReachabilityStatus==AFNetworkReachabilityStatusReachableViaWWAN)) {
             strongSelf.isJuhua =YES;
            [strongSelf loadmoreData];
        }
        else{
            weakSelf.tableView.mj_footer.state = MJRefreshStateNoMoreData;
            
            weakSelf.tableView.mj_header.state = MJRefreshStateNoMoreData;
        }
    }];
}

#pragma mark ---------- 分段
- (void)segmentedAction:(UISegmentedControl *)seg{
    
    NSInteger index = seg.selectedSegmentIndex;
    switch (index) {
        case 0:
        { flag=1;
            [_tableView reloadData];
        }
            break;
            
        case 1:
        {
            flag=2;
            [_tableView reloadData];
        }
            
            break;
        default:
            break;
    }
    
}
#pragma mark ---------网络请求 更多数据
//网络请求
- (void)loadmoreData
{
    xiala += 1;
    [self savePage];
    NSString *xialaStr = [NSString stringWithFormat:@"%li",(long)xiala];
    NSString *listurl =self.signUrlStr;
    NSDictionary *dic = @{@"Type":@"0",
                          @"pageSize":@"10",
                          @"pageIndex":xialaStr};
    [ZD_NetWorkM postDataWithMethod:listurl parameters:dic succ:^(NSDictionary *obj) {
        NSDictionary *result = [NSDictionary dictionaryWithDictionary:obj];
        NSArray *array1 = result[@"data"];
        if (!modelArray) {
            modelArray = [_dataArray mutableCopy];
        }
        if (!modelArray1) {
            modelArray1 = [_dataArray1 mutableCopy];
        }
        for (NSDictionary *acdic in array1) {
            signinModel *model = [signinModel yy_modelWithJSON:acdic];
            if (model.Status==1) {
                [modelArray addObject:model];
            }
            if (model.Status==0) {
                [modelArray1 addObject:model];
            }
        }
        [[ZDDataManager shareManager] saveData:modelArray name:@"signdata"];
        [[ZDDataManager shareManager] saveData:modelArray1 name:@"signdata1"];
        _dataArray = [modelArray mutableCopy];
        _dataArray1 = [modelArray1 mutableCopy];
        [_tableView reloadData];
        if (_isJuhua==YES) {
            if (array1.count<10) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            } else {
                [self.tableView.mj_footer endRefreshing];
            }
            _isJuhua=NO;
        }
    } fail:^(NSError *error) {
        
    }];
}

#pragma mark ------ 获取最新数据
- (void)showindicator{
    indicator= [[JQIndicatorView alloc]initWithType:3 tintColor: [UIColor colorWithRed:9.00f/255.0f green:187.00f/255.0f blue:7.00f/255.0f alpha:1] size:CGSizeMake(90, 70)];
    if (_isJuhua==NO) {
        indicator.center = self.view.center;
        [self.view addSubview:indicator];
        [indicator startAnimating];
    }
}
- (void)loadDataWithIsShowIndicator:(BOOL)isshow    //网络加载数据
{
    xiala = 1;
    [self savePage];
    if (isshow) {
        [self showindicator];
    }
    NSString *listurl =self.signUrlStr;
    NSDictionary *dic = @{@"Type":@"0",
                          @"pageSize":@"10",
                          @"pageIndex":@"1"};
    [ZD_NetWorkM postDataWithMethod:listurl parameters:dic succ:^(NSDictionary *obj) {
        if (_isJuhua==NO&&indicator!=nil) {
            [indicator stopAnimating];
        }
        NSDictionary *result = [NSDictionary dictionaryWithDictionary:obj];
        NSArray *array1 = result[@"data"];
        NSMutableArray *muarray = [NSMutableArray array];
        NSMutableArray *muarray1 = [NSMutableArray array];
        for (NSDictionary *acdic in array1) {
            signinModel *model = [signinModel yy_modelWithJSON:acdic];
            if (model.Status==1) {
                [muarray addObject:model];
            }
            if (model.Status==0) {
                [muarray1 addObject:model];
            }
        }
        if (_isJuhua==NO&&indicator!=nil) {
            [indicator stopAnimating];
        }
        _dataArray = [muarray mutableCopy];
        _dataArray1 = [muarray1 mutableCopy];
        modelArray = [muarray mutableCopy];
        modelArray1 = [muarray1 mutableCopy];
        [[ZDDataManager shareManager]saveData:modelArray name:@"signdata"];
        [[ZDDataManager shareManager]saveData:modelArray1 name:@"signdata1"];
        if (_isJuhua==YES) {
            [self.tableView.mj_header endRefreshing];
            self.tableView.mj_footer.state = MJRefreshStateIdle;
            _isJuhua=NO;
        }
        [_tableView reloadData];
    } fail:^(NSError *error) {
        NSLog(@"error = %@",error);
        if (_isJuhua==YES) {
            [self.tableView.mj_header endRefreshing];
            self.tableView.mj_footer.state = MJRefreshStateIdle;
            _isJuhua=NO;
        }
        if (_isJuhua==NO&&indicator!=nil) {
            [indicator stopAnimating];
        }
    }];
}

- (void)savePage {
    [[NSUserDefaults standardUserDefaults] setInteger:xiala forKey:@"signPage"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)getPage {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"signPage"]) {
        xiala = [[[NSUserDefaults standardUserDefaults] objectForKey:@"signPage"] integerValue];
    } else {
        xiala = 1;
    }
}

#pragma mark --------tableview dataSource 数据源代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (flag==1||flag==0) {
        return _dataArray.count;
    }
    else{
        return _dataArray1.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    signinTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"signid"];
    if (cell==nil) {
        cell = [[signinTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"signid"];
    }
   
    if (flag==1||flag==0) {
        cell.model = _dataArray[indexPath.section];
    }
    if (flag==2) {
        cell.model = _dataArray1[indexPath.section];
    }
    cell.signid  = cell.model.ID;
    [cell getData];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.signcountLabel addTarget:self action:@selector(pushSignList:) forControlEvents:UIControlEventTouchUpInside];
    [cell.switchButton addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
    [cell.signname addTarget:self action:@selector(pushXiuGai:) forControlEvents:UIControlEventTouchUpInside];
    [cell.arrowButton addTarget:self action:@selector(pushXiuGai:) forControlEvents:UIControlEventTouchUpInside];
    if (flag==1||flag==0) {
        [cell.switchButton setOn:YES];
    }
    if (flag==2) {
        [cell.switchButton setOn:NO];
    }
    return  cell;
}

#pragma mark -----tableview delegate  代理
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return 176;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0 ;
    }
    else
    {
        return 10;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    view.backgroundColor = ZDBackgroundColor;
    return  view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (flag==2) {
        if (_dataArray1.count-1==section) {
            return 10;
        }else{
            return 0.1;
        }
    }else{
        if (_dataArray.count-1==section) {
            return 10;
        }else{
            return 0.1;
        }
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    view.backgroundColor =[UIColor clearColor];
    return  view;
}
#pragma mark  --------------手势点击事件
- (void)pushXiuGai:(UIButton *)button
{
    UIResponder *nextResponder = button.nextResponder;
    while (nextResponder) {
        if ([nextResponder isKindOfClass:[UITableViewCell class]]) {
            
            mycell  = (signinTableViewCell *)nextResponder;
            break;
        }
        
        nextResponder = nextResponder.nextResponder;
        
    }
    NSArray *array = @[@"删除签到",@"修改签到",@"微信签到二维码",@"手机号签到二维码",@"导出签到名单"];
    
    ZDActionSheet *sheet = [[ZDActionSheet alloc]initWithTitleArray:array WithRedIndex:1 andShowCancel:YES];
    
    // 2. Block 方式
    __weak typeof(self) weakSelf = self;
    sheet.ClickIndex = ^(NSInteger index){
        NSLog(@"Show Index %zi",index); //取消0
        if (index==1) {
            [weakSelf deleteSign];
        }
       else if (index==2) {
            xiugaisignViewController *xiugai = [[xiugaisignViewController alloc]init];
            xiugai.activityName = mycell.model.ActivityName;
            xiugai.acID = mycell.model.ActivityID;
            xiugai.signID = mycell.model.ID;
            xiugai.xiugaiArray =[self createXiuArray];
            [self setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:xiugai animated:YES];
            [self setHidesBottomBarWhenPushed:NO];           
        }
         // 微信签到二维码
       else if (index==3) {
            CodeViewController *code = [[CodeViewController alloc]init];
            NSString *imagestr =   [NSString stringWithFormat:@"%@ck/%li/%li/3",zhundaoH5Api,(long)mycell.model.ID,(long)mycell.model.ActivityID];
            code.imagestr = imagestr;
            code.titlestr = mycell.model.Name;
            code.labelStr = @"签到";
            [self presentViewController:code animated:YES completion:^{
                
            }];
        }
         // 手机号签到二维码
       else if(index==4){
           CodeViewController *code = [[CodeViewController alloc]init];
           NSString *imagestr =   [NSString stringWithFormat:@"%@ckp/%li/%li/11",zhundaoH5Api,mycell.model.ID,(long)mycell.model.ActivityID];
           code.imagestr = imagestr;
           code.titlestr = mycell.model.Name;
           code.labelStr = @"手机号签到";
           [self presentViewController:code animated:YES completion:^{
               
           }];
       }else{
            // 导出签到名单 
           {
               PostEmailViewController *post = [[PostEmailViewController alloc]init];
               post.signID = mycell.model.ID;
               [self setHidesBottomBarWhenPushed:YES];
               [self.navigationController pushViewController:post animated:YES];
               [self setHidesBottomBarWhenPushed:NO];
           }
       }
    };
    
    [self.view.window addSubview:sheet];
    
}
- (void)deleteSign
{
    MBProgressHUD *hud = [ZDHud initWithAnimationType:MBProgressHUDAnimationFade showAnimated:YES UIView:self.view];
    NSString *str = [NSString stringWithFormat:@"%@api/v2/checkIn/deleteCheckIn?token=%@&checkInId=%li&from=iOS",zhundaoApi,[[ZDDataManager shareManager] getToken],(long)mycell.model.ID];
    [ZD_NetWorkM getDataWithMethod:str parameters:nil succ:^(NSDictionary *obj) {
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:obj];
        NSLog(@"dic = %@",dic);
        [hud hideAnimated:YES];
        MBProgressHUD *hud1 = [ZDHud initWithMode:MBProgressHUDModeCustomView labelText:@"删除成功" showAnimated:YES UIView:self.view imageName:@"签到打勾"];
        [hud1 hideAnimated:YES afterDelay:1.5];
        [[NSNotificationCenter defaultCenter] postNotificationName:ZDUserDefault_Update_Sign object:nil];
    } fail:^(NSError *error) {
        [hud hideAnimated:YES];
    }];
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
- (void)switchChange:(UISwitch *)button
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否改变签到状态" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIResponder *nextResponder = button.nextResponder;
        while (nextResponder) {
            if ([nextResponder isKindOfClass:[UITableViewCell class]]) {
                
                mycell  = (signinTableViewCell *)nextResponder;
                break;
            }
            nextResponder = nextResponder.nextResponder;
        }
        NSString *listurl = [NSString stringWithFormat:@"%@api/CheckIn/UpdateCheckIn?accessKey=%@&checkInId=%li",zhundaoApi,[[ZDDataManager shareManager] getaccseekey],(long)mycell.model.ID];
        
        [ZD_NetWorkM getDataWithMethod:listurl parameters:nil succ:^(NSDictionary *obj) {
            NSIndexPath *indexpath = [_tableView indexPathForCell:mycell];
            if (flag==1||flag==0){
                [_dataArray1 addObject:_dataArray[indexpath.section]];
                [_dataArray removeObjectAtIndex:indexpath.section];
                [_tableView reloadData];
            }
            if (flag==2) {
                [_dataArray addObject:_dataArray1[indexpath.section]];
                [_dataArray1 removeObjectAtIndex:indexpath.section];
                [_tableView reloadData];
            }
            [[ZDDataManager shareManager]saveData:_dataArray name:@"signdata"];
            [[ZDDataManager shareManager]saveData:_dataArray1 name:@"signdata1"];
        } fail:^(NSError *error) {
            
        }];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        button.on = !button.on;
    }]];
    [self presentViewController:alert  animated:YES completion:nil];

}

- (void)pushSignList:(UIButton *)button
{
    UIResponder *nextResponder = button.nextResponder;
    while (nextResponder) {
        if ([nextResponder isKindOfClass:[UITableViewCell class]]) {
            
            mycell  = (signinTableViewCell *)nextResponder;
            break;
        }
        nextResponder = nextResponder.nextResponder;
    }
    LoadAllSignViewController *load = [[LoadAllSignViewController alloc]init];
    load.activityID = mycell.model.ActivityID;
    load.signID = mycell.model.ID;
    load.signName = mycell.model.Name;
    load.signNumber = mycell.model.NumShould;
    [self setHidesBottomBarWhenPushed:YES];
    
    [self.navigationController pushViewController:load animated:YES];
    
    load.block = ^(NSInteger a)
    {
        [self loadDataWithIsShowIndicator:NO];
    };
    [self setHidesBottomBarWhenPushed:NO];
    
}
#pragma mark ------去出tableview 黏性
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
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.view.backgroundColor = ZDBackgroundColor;
    [_tableView reloadData];
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
