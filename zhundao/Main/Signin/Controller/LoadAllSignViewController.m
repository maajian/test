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
@interface LoadAllSignViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchControllerDelegate>
{
    UITableView *_tableview;
    NSMutableArray *_dataArray;
    NSMutableArray *_dataArray1;
    NSMutableArray *_dataArray2;
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
    self.definesPresentationContext = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _dataArray = [NSMutableArray array];
    _dataArray1 = [NSMutableArray array];
    _dataArray2 = [NSMutableArray array];
    [self createTableView];
    self.view.backgroundColor = ZDBackgroundColor;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self postData];
    _tableview.backgroundColor = ZDBackgroundColor;
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
    UILabel *label = [MyLabel initWithLabelFrame:CGRectMake(0, 0, 44, 44) Text:self.signInModel.Name textColor:[UIColor blackColor] font:KHeitiSCMedium(17) textAlignment:NSTextAlignmentCenter cornerRadius:0 masksToBounds:0];
    self.navigationItem.titleView = label;
}
- (void)pushScan {
    if (self.signInModel.Status == 1) {
        SaoYiSaoViewController *sao = [[SaoYiSaoViewController alloc] init];
        sao.signID = self.self.signInModel.ID;
        [self presentViewController:sao animated:YES completion:nil];
    } else {
        ZD_HUD_SHOW_ERROR_STATUS(@"请先开启签到!")
    }
}
- (void)postData {
    ZD_WeakSelf
    [[signResult alloc] postLocalDataWithSignID:self.signInModel.ID success:^{
        [weakSelf loadData];
    } fail:nil];
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
                          @"CheckInId":[NSString stringWithFormat:@"%li",(long)self.signInModel.ID],
                          @"pageSize":@"200000",
                          @"pageIndex":@"1"};
    [ZDNetWorkManager shareHTTPSessionManager].responseSerializer = [AFJSONResponseSerializer serializer];
    [ZD_NetWorkM postDataWithMethod:listurl parameters:dic succ:^(NSDictionary *obj) {
        [_dataArray removeAllObjects];
        [_dataArray1 removeAllObjects];
        [_dataArray2 removeAllObjects];
        NSDictionary *result = [NSDictionary dictionaryWithDictionary:obj];
        if (result[@"Url"]) {
            [self showNoDataArray];
        }
        else{
            for (NSDictionary *tempDic in result[@"data"]) {
                LoadallsignModel *model = [LoadallsignModel yy_modelWithDictionary:tempDic];
                [_dataArray addObject:model];
                if (model.Status == 0) {
                    [_dataArray2 addObject:model];
                }
                if (model.Status == 1) {
                    [_dataArray1 addObject:model];
                }
            }
        }
        [ZDCache.sharedCache setCache:result[@"data"] forKey:[NSString stringWithFormat:@"%@%li", ZDCacheSign_One_List, self.signInModel.ID]];
        [_tableview.mj_header endRefreshing];
        [indicator stopAnimating];
        [self createSearchCtr];
        [_tableview reloadData];
    } fail:^(NSError *error) {
        [indicator stopAnimating];
        [_tableview.mj_header endRefreshing];
        NSArray *tempArray = (NSArray *)[ZDCache.sharedCache cacheForKey:[NSString stringWithFormat:@"%@%li", ZDCacheSign_One_List, self.signInModel.ID]];
        if (tempArray.count) {
            [self dealDataWithArray:tempArray];
        }
    }];
}
- (void)dealDataWithArray:(NSArray *)array {
    [_dataArray removeAllObjects];
    [_dataArray1 removeAllObjects];
    [_dataArray2 removeAllObjects];
    for (NSDictionary *tempDic in array) {
        LoadallsignModel *model = [LoadallsignModel yy_modelWithDictionary:tempDic];
        [_dataArray addObject:model];
        if (model.Status == 0) {
            [_dataArray2 addObject:model];
        }
        if (model.Status == 1) {
            [_dataArray1 addObject:model];
        }
    }
    [_tableview reloadData];
}

- (void)showNoDataArray
{
    [ZDAlertView alertWithTitle:@"对不起，您的权限不够" message:@"请前往升级" cancelTitle:@"返回" sureTitle:@"升级" sureBlock:^{
        [self showHTML];
    } cancelBlock:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
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
    [ZDNetWorkManager shareHTTPSessionManager].responseSerializer = [AFJSONResponseSerializer serializer];
    [ZD_NetWorkM getDataWithMethod:userstr parameters:nil succ:^(NSDictionary *obj) {
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:obj];
        NSDictionary  *userDict = dic [@"data"];
        NSString *GradeId = [NSString stringWithFormat:@"%@",userDict[@"gradeId"]];
        [[  NSUserDefaults standardUserDefaults  ]setObject:GradeId forKey:@"GradeId"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    } fail:^(NSError *error) {
        
    }];
}
- (void)createTableView
{
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
    [_tableview registerNib:[UINib nibWithNibName:@"LoadAllSignTableViewCell" bundle:nil] forCellReuseIdentifier:@"loadID"];
    _tableview.delegate = self ;
    _tableview.backgroundColor = ZDBackgroundColor;
    _tableview.dataSource = self;
    _tableview.mj_header = [ZDRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(postData)];
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
    _searchController.searchBar.barTintColor = _tableview.backgroundColor = ZDBackgroundColor;
    resultsController.signID = self.self.signInModel.ID;
    resultsController.activityID = self.signInModel.ActivityID;
    _searchController.dimsBackgroundDuringPresentation = NO;
    _searchController.view.backgroundColor = ZDBackgroundColor;
    [_searchController.searchBar setBackgroundImage:[UIImage new]];
    _searchController.searchResultsUpdater = resultsController;
    _searchController.delegate =self;
    _tableview.tableHeaderView = self.searchController.searchBar;
}
- (void)didDismissSearchController:(UISearchController *)searchController
{
    [self loadData];
}
- (void)willPresentSearchController:(UISearchController *)searchController
{
    resultsController.alldata =[self getallData];
}
- (NSArray *)getallData
{
    NSArray *arr = (NSArray *)[ZDCache.sharedCache cacheForKey:[NSString stringWithFormat:@"%@%li", ZDCacheSign_One_List, self.signInModel.ID]];
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
    cell.signid = self.signInModel.ID;
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
    NSArray *array = [[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"%li",(long)self.signInModel.ActivityID]];
    __weak typeof(self) weakSelf = self;
    if (array&&array.count==_dataArray.count) {
        [self pushToDetail:array];
    }else{
        [self.oneVM getNewList:self.signInModel.ActivityID BackBlock:^(NSArray *backArray) {
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
        NSArray *arr = [[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"all%li",(long)self.signInModel.ID]];
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
        if (self.signInModel.Status == 1) {
            [self showSign];
        } else {
            ZD_HUD_SHOW_ERROR_STATUS(@"请先开启签到!")
        }
    }
}
- (void)showSign
{
    __weak typeof(self) weakSelf = self;
    [ZDAlertView alertWithTitle:[NSString stringWithFormat:@"确定为 %@ 代签",myCell.model.TrueName] message:@"代签后不能修改" sureBlock:^{
        [[signResult alloc] dealAdminSignWithSignID:self.signInModel.ID phone:myCell.model.Mobile action1:^{
            [weakSelf loadData];
        }];
    } cancelBlock:^{
        
    }];
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
                label.textColor = ZDGreenColor;
            }
        }
        if (i==1) {
            label.text = [NSString stringWithFormat:@"已签(%li)",(unsigned long)_dataArray1.count];
            if (flag==1) {
                _starLabel= label;
                label.textColor = ZDGreenColor;
            }
            
        } if (i==2) {
            label.text = [NSString stringWithFormat:@"未签(%li)",(unsigned long)_dataArray2.count];
            if (flag==2) {
                _starLabel= label;
                label.textColor = ZDGreenColor;
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
    DDLogVerbose(@"dealloc");
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
