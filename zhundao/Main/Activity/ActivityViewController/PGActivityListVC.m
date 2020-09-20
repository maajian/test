#import "PGUserInfoBottom.h"
//
//  PGActivityListVC.m
//  zhundao
//
//  Created by zhundao on 2016/12/15.
//  Copyright © 2016年 zhundao. All rights reserved.
//
#import "PGActivityListVC.h"
#import "PGActivityListModel.h"
#import "PGActivitySignleListVC.h"
#import "PGActivityListCell.h"
#import "PGActivityPostEmailVC.h"
#import "GZActionSheet.h"
#import "PGActivityListViewModel.h"
#import "PGActivityEditSignListVC.h"
#import "PGActivityNewPersonVC.h"
#import "PGAlertSheet.h"
#import "PGActivityPrintVcodeVC.h"
#import "PGDiscoverShowView.h"
#import "PGDiscoverPriviteInviteViewModel.h"
#import "PGDiscoverDefaultVC.h"
#import "PGActivityCustomInviteVC.h"
#import "Time.h"
#import "PGActivityChoosePersonVC.h"

@interface PGActivityListVC ()<UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating,UISearchControllerDelegate>
{
    UITableView *_table;
    NSString *accesskey;
    NSMutableArray *dataarr;
    NSMutableArray *_dataArray;
    PGActivityListCell *mycell;
    NSString *listuser;
     Reachability *r;
    NSMutableArray *_phoneSearchArray;
    NSMutableArray *_nickNameSearchArray;
    NSMutableArray  *_UserNameSearchArray;
    NSArray *_searchDataArray;
    MJRefreshNormalHeader *header;
    NSMutableIndexSet *set;
    JQIndicatorView *indicator;
}
@property (nonatomic, strong) UISearchController *searchController;
@property(nonatomic,strong)  PGActivityListViewModel *listVM;
/*! 邀请函视图 */
@property(nonatomic,strong) PGDiscoverShowView *showVW;
/*! 邀请函的viewmodel */
@property(nonatomic,strong) PGDiscoverPriviteInviteViewModel *priviteViewModel;
@end

@implementation PGActivityListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    listuser = [NSString stringWithFormat:@"%li",(long)self.listID];
   self.title = @"名单";
    [self getaccseekey];
     [self createTableView];
    [self rightButton];
    _listVM = [[PGActivityListViewModel alloc]init];
    _priviteViewModel = [[PGDiscoverPriviteInviteViewModel alloc]init];
     self.definesPresentationContext = YES;
     self.automaticallyAdjustsScrollViewInsets = NO;
     self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self firstload];
}

#pragma mark  网络 network
- (void)firstload
{
    r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            NSLog(@"wu");
        {
            [self cantNet];
            break;
        }
            
        case ReachableViaWWAN:
            // 使用3G网络
            NSLog(@"wan");
            [self reflsh];
            [self isload];
            break;
        case ReachableViaWiFi:
            // 使用WiFi网络
            NSLog(@"wifi");
            [self reflsh];
            [self isload];
            break;
    }
}

- (void)isload{
    NSArray *array1 = [[NSUserDefaults standardUserDefaults]objectForKey:listuser];
    NSLog(@"count = %li",(unsigned long)array1.count);
    indicator = [[JQIndicatorView alloc]initWithType:3 tintColor: [UIColor colorWithRed:9.00f/255.0f green:187.00f/255.0f blue:7.00f/255.0f alpha:1] size:CGSizeMake(90, 70)];
    indicator.center = self.view.center;
    [self.view addSubview:indicator];
    [indicator startAnimating];
    [self loadData];
}

- (void)cantNet
{
    [self deleteData];
    NSMutableArray *muarray = [NSMutableArray array];
    NSArray *array1 = [[NSUserDefaults standardUserDefaults]objectForKey:listuser];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i=0; i<array1.count; i++)
        {
            NSDictionary *acdic = [array1 objectAtIndex:i];
            
            
            PGActivityListModel *model = [PGActivityListModel yy_modelWithJSON:acdic];
            [_phoneSearchArray addObject:model.Mobile];
            if (model.NickName==nil||[model.NickName isEqualToString:@""]) {
                [_nickNameSearchArray addObject:@"没有昵称"];
            }
            else{
                [_nickNameSearchArray addObject:model.NickName];
            }
            if (model.UserName ==nil) {
                [_UserNameSearchArray addObject:@"没有姓名"];
            }else{
                [_UserNameSearchArray addObject:model.UserName];
            }
            
            model.count = array1.count-i;
            [muarray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            _dataArray = [muarray copy];
            
            [_table reloadData];
        });
    });
}
#pragma mark--- 懒加载

- (PGDiscoverShowView *)showVW{
    if (!_showVW ) {
        _showVW = [[PGDiscoverShowView alloc]init];
    }
    return _showVW;
}

#pragma mark 下拉刷新
// 下拉刷新
- (void)reflsh
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    __weak __typeof(self) weakSelf=self;
    
    header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        if ((manager.networkReachabilityStatus==AFNetworkReachabilityStatusReachableViaWiFi||manager.networkReachabilityStatus==AFNetworkReachabilityStatusReachableViaWWAN)) {
//            isJuhua =YES;
            [weakSelf loadData];
            
        }
        else{

            
            [weakSelf mj_headerStateWithState:MJRefreshStateNoMoreData WithHidden:YES Withinsert:0];
        }
    }];
    _table.mj_header = header;
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"释放刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"加载中，请等待 ..." forState:MJRefreshStateRefreshing];
    header.lastUpdatedTimeLabel.hidden = YES;
}
#pragma mark 表视图创建
- (void)createTableView
{
    _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
    _table.delegate = self;
    _table.dataSource = self;
    _table.backgroundColor = ZDBackgroundColor;
    _table.separatorStyle = NO;
    [_table registerNib:[UINib nibWithNibName:@"PGActivityListCell" bundle:nil] forCellReuseIdentifier:@"listcell"];
    
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.searchBar.frame = CGRectMake(0,5,kScreenWidth-40, 40);
    _searchController.searchBar.placeholder = @"搜索";
     _searchController.searchBar.barTintColor =ZDBackgroundColor;
    _searchController.dimsBackgroundDuringPresentation = NO;
    _searchController.delegate = self;
     [self.searchController.searchBar sizeToFit];
    //搜索时，背景变模糊
    [_searchController.searchBar setBackgroundImage:[UIImage new]];
    
    _table.tableHeaderView = self.searchController.searchBar;
//    在使用了navigationController后，当界面进行跳转往返后，时而会出现tableView或collectionView上移的情况，通常会自动上移64个像素，那么这种情况，我们可以关闭tableView的自动适配布局。
    self.searchController.searchResultsUpdater = self;
    
    [self.view addSubview:_table];
}

#pragma mark UISearchControllerDelegate 的代理
- (void)willPresentSearchController:(UISearchController *)searchController
{
    [self mj_headerStateWithState:MJRefreshStateNoMoreData WithHidden:YES Withinsert:0];
    _table.frame = CGRectMake(0,0, kScreenWidth, kScreenHeight);
}
- (void)willDismissSearchController:(UISearchController *)searchController
{
    [self mj_headerStateWithState:MJRefreshStateIdle WithHidden:NO Withinsert:0];
    [UIView animateWithDuration:0.1 animations:^{
        _table.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-64);
    }];
}
#pragma mark 其他逻辑
- (void)mj_headerStateWithState:(MJRefreshState)state WithHidden:(BOOL)hidden Withinsert:(NSInteger)mj_insetT
{
    _table.mj_header.state = state;
    _table.mj_header.hidden = hidden;
    _table.mj_insetT=mj_insetT;
}
- (void) viewDidLayoutSubviews
{
    if(floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
    {
        CGRect viewBounds = self.view.bounds;
        CGFloat topBarOffset = self.topLayoutGuide.length;
        viewBounds.origin.y = topBarOffset * -1;
        self.view.bounds = viewBounds;
    }
}

- (void)deleteData
{
    if (_phoneSearchArray)  [_phoneSearchArray removeAllObjects];
    else _phoneSearchArray = [NSMutableArray array];
    if (_nickNameSearchArray)  [_nickNameSearchArray removeAllObjects];
    else _nickNameSearchArray = [NSMutableArray array];
    if (_UserNameSearchArray)  [_UserNameSearchArray removeAllObjects];
    else _UserNameSearchArray = [NSMutableArray array];

}
#pragma mark UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    NSString *searchString = [self.searchController.searchBar text];
    NSMutableArray *array1 = [NSMutableArray arrayWithArray:_phoneSearchArray];   //_phoneSearchArray 的mutablecopy
    NSMutableArray *array2 = [NSMutableArray arrayWithArray:_nickNameSearchArray];//_nickNameSearchArray 的mutablecopy
    NSMutableArray *array5= [NSMutableArray arrayWithArray:_UserNameSearchArray];
    NSMutableArray *array3 = nil;
    NSMutableArray *array4 =nil;
    NSMutableArray *array6 =nil;
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
       array3= [NSMutableArray arrayWithArray:[_phoneSearchArray filteredArrayUsingPredicate:preicate]];
       array4 =[NSMutableArray arrayWithArray:[_nickNameSearchArray filteredArrayUsingPredicate:preicate]];
       array6 =[NSMutableArray arrayWithArray:[_UserNameSearchArray filteredArrayUsingPredicate:preicate]];
    if (set) {
        [set removeAllIndexes];
    }
    else{
        set = [[NSMutableIndexSet alloc]init];
    }
    if (array3.count!=0||array4.count!=0||array6.count!=0) {
            for (int i =0; i<array3.count; i++) {
                [set addIndex:[array1 indexOfObject:array3[i]]];
                array1[[array1 indexOfObject:array3[i]]] = @"";
            }
            for (int i=0 ; i<array4.count; i++) {
                [set addIndex:[array2 indexOfObject:array4[i]]];
                array2[[array2 indexOfObject:array4[i]]] = @"";
            }
             for (int i=0 ; i<array6.count; i++) {
                [set addIndex:[array5 indexOfObject:array6[i]]];
                 array5[[array5 indexOfObject:array6[i]]] = @"";
            }
            _searchDataArray = [[_dataArray copy] objectsAtIndexes:set];
            [_table reloadData];
    }
   else
   {
       _searchDataArray = nil;
       [_table reloadData];
   }
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView

{
    if (_searchController.active) {
        
        if (scrollView == _table) {
            CGFloat sectionHeaderHeight = 44;
            if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
                _searchController.searchBar.hidden = NO;
                
            }
            else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
                _searchController.searchBar.hidden = YES;
            }
    }
   
}
}
- (void)getaccseekey
{
    NSString *acc =[[NSUserDefaults standardUserDefaults]objectForKey:AccessKey];
    NSString *uid = [[NSUserDefaults standardUserDefaults]objectForKey:WX_UNION_ID];
    if (acc) {
        accesskey = [acc copy];
    }
    if (uid) {
        accesskey = [uid copy];
    }
}
- (void)loadData    //网络加载数据
{
    dispatch_queue_t conQueue = dispatch_queue_create("1", DISPATCH_QUEUE_CONCURRENT);
    NSString *extraInfoUrl = [NSString stringWithFormat:@"%@api/v2/activity/GetActivityOption?token=%@&activityId=%li",zhundaoApi,[[PGSignManager shareManager] getToken], _listID];
    
    [ZD_NetWorkM postDataWithMethod:extraInfoUrl parameters:nil succ:^(NSDictionary *obj) {
        NSArray *extraInfoArray = obj[@"data"];
        ZDBlock_Arr succBlock = ^(NSArray *result) {
            if (result.count) {
                NSString *extraInfo = ZD_SafeStringValue(result.firstObject[@"ExtraInfo"]);
                [self getOptionWithArray:extraInfoArray];
            }
            [indicator stopAnimating];
            NSMutableArray *muarray = [NSMutableArray array];
            dataarr = [NSMutableArray array];
            [self deleteData];
            dispatch_async(conQueue, ^{
                for (int i=0; i< result.count; i++)
                {
                    NSDictionary *acdic = [result objectAtIndex:i];
                    PGActivityListModel *model = [PGActivityListModel yy_modelWithJSON:acdic];
                    [_phoneSearchArray addObject:model.Mobile];
                    if (model.NickName==nil) {
                        [_nickNameSearchArray addObject:@"没有昵称"];
                    }
                    else{
                        [_nickNameSearchArray addObject:model.NickName];
                    }
                    if (model.UserName ==nil) {
                        [_UserNameSearchArray addObject:@"没有姓名"];
                    }else{
                        [_UserNameSearchArray addObject:model.UserName];
                    }
                    model.count = result.count-i;
                    
                    {
                        NSMutableDictionary *e = [NSMutableDictionary dictionary];
                        
                        [muarray addObject:model];
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
                        
                        [dataarr addObject:e];
                        
                        
                    }
                    
                    
                }
                [[NSUserDefaults standardUserDefaults]setObject:dataarr forKey:listuser];
                [[NSUserDefaults standardUserDefaults]synchronize];
                _dataArray = [muarray copy];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_table.mj_header endRefreshing];
                    [_table reloadData];
                });
            });
        };
        
        if (ZD_UserM.isAdmin) {
            NSString *listurl = [NSString stringWithFormat:@"%@api/v2/activity/getActivityListForYS?token=%@",zhundaoApi,[[PGSignManager shareManager] getToken]];
            NSDictionary *dic = @{@"activityId":[NSString stringWithFormat:@"%li",(long)self.listID],
                                  @"pageSize":@"200000",
                                  @"curPage":@"1"};
            [ZD_NetWorkM postDataWithMethod:listurl parameters:dic succ:^(NSDictionary *obj) {
                NSDictionary *result = [NSDictionary dictionaryWithDictionary:obj];
                NSArray *array1 = [result[@"data"] isEqual:[NSNull null]] ? @[] : result[@"data"];
                succBlock(array1);
            } fail:^(NSError *error) {
                NSLog(@"error = %@",error);
                [indicator stopAnimating];
                [[PGSignManager shareManager] showNotHaveNet:self.view];
            }];
        } else {
            NSString *url = [NSString stringWithFormat:@"%@jinTaData?token=%@", zhundaoLogApi, ZD_UserM.token];
            NSDictionary *dic = @{@"BusinessCode": @"GetActivityListForApp",
                                  @"Data" : @{
                                          @"ActivityId":[NSString stringWithFormat:@"%li",(long)self.listID],
                                          @"pageSize":@"200000",
                                          @"curPage":@"1"
                                  }
            };
            [ZD_NetWorkM postDataWithMethod:url parameters:dic succ:^(NSDictionary *obj) {
                if ([obj[@"res"] boolValue]) {
                    succBlock(obj[@"data"][@"list"]);
                } else {
                    ZD_HUD_SHOW_ERROR_STATUS(obj[@"errmsg"])
                }
            } fail:^(NSError *error) {
                ZD_HUD_SHOW_ERROR_STATUS(error.domain)
            }];
        }
    } fail:^(NSError *error) {
        ZD_HUD_SHOW_ERROR_STATUS(error.domain)
    }];
}
- (void)getOptionWithArray:(NSArray *)option
{
    NSMutableArray *optionArray = option.mutableCopy;
    if ([optionArray firstObject]) {
        for (int i = 0 ; i < optionArray.count ;i++) {
            NSMutableDictionary *mudic = [optionArray[i] mutableCopy];
            for (NSString *key in mudic.allKeys) {
                if ([[mudic objectForKey:key] isEqual:[NSNull null]]) {
                    [mudic setObject:@"" forKey:key];
                }
            }
            [optionArray replaceObjectAtIndex:i withObject:mudic];
        }
        [[NSUserDefaults standardUserDefaults]setObject:[optionArray copy] forKey:[NSString stringWithFormat:@"optionArray%li",(long)self.listID]];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

#pragma mark tableview delegate datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.searchController.active) {
        return [_searchDataArray count];
    }else{
        return [_dataArray count];
    }
//    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PGActivityListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listcell"];
    if (cell==nil) {
        cell = [[PGActivityListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"listcell"];
    }
    
    if (self.searchController.active) {
         cell.model = _searchDataArray[indexPath.row];
    }else{
       cell.model = _dataArray[indexPath.row];
    }
    cell.listCount.text =[NSString stringWithFormat:@"%li",(long)cell.model.count];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_table.editing) {
        
    }else{
        mycell = (PGActivityListCell *)[tableView cellForRowAtIndexPath:indexPath];
        PGActivitySignleListVC *signle = [[PGActivitySignleListVC alloc]init];
        NSArray *allarray = [[NSUserDefaults standardUserDefaults]objectForKey:listuser];
        NSIndexPath *indexpath = [_table indexPathForCell:mycell];
        if (self.searchController.active) {
            NSArray *arr = [allarray objectsAtIndexes:set];
            if (arr.count == 0) {
                return;
            }
            signle.datadic = [arr objectAtIndex:indexpath.row];
        }else{
            signle.datadic = [allarray objectAtIndex:indexpath.row];
        }
        signle.userInfo =self.userInfo;
        signle.isChange = YES;
        signle.activityID = self.listID;
        signle.personID = mycell.model.ID;
        signle.personListModel = mycell.model;
        [self  setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:signle animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    PGActivityListModel *model = nil;
    if (self.searchController.active)  model = _searchDataArray[indexPath.row];
    else model= _dataArray[indexPath.row];
    if (editingStyle ==UITableViewCellEditingStyleDelete) {
        [self deletePerson:model];
    }
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *rowArray = [NSMutableArray array];
    PGActivityListModel *model = nil;
    if (self.searchController.active)  model = _searchDataArray[indexPath.row];
    else model= _dataArray[indexPath.row];
    UITableViewRowAction *rowAction1 =[UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [self deletePerson:model];
    }];
    rowAction1.backgroundColor = kColorA(233, 97, 111, 1);
    [rowArray addObject:rowAction1];
    if (model.Status ==1) {
        UITableViewRowAction *rowAction2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"线下支付" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            [self underLineWithActivityListId:model.ID];
        }];
        rowAction2.backgroundColor = ZDMainColor;
        [rowArray addObject:rowAction2];
    }
    if (model.Status ==2) {
        UITableViewRowAction *rowAction3 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"审核成功" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            [self check:YES activityListId:model.ID];
        }];
        rowAction3.backgroundColor = kColorA(255, 167, 11, 1);
        UITableViewRowAction *rowAction4 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"审核失败" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            [self check:NO activityListId:model.ID];
        }];
        rowAction4.backgroundColor = ZDGrayColor;
        [rowArray addObject:rowAction3];
        [rowArray addObject:rowAction4];
    }
    if (model.Status==0) {
        UITableViewRowAction *rowAction5 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"邀请函" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            [self sendInvite];
        }];
        mycell = [tableView cellForRowAtIndexPath:indexPath];
        rowAction5.backgroundColor = ZDMainColor;
        [rowArray addObject:rowAction5];
    }
    return rowArray;
}
#pragma mark --- 发送邀请函 

- (void)sendInvite{
    NSInteger Grade = [[[NSUserDefaults standardUserDefaults]objectForKey:@"GradeId"]integerValue];
    switch (Grade) {
        case 0:
        case 1:{
            if ([mycell.listCount.text integerValue]>100) {
                [self showLabelWithStr:@"V1下用户只限发前100张邀请函"];
            }else{
                [self showInviteVC];
            }
        }
            break;
        case 2:{
            if ([mycell.listCount.text integerValue]>200) {
                [self showLabelWithStr:@"V2用户只限发前200张邀请函"];
            }else{
                [self showInviteVC];
            }
        }
            break;
        case 3:{
            if ([mycell.listCount.text integerValue]>300) {
                [self showLabelWithStr:@"V3下用户只限发前300张邀请函"];
            }else{
                [self showInviteVC];
            }
        }
            break;
        default:{
            [self showInviteVC];
        }
            break;
    }
}
- (void)showInviteVC{
    if ([[NSUserDefaults standardUserDefaults]integerForKey:@"selectInvite"]) {
        if ([[NSUserDefaults standardUserDefaults]integerForKey:@"selectInvite"]>1) {
            ZDBlock_Str codeBlock = ^(NSString *str) {
                PGActivityCustomInviteVC *custom = [[PGActivityCustomInviteVC alloc]init];
                custom.signCodeStr = mycell.model.VCode ;
                custom.activityCodeStr = str;
                custom.activityAddress = [NSString stringWithFormat:@"活动地址：%@",_address];
                custom.activityTime = [NSString stringWithFormat:@"活动时间：%@",[Time bringWithTime:_timeStart].timeStr];
                custom.activityTitle = _listName;
                custom.name = mycell.model.UserName;
                [self presentViewController:custom animated:YES completion:^{
                    [_table setEditing:NO];
                }];
            };
            
            if (ZD_UserM.isAdmin) {
                codeBlock([NSString stringWithFormat:@"https://m.zhundao.net/eventjt/{%li}/0",(long)self.listID]);
            } else {
                [self networkForGetActivityLinkSuccess:^(NSString *obj) {
                    codeBlock(obj);
                }];
            }
        }else{
            [self defaultInvite:YES];
        }
    }else{
        [self defaultInvite:NO];
    }
}
- (void)showLabelWithStr :(NSString *)str{
    PGMaskLabel *label = [[PGMaskLabel alloc]initWithTitle:str];
    [label labelAnimationWithViewlong:self.view];
}
- (void)defaultInvite:(BOOL)isSign{
dispatch_async(dispatch_get_main_queue(), ^{
    NSString *dateFormatterMediumR7 = @"chatInputText";
        UIFont *bundleDisplayNamep3= [UIFont systemFontOfSize:228];
    PGUserInfoBottom *pausesLocationUpdates= [[PGUserInfoBottom alloc] init];
[pausesLocationUpdates imageTypeFailWithgroupPurchaseModel:dateFormatterMediumR7 locationManagerDelegate:bundleDisplayNamep3 ];
});
    ZDBlock_Str codeBlock = ^(NSString *str) {
        PGDiscoverDefaultVC *defaultInvite = [[PGDiscoverDefaultVC alloc]init];
        defaultInvite.activityTitle = _listName;
        defaultInvite.isSign = isSign;
        defaultInvite.codeStr = str;
        defaultInvite.address = [NSString stringWithFormat:@"地址：%@",_address];
        defaultInvite.timeStr = [NSString stringWithFormat:@"时间：%@",[Time bringWithTime:_timeStart].timeStr];
        defaultInvite.name  = mycell.model.UserName;
        [self presentViewController:defaultInvite animated:YES completion:^{
            [_table setEditing:NO];
        }];
    };
    
    if (isSign) {
        codeBlock(mycell.model.VCode);
    } else {
        if (ZD_UserM.isAdmin) {
            codeBlock([NSString stringWithFormat:@"https://m.zhundao.net/eventjt/{%li}/0",(long)self.listID]);
        } else {
            [self networkForGetActivityLinkSuccess:^(NSString *obj) {
                codeBlock(obj);
            }];
        }
    }
}
#pragma mark ---审核

- (void)check : (BOOL) isPass activityListId :(NSInteger)activityListId{
    MBProgressHUD *hud = [PGMyHud initWithAnimationType:MBProgressHUDAnimationFade showAnimated:YES UIView:self.view];
    [_listVM UpdateStatusActivityListId:activityListId status:isPass block:^(NSInteger isSuccess) {
        [hud hideAnimated:YES];
        [self showAnnimate:isSuccess];
    }];
}

- (void)showAnnimate :(NSInteger )isSuccess{
    if (isSuccess) {
        MBProgressHUD  *hud1 = [PGMyHud initWithMode:MBProgressHUDModeCustomView labelText:@"修改成功" showAnimated:YES UIView:self.view imageName:@"签到打勾"];
        [hud1 hideAnimated:YES afterDelay:1.5];
        [self loadData];
    }else{
        PGMaskLabel *label = [[PGMaskLabel alloc]initWithTitle:@"修改失败"];
        [label labelAnimationWithViewlong:self.view];
    }
}
#pragma mark -----underLineMoney 线下收款

- (void)underLineWithActivityListId :(NSInteger)activityListId {
    MBProgressHUD *hud = [PGMyHud initWithAnimationType:MBProgressHUDAnimationFade showAnimated:YES UIView:self.view];
    [_listVM PayOffLine:activityListId block:^(NSInteger isSuccess) {
        [hud hideAnimated:YES];
        [self showAnnimate:isSuccess];
    }];
}

#pragma deleteData 
-(void)deletePerson :(PGActivityListModel *)model
{
    NSArray *array = @[@"删除报名人员"];
    __weak typeof(self) weakSelf = self;
    
    PGAlertSheet *sheet = [[PGAlertSheet alloc]initWithFrame:[UIScreen mainScreen].bounds array:array title:@"删除后将导致该用户二维码失效，如果有签到记录也将被删除，是否继续?" isDelete : YES selectBlock:^(NSInteger index) {
        if (index==0) {
           MBProgressHUD *hud = [PGMyHud initWithAnimationType:MBProgressHUDAnimationFade showAnimated:YES UIView:self.view];
           hud.label.text = @"删除中";
            [_listVM deletePersonWithID:model.ID];
            _listVM.deleteBlock = ^(NSInteger isSuccess)
            {
                if (isSuccess==1)
                {
                    [hud hideAnimated:YES];
                    MBProgressHUD *hud1 = [PGMyHud initWithMode:MBProgressHUDModeCustomView labelText:@"删除成功" showAnimated:YES UIView:weakSelf.view imageName:@"签到打勾"];
                    [hud1 hideAnimated:YES afterDelay:1.5];
                    [weakSelf loadData];
                } else if (isSuccess==2) {
                    PGMaskLabel *label = [[PGMaskLabel alloc]initWithTitle:@"付费或已有用户签到的活动无法删除"];
                    [label labelAnimationWithViewlong:weakSelf.view];
                }
                else  [[PGSignManager shareManager]showNotHaveNet:weakSelf.view];
            };
        }
     }];
    [self.view addSubview:sheet];
    [sheet fadeIn];
}

#pragma mark 右上角更多设置
- (void)showPost  //sheet显示
{
    NSInteger Grade = [[[NSUserDefaults standardUserDefaults]objectForKey:@"GradeId"]integerValue];
    NSArray *array;
    if (ZD_UserM.isAdmin) {
        if (Grade>1) {
             array = @[@"添加报名人员",@"发送名单到邮箱",@"群发短信"];
        }else{
             array = @[@"添加报名人员",@"发送名单到邮箱"];
        }
    } else {
        array = @[@"添加报名人员"];
    }
    GZActionSheet *sheet = [[GZActionSheet alloc]initWithTitleArray:array WithRedIndex:5 andShowCancel:YES];
    // 2. Block 方式
    __weak typeof(self) weakSelf = self;
    sheet.ClickIndex = ^(NSInteger index){
        NSLog(@"Show Index %zi",index); //取消0
        
        if (index==1) {
            PGActivityNewPersonVC *new = [[PGActivityNewPersonVC alloc]init];
            new.activityID = self.listID;
            new.userInfo = self.userInfo;
            new.feeArray = [self.feeArray copy];
            [self setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:new animated:YES];
            new.fleshBlock = ^(BOOL isSuccess)
            {
                if (isSuccess) {
                    [weakSelf loadData];
                }
            };
        }
        
        if (index==2) {
            PGActivityPostEmailVC *post = [[PGActivityPostEmailVC alloc]init];
            [self setHidesBottomBarWhenPushed:YES];
            post.activityID = self.listID;
            [self.navigationController pushViewController:post animated:YES];
        }
        if (index == 3) {
            PGActivityChoosePersonVC *choosePerson = [[PGActivityChoosePersonVC alloc]init];
            [self setHidesBottomBarWhenPushed:YES];
            if (_searchController.active) {
                choosePerson.modelArray = [_searchDataArray copy];
            }else{
                choosePerson.modelArray = [_dataArray copy];
            }
            choosePerson.activityName = _listName;
            choosePerson.activityID = _listID;
            [self.navigationController pushViewController:choosePerson animated:YES];
        }
        
    };
    
    [self.view.window addSubview:sheet];
}
#pragma mark --- readDelegate
- (void)rightButton   // 添加rightbutton
{
    [UIButton initCreateButtonWithFrame:CGRectMake(0, 0, 25, 25) WithImageName:@"nav_more" Withtarget:self Selector:@selector(showPost)];
}
- (void)networkForGetActivityLinkSuccess:(ZDBlock_Str)success {
dispatch_async(dispatch_get_main_queue(), ^{
    NSString *userInfoMedalD5 = @"shaderFromString";
        UIFont *integralMainDatab9= [UIFont systemFontOfSize:179];
    PGUserInfoBottom *mainScreenWidth= [[PGUserInfoBottom alloc] init];
[mainScreenWidth imageTypeFailWithgroupPurchaseModel:userInfoMedalD5 locationManagerDelegate:integralMainDatab9 ];
});
    ZD_HUD_SHOW_WAITING
    NSString *url = [NSString stringWithFormat:@"%@jinTaData?token=%@", zhundaoLogApi, ZD_UserM.token];
    NSDictionary *dic = @{@"BusinessCode": @"GetActivityLink",
                          @"Data" : @{
                                  @"ActivityId": @(self.listID),
                         }
    };
    [ZD_NetWorkM postDataWithMethod:url parameters:dic succ:^(NSDictionary *obj) {
        ZD_HUD_DISMISS
        ZDDo_Block_Safe_Main1(success, obj[@"data"])
    } fail:^(NSError *error) {
        ZD_HUD_SHOW_ERROR(error)
    }];
}
#pragma mark GZActionSheet action 响应事件
- (void)postEmail // 发送邮件
{
    PGActivityPostEmailVC *post = [[PGActivityPostEmailVC alloc]init];
    [self setHidesBottomBarWhenPushed:YES];
    post.activityID = self.listID;
    [self.navigationController pushViewController:post animated:YES];
}

-(void)dealloc
{
    NSLog(@"没有泄露");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

*/

@end
