#import "PGUserInfoBottom.h"
//
//  PGSignInLoadAllSignVC.m
//  zhundao
//
//  Created by zhundao on 2016/12/20.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import "PGSignInLoadAllSignVC.h"
#import "PGSignInLoadallsignModel.h"
#import "PGSignInLoadAllSignCell.h"
#import "PGSignInResultsVC.h"
#import "PGSignResult.h"
#import "PGPostSignManager.h"
#import "PGSaoYiSaoViewController.h"
#import "PGSignInUpDataVC.h"
#import "PGSignInOnePersonDataNetWork.h"
#import "PGActivitySignleListVC.h"
@interface PGSignInLoadAllSignVC ()<UITableViewDelegate,UITableViewDataSource,UISearchControllerDelegate>
{
    UITableView *_tableview;
    NSMutableArray *_dataArray;
    NSMutableArray *_dataArray1;
    NSMutableArray *_dataArray2;
    NSInteger flag;
     Reachability *r;
    PGSignInResultsVC *resultsController;
    NSInteger backNumber ;
    PGSignInLoadAllSignCell *myCell;
}
@property(nonatomic,strong)UIButton *starButton;
@property(nonatomic,strong)UILabel *starLabel;
@property (nonatomic, retain) UISearchController *searchController;
@property(nonatomic,strong)PGSignInOnePersonDataNetWork *oneVM;
@end

@implementation PGSignInLoadAllSignVC

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
    [self loadData];
    _tableview.backgroundColor = ZDBackgroundColor;
}

#pragma mark ----- 懒加载
- (PGSignInOnePersonDataNetWork *)oneVM{
    if (!_oneVM) {
        _oneVM = [[PGSignInOnePersonDataNetWork alloc]init];
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
    PGSaoYiSaoViewController *sao = [[PGSaoYiSaoViewController alloc] init];
    sao.signID = self.signID;
    [self presentViewController:sao animated:YES completion:nil];
}
- (void)postData {
    ZD_WeakSelf
    [[PGSignResult alloc] postLocalDataWithSignID:_signID success:^{
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
    NSString *listurl = [NSString stringWithFormat:@"%@api/v2/checkIn/getCheckInPeopleList?token=%@",zhundaoApi,[[PGSignManager shareManager] getToken]];
    NSDictionary *dic = @{@"Type":@"0",
                          @"CheckInId":[NSString stringWithFormat:@"%li",(long)_signID],
                          @"pageSize":@"200000",
                          @"pageIndex":@"1"};
    [PGNetWorkManager shareHTTPSessionManager].responseSerializer = [AFJSONResponseSerializer serializer];
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
                PGSignInLoadallsignModel *model = [PGSignInLoadallsignModel yy_modelWithDictionary:tempDic];
                [_dataArray addObject:model];
                if (model.Status == 0) {
                    [_dataArray2 addObject:model];
                }
                if (model.Status == 1) {
                    [_dataArray1 addObject:model];
                }
            }
        }
        [PGCache.sharedCache setCache:result[@"data"] forKey:[NSString stringWithFormat:@"%@%li", PGCacheSign_One_List, _signID]];
        [_tableview.mj_header endRefreshing];
        [indicator stopAnimating];
        [self createSearchCtr];
        [_tableview reloadData];
    } fail:^(NSError *error) {
        [indicator stopAnimating];
        [_tableview.mj_header endRefreshing];
        NSArray *tempArray = (NSArray *)[PGCache.sharedCache cacheForKey:[NSString stringWithFormat:@"%@%li", PGCacheSign_One_List, _signID]];
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
        PGSignInLoadallsignModel *model = [PGSignInLoadallsignModel yy_modelWithDictionary:tempDic];
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
    [PGAlertView alertWithTitle:@"对不起，您的权限不够" message:@"请前往升级" cancelTitle:@"返回" sureTitle:@"升级" sureBlock:^{
        [self showHTML];
    } cancelBlock:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}
- (void)showHTML
{
    PGSignInUpDataVC *updata = [[PGSignInUpDataVC alloc]init];
    updata.urlString = [NSString stringWithFormat:@"%@Activity/Upgraded?accesskey=%@",zhundaoH5Api,[[PGSignManager shareManager] getaccseekey]];
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
{    NSString *userstr = [NSString stringWithFormat:@"%@api/v2/user/getUserInfo?token=%@",zhundaoApi,[[PGSignManager shareManager] getToken]];
    [PGNetWorkManager shareHTTPSessionManager].responseSerializer = [AFJSONResponseSerializer serializer];
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
    [_tableview registerNib:[UINib nibWithNibName:@"PGSignInLoadAllSignCell" bundle:nil] forCellReuseIdentifier:@"loadID"];
    _tableview.delegate = self ;
    _tableview.backgroundColor = ZDBackgroundColor;
    _tableview.dataSource = self;
    _tableview.mj_header = [PGRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    [_tableview setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.view addSubview:_tableview];
    if ([r currentReachabilityStatus]==NotReachable) {
        [self createSearchCtr];
    }
}

- (void)createSearchCtr
{
   resultsController = [[PGSignInResultsVC alloc] init];
    _searchController = [[UISearchController alloc] initWithSearchResultsController:resultsController];
    _searchController.searchBar.placeholder = @"搜索";
    _searchController.searchBar.barTintColor = _tableview.backgroundColor = ZDBackgroundColor;
    resultsController.signID = self.signID;
    resultsController.activityID = self.activityID;
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
    NSArray *arr = (NSArray *)[PGCache.sharedCache cacheForKey:[NSString stringWithFormat:@"%@%li", PGCacheSign_One_List, _signID]];
    NSMutableArray *alldataarray = [NSMutableArray array]; 
    for (NSDictionary *acdic in arr) {
        PGSignInLoadallsignModel *model = [PGSignInLoadallsignModel yy_modelWithJSON:acdic];
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
    PGSignInLoadAllSignCell *cell = [tableView dequeueReusableCellWithIdentifier:@"loadID"];
    if (cell==nil) {
        cell = [[PGSignInLoadAllSignCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"loadID"];
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
        cell.checkLabel.image = [ UIImage imageNamed:@"img_public_check_disable"];
    }if (cell.model.Status==1) {
        cell.checkLabel.image = [ UIImage imageNamed:@"img_public_check_select"];
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
    myCell = (PGSignInLoadAllSignCell *)tap.view;
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
    PGActivitySignleListVC *signle = [[PGActivitySignleListVC alloc]init];
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
    myCell = (PGSignInLoadAllSignCell *)tap.view.superview.superview;
    if (!myCell.model.SignTime||[myCell.timeLabel.text isEqualToString:@" 管理员代签  "]) {
        [self showSign];
    }
}
- (void)showSign
{
    __weak typeof(self) weakSelf = self;
    [PGAlertView alertWithTitle:[NSString stringWithFormat:@"确定为 %@ 代签",myCell.model.TrueName] message:@"代签后不能修改" sureBlock:^{
        [[PGSignResult alloc] dealAdminSignWithSignID:self.signID phone:myCell.model.Mobile action1:^{
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
                label.textColor = ZDMainColor;
            }
        }
        if (i==1) {
            label.text = [NSString stringWithFormat:@"已签(%li)",(unsigned long)_dataArray1.count];
            if (flag==1) {
                _starLabel= label;
                label.textColor = ZDMainColor;
            }
            
        } if (i==2) {
            label.text = [NSString stringWithFormat:@"未签(%li)",(unsigned long)_dataArray2.count];
            if (flag==2) {
                _starLabel= label;
                label.textColor = ZDMainColor;
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
    NSLog(@"dealloc");
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

*/

@end
