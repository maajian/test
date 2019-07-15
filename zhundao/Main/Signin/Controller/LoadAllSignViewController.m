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
#import "ResultsViewController.h"
#import "signResult.h"
#import "PostSign.h"
#import "SaoYiSaoViewController.h"
#import "UpDataViewController.h"
#import "OnePersonDataNetWork.h"
#import "SignleListViewController.h"
#import "PrintVM.h"
@interface LoadAllSignViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchControllerDelegate>
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
    ResultsViewController *resultsController;
    NSInteger backNumber ;
    LoadAllSignTableViewCell *myCell;
}
@property(nonatomic,strong)UIButton *starButton;
@property(nonatomic,strong)UILabel *starLabel;
@property (nonatomic, retain) UISearchController *searchController;
@property(nonatomic,strong)OnePersonDataNetWork *oneVM;
@end

@implementation LoadAllSignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    flag=0;
    backNumber = 0;
    [self setNavTitle];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem scanItemWithTarget:self action:@selector(pushScan)];
    SignManager *manager = [SignManager shareManager];
    [manager createDatabase];
    accesskey = [manager getaccseekey];
    self.definesPresentationContext = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self createTableView];
    [self firstload];
    self.view.backgroundColor = zhundaoBackgroundColor;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _tableview.backgroundColor = zhundaoBackgroundColor;
}

#pragma mark ----- 懒加载
- (OnePersonDataNetWork *)oneVM{
    if (!_oneVM) {
        _oneVM = [[OnePersonDataNetWork alloc]init];
    }
    return _oneVM;
}

- (void)setNavTitle
{
    UILabel *label = [MyLabel initWithLabelFrame:CGRectMake(0, 0, 44, 44) Text:_signName textColor:[UIColor blackColor] font:KHeitiSCMedium(17) textAlignment:NSTextAlignmentCenter cornerRadius:0 masksToBounds:0];
    self.navigationItem.titleView = label;
}
- (void)pushScan
{
    SaoYiSaoViewController *sao = [[SaoYiSaoViewController alloc] init];
    sao.signID = self.signID;
    [self presentViewController:sao animated:YES completion:nil];
}
- (void)reflsh
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    BOOL isfresh = NO ;
    if (manager.networkReachabilityStatus==AFNetworkReachabilityStatusReachableViaWiFi||manager.networkReachabilityStatus==AFNetworkReachabilityStatusReachableViaWWAN) {
        isfresh = YES;
    }
    __weak typeof(_tableview) weakTableview = _tableview;
    __weak typeof (self) weakSelf = self;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (isfresh) {
            [weakSelf loadData];
        }
        else{
            weakTableview.mj_header.state = MJRefreshStateNoMoreData;
            weakTableview.mj_header.hidden = YES;
            weakTableview.mj_insetT=0;
        }
    }];
    _tableview.mj_header = header;
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"释放刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"加载中，请等待 ..." forState:MJRefreshStateRefreshing];
    header.lastUpdatedTimeLabel.hidden = YES;
}
- (void)firstload
{
    r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            NSLog(@"wu");
        {
            [self getdataArray];
            [_tableview reloadData];
//            self.netWorkingStatus=0;
            break;
        }
            
        case ReachableViaWWAN:
            // 使用3G网络
            NSLog(@"wan");
            [self reflsh];
            [self isNeedNet];
//            self.netWorkingStatus=1;
            break;
        case ReachableViaWiFi:
            // 使用WiFi网络
            NSLog(@"wifi");
            [self reflsh];
            [self isNeedNet];
//            self.netWorkingStatus=1;
            break;
    }
}

- (void)isNeedNet{

    NSArray *array1 = [[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"all%li",(long)_signID]];
    if (array1.count==_signNumber) {
        [self getdataArray];
         [_tableview reloadData];
    }else{
         [self loadData];
    }
}


- (void)getdataArray
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
}
- (void)loadData    //网络加载数据
{
    JQIndicatorView *indicator = nil;
        indicator = [[JQIndicatorView alloc]initWithType:3 tintColor: [UIColor colorWithRed:9.00f/255.0f green:187.00f/255.0f blue:7.00f/255.0f alpha:1] size:CGSizeMake(90, 70)];
        indicator.center = self.view.center;
        [self.view addSubview:indicator];
        [indicator startAnimating];
    NSString *listurl = [NSString stringWithFormat:@"%@api/v2/checkIn/getCheckInPeopleList?token=%@",zhundaoApi,[[SignManager shareManager] getToken]];
    NSDictionary *dic = @{@"Type":@"0",
                          @"CheckInId":[NSString stringWithFormat:@"%li",(long)_signID],
                          @"pageSize":@"200000",
                          @"pageIndex":@"1"};
    [ZD_NetWorkM postDataWithMethod:listurl parameters:dic succ:^(NSDictionary *obj) {
        NSDictionary *result = [NSDictionary dictionaryWithDictionary:obj];
        NSArray *array1 = result[@"data"];
        if (result[@"Url"]) {
            [self showNoDataArray];
        }
        else{
            NSMutableArray *muarray = [NSMutableArray array];
            NSMutableArray *muarray1 = [NSMutableArray array];
            NSMutableArray *muarray2 = [NSMutableArray array];
            dataarr = [NSMutableArray array];
            dataarr1 = [NSMutableArray array];
            dataarr2 = [NSMutableArray array];
            [self createSignList];
            SignManager *manager = [SignManager shareManager];
            if ([manager.dataBase open]) {
                
                //                            NSString *updateSql = [NSString stringWithFormat:@"DROP TABLE signList"];
                //                            BOOL res = [manager.dataBase executeUpdate:updateSql];
                
                [self transactionwitharray:array1 withmarr:muarray withmarr:muarray1 withmarr:muarray2];
                [manager.dataBase close];
            }
            [[NSUserDefaults standardUserDefaults]setObject:dataarr forKey:[NSString stringWithFormat:@"all%li",(long)_signID]];
            [[NSUserDefaults standardUserDefaults]setObject:dataarr2 forKey:[NSString stringWithFormat:@"sign%li",(long)_signID]];
            [[NSUserDefaults standardUserDefaults]setObject:dataarr1 forKey:[NSString stringWithFormat:@"signed%li",(long)_signID]];
            [[NSUserDefaults standardUserDefaults]synchronize];
            _dataArray = [muarray copy];
            _dataArray1 = [muarray1 copy];
            _dataArray2 = [muarray2 copy];
            
        }
        
        [_tableview.mj_header endRefreshing];
        [indicator stopAnimating];
        [indicator stopAnimating];
        [self createSearchCtr];
        [_tableview reloadData];
    } fail:^(NSError *error) {
        
    }];
}

-(void)transactionwitharray:(NSArray*)array1 withmarr:(NSMutableArray *)muarray withmarr:(NSMutableArray *)muarray1 withmarr:(NSMutableArray *)muarray2{
    // 开启事务
    [[SignManager shareManager].dataBase beginTransaction];
    BOOL isRollBack = NO;
    @try {
        for (NSDictionary *acdic in array1) {
            LoadallsignModel *model = [LoadallsignModel yy_modelWithJSON:acdic];
            NSMutableDictionary *e = [NSMutableDictionary dictionary];
            
            NSString *insertSql =[NSString stringWithFormat:@"replace INTO signList(vcode, signID,Status,AdminRemark,FeeName,Fee,phone)VALUES('%@',%li,%li,'%@','%@',%f,'%@')",model.VCode,(long)_signID,(long)model.Status,model.AdminRemark,model.FeeName,model.Fee,model.Mobile];
            
            BOOL res = [[SignManager shareManager].dataBase executeUpdate:insertSql];
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
    }
    @catch (NSException *exception) {
        isRollBack = YES;
        // 事务回退
        [[SignManager shareManager].dataBase rollback];
    }
    @finally {
        if (!isRollBack) {
            //事务提交
            [[SignManager shareManager].dataBase commit];
        }
    }
}
- (void)showNoDataArray
{
    [[SignManager shareManager]showAlertWithTitle:@"对不起，您的权限不够" WithMessage:@"请前往升级" WithTitleOne:@"返回" WithActionOne:^(TYAlertAction *action1) {
        [self.navigationController popViewControllerAnimated:YES];
    } WithAlertStyle:TYAlertActionStyleDefault WithTitleTwo:@"升级" WithActionTwo:^(TYAlertAction *action1) {
        [self showHTML];
    } WithCTR:self];
}
- (void)showHTML
{
    UpDataViewController *updata = [[UpDataViewController alloc]init];
    updata.urlString = [NSString stringWithFormat:@"%@Activity/Upgraded?accesskey=%@",zhundaoH5Api,[[SignManager shareManager] getaccseekey]];
    [self setHidesBottomBarWhenPushed:YES];
     [self.navigationController pushViewController:updata animated:YES];
    __weak typeof(self) weakself =self;
    updata.block = ^(BOOL issuccess)
    {
        if (issuccess) {
            [weakself loadData];
            [weakself getuser];
        }
    };
}
- (void)getuser
{    NSString *userstr = [NSString stringWithFormat:@"%@api/v2/user/getUserInfo?token=%@",zhundaoApi,[[SignManager shareManager] getToken]];
    [ZD_NetWorkM getDataWithMethod:userstr parameters:nil succ:^(NSDictionary *obj) {
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:obj];
        NSDictionary  *userDict = dic [@"data"];
        NSString *GradeId = [NSString stringWithFormat:@"%@",userDict[@"gradeId"]];
        [[  NSUserDefaults standardUserDefaults  ]setObject:GradeId forKey:@"GradeId"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    } fail:^(NSError *error) {
        
    }];
}
- (void)createSignList
{
    SignManager *manager = [SignManager shareManager];
    if ([manager.dataBase open]) {
        bool result = [manager.dataBase executeUpdate:@"CREATE TABLE IF NOT EXISTS signList(vcode TEXT NOT NULL,signID integer NOT NULL,Status integer,post integer DEFAULT 2,AdminRemark TEXT,Fee DOUBLE,addTime TEXT,phone TEXT,FeeName TEXT, PRIMARY KEY(vcode, signID));"];
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
    _tableview.backgroundColor = zhundaoBackgroundColor;
    _tableview.dataSource = self;
    [_tableview setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.view addSubview:_tableview];
    if ([r currentReachabilityStatus]==NotReachable) {
        [self createSearchCtr];
    }
}

- (void)createSearchCtr
{
   resultsController = [[ResultsViewController alloc] init];
    _searchController = [[UISearchController alloc] initWithSearchResultsController:resultsController];
    _searchController.searchBar.placeholder = @"搜索";
    _searchController.searchBar.barTintColor = _tableview.backgroundColor = zhundaoBackgroundColor;
    resultsController.signID = self.signID;
    resultsController.activityID = self.activityID;
    _searchController.dimsBackgroundDuringPresentation = NO;
    _searchController.view.backgroundColor = zhundaoBackgroundColor;
    [_searchController.searchBar setBackgroundImage:[UIImage new]];
    _searchController.searchResultsUpdater = resultsController;
    _searchController.delegate =self;
    _tableview.tableHeaderView = self.searchController.searchBar;
}
- (void)didDismissSearchController:(UISearchController *)searchController
{
    [self getdataArray];
    [_tableview reloadData];
    
}
- (void)willPresentSearchController:(UISearchController *)searchController
{
    resultsController.alldata =[self getallData];
}
- (NSArray *)getallData
{
    NSArray *arr = [[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"all%li",(long)_signID]];
    NSMutableArray *alldataarray = [NSMutableArray array]; 
    for (NSDictionary *acdic in arr) {
        LoadallsignModel *model = [LoadallsignModel yy_modelWithJSON:acdic];
        [alldataarray addObject:model];
    }
    return [alldataarray copy];;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (flag==0) {
         return _dataArray.count;
    }
  else  if (flag==1) {
        return _dataArray1.count;
    }
   else {
        return _dataArray2.count;
    }
  
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LoadAllSignTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"loadID"];
    if (cell==nil) {
        cell = [[LoadAllSignTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"loadID"];
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.tag = indexPath.row;
    cell.signid = self.signID;
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
        cell.checkLabel.image = [ UIImage imageNamed:@"打勾-9"];
    }if (cell.model.Status==1) {
        cell.checkLabel.image = [ UIImage imageNamed:@"打勾-8"];
        cell.nameLabel.frame = CGRectMake(0, 20, 100, 100);
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(signOther:)];
      cell.timeLabel.userInteractionEnabled = YES;
    [cell.timeLabel addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showDetail:)];
    [cell addGestureRecognizer:tap2];
    return cell;
}
- (void)showDetail:(UITapGestureRecognizer *)tap
{
    myCell = (LoadAllSignTableViewCell *)tap.view;
    NSArray *array = [[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"%li",(long)self.activityID]];
    __weak typeof(self) weakSelf = self;
    if (array&&array.count==_dataArray.count) {
        [self pushToDetail:array];
    }else{
        [self.oneVM getNewList:self.activityID BackBlock:^(NSArray *backArray) {
            [weakSelf pushToDetail:backArray];
        }];
    }
}
- (void)pushToDetail :(NSArray *)array
{
    __block NSDictionary *datadic = nil;
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        datadic = [(NSDictionary *)array[idx] copy];
        if ([datadic[@"Mobile"] isEqualToString:myCell.model.Mobile]) {
            *stop = YES;
        }
    }];
    __weak typeof(self) weakSelf = self;
    SignleListViewController *signle = [[SignleListViewController alloc]init];
    if (datadic) {
        signle.datadic =datadic;
        signle.userInfo = [weakSelf getUserInfo:datadic];
    }else{
        NSArray *arr = [[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"all%li",(long)_signID]];
        signle.userInfo = @"100,101";
        signle.datadic = [arr objectAtIndex:myCell.tag];
    }
    signle.personID = myCell.model.UserID;
    signle.activityID = [datadic[@"ActivityID"] integerValue];
    signle.vcode = myCell.model.VCode;
    [weakSelf  setHidesBottomBarWhenPushed:YES];
    [weakSelf.navigationController pushViewController:signle animated:YES];
}
- (void)signOther:(UITapGestureRecognizer *)tap
{
    myCell = (LoadAllSignTableViewCell *)tap.view.superview.superview;
    if (!myCell.model.SignTime||[myCell.timeLabel.text isEqualToString:@" 管理员代签  "]) {
        [self showSign];
    }
}
- (void)showSign
{
    __weak typeof(self) weakSelf = self;
    [[SignManager shareManager]showAlertWithTitle:[NSString stringWithFormat:@"确定为 %@ 代签",myCell.model.TrueName] WithMessage:@"代签后不能修改" WithTitleOne:@"确定" WithActionOne:^(TYAlertAction *action1) {
        
        [[signResult alloc]sureSignWithphoneStr:myCell.model.Mobile WithView:self.view WithSignId:self.signID WithCtr:self WithMaskLabelBool :YES WithTYaction1:^(TYAlertAction *action1) {

        } WithTYaction2:^(TYAlertAction *action1) {
           
        } WithTYActionNotNet1:^(TYAlertAction *action1) {
          
        } WithTYActionNotNet2:^(TYAlertAction *action1) {
    
        }  maskBlock:^(BOOL maskIsSuccess) {
            if (maskIsSuccess) {
                [weakSelf getdataArray];
                [_tableview reloadData];
                _block(1);
            }
        }];
    } WithAlertStyle:TYAlertActionStyleDefault WithTitleTwo:@"取消" WithActionTwo:nil WithCTR:self];
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
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-10, 44)];
    float buttonWeith = (kScreenWidth)/3;
    for ( int i=0; i<3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*buttonWeith, 0, buttonWeith, 40);
        button.backgroundColor = [UIColor colorWithWhite:0.97 alpha:1];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, buttonWeith, 40)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:13];
        
        if (i==0) {
            //            label.text = [NSString stringWithFormat:@""]
            label.text = [NSString stringWithFormat:@"全部(%li)",(unsigned long)_dataArray.count];
            if (flag==0) {
                _starLabel= label;
                label.textColor = zhundaoGreenColor;
            }
        }
        if (i==1) {
            label.text = [NSString stringWithFormat:@"已签(%li)",(unsigned long)_dataArray1.count];
            if (flag==1) {
                _starLabel= label;
                label.textColor = zhundaoGreenColor;
            }
            
        } if (i==2) {
            label.text = [NSString stringWithFormat:@"未签(%li)",(unsigned long)_dataArray2.count];
            if (flag==2) {
                _starLabel= label;
                label.textColor = zhundaoGreenColor;
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

- (void)print
{
    PrintVM *printvm = [[PrintVM alloc]init];
    NSArray *modelselArray = [printvm getModel];
    NSInteger index = [modelselArray indexOfObject:@"1"];
    int offsetx = [[[NSUserDefaults standardUserDefaults]objectForKey:@"printX"] intValue];
    int offsety = [[[NSUserDefaults standardUserDefaults]objectForKey:@"printY"] intValue];
    @autoreleasepool {
        for (LoadallsignModel *model in _dataArray) {
            if (index ==0) {  //打印二维码
                [printvm printQRCode:model.VCode isPrint:YES offsetx:offsetx offsety:offsety];
            }else{  //打印二维码加姓名
                [printvm printQRCode:model.VCode name:model.TrueName isPrint:YES offsetx:offsetx offsety:offsety];
            }
        }
    }
}

- (NSString *)getUserInfo:(NSDictionary *)dic
{
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"100",@"101", nil];
    NSArray *engArray = @[@"Sex",@"Company",@"Depart",@"Duty",@"IDcard",@"Industry",@"Email",@"Address",@"Remark",@"FaceImg"];
    NSArray *arr=  @[@"102",@"103",@"104",@"105",@"110",@"106",@"107",@"111",@"109",@"112"];
    for (int i = 0; i <10; i++) {
        if (![[dic objectForKey:engArray[i]] isEqual:@""]) {
            [array addObject:arr[i]];
        }
    }
    if ([[dic objectForKey:@"Sex"] longValue]==0) {
        [array removeObject:@"102"];
    }
    return [array componentsJoinedByString:@","];
}
- (void)dealloc{
    NSLog(@"dealloc");
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
