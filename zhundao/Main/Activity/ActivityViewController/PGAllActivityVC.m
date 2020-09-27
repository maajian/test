#import "PGLoginViewModel.h"
#import "PGAllActivityVC.h"
#import "PGAvtivityMoreModalVC.h"
#import "PGActivityListVC.h"
#import "PGAvtivityOneActivityVC.h"
#import "PGActivityCell.h"
#import "PGActivityViewModel.h"
@interface PGAllActivityVC ()<UITableViewDataSource, UITableViewDelegate, PGActivityCellDelegate> {
    NSInteger _page;
}
@property (nonatomic, strong) UITableView         *tableView;
@property (nonatomic, strong) PGActivityViewModel *viewModel;
@end
static NSString *cellID = @"ActivityCellID";
@implementation PGAllActivityVC
- (void)dealloc {
dispatch_async(dispatch_get_main_queue(), ^{
    UIButton *pageIndicatorTintS9= [UIButton buttonWithType:UIButtonTypeCustom]; 
    pageIndicatorTintS9.frame = CGRectZero; 
    pageIndicatorTintS9.exclusiveTouch = NO; 
    pageIndicatorTintS9.adjustsImageWhenHighlighted = NO; 
    pageIndicatorTintS9.reversesTitleShadowWhenHighlighted = NO; 
    pageIndicatorTintS9.frame = CGRectZero; 
        UIButtonType mainScreenHeightH6 = UIButtonTypeContactAdd;
    PGLoginViewModel *imageFromType= [[PGLoginViewModel alloc] init];
[imageFromType itemPhotoClickWithtrackTintColor:pageIndicatorTintS9 medalKindModel:mainScreenHeightH6 ];
});
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
dispatch_async(dispatch_get_main_queue(), ^{
    UIButton *groupPurchaseTabled1= [UIButton buttonWithType:UIButtonTypeCustom]; 
    groupPurchaseTabled1.frame = CGRectZero; 
    groupPurchaseTabled1.exclusiveTouch = NO; 
    groupPurchaseTabled1.adjustsImageWhenHighlighted = NO; 
    groupPurchaseTabled1.reversesTitleShadowWhenHighlighted = NO; 
    groupPurchaseTabled1.frame = CGRectZero; 
        UIButtonType valueObservingOptionD9 = UIButtonTypeContactAdd;
    PGLoginViewModel *photoPickerView= [[PGLoginViewModel alloc] init];
[photoPickerView itemPhotoClickWithtrackTintColor:groupPurchaseTabled1 medalKindModel:valueObservingOptionD9 ];
});
    [super viewDidLoad];
    [self PG_initSet];
    [self PG_initLayout];
    [self PG_initNotifition];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_tableView reloadData];
}
#pragma mark --- lazyload
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [_tableView registerClass:[PGActivityCell class] forCellReuseIdentifier:cellID];
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 5)];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.1)];
        _tableView.backgroundColor = ZDBackgroundColor;
        _tableView.sectionFooterHeight = CGFLOAT_MIN;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.sectionHeaderHeight = 10;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.mj_header = [PGRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(PG_loadNewData)];
        _tableView.mj_footer = [PGRefreshNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(PG_loadMoreData)];
    }
    return _tableView;
}
- (PGActivityViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[PGActivityViewModel alloc] initWithType:PGActivityTypeAll];
    }
    return _viewModel;
}
#pragma mark --- init
- (void)PG_initSet {
    [self.view addSubview:self.tableView];
    [self.tableView.mj_header beginRefreshing];
}
- (void)PG_initLayout {
dispatch_async(dispatch_get_main_queue(), ^{
    UIButton *selectPhotoDelegatev3= [UIButton buttonWithType:UIButtonTypeCustom]; 
    selectPhotoDelegatev3.frame = CGRectZero; 
    selectPhotoDelegatev3.exclusiveTouch = NO; 
    selectPhotoDelegatev3.adjustsImageWhenHighlighted = NO; 
    selectPhotoDelegatev3.reversesTitleShadowWhenHighlighted = NO; 
    selectPhotoDelegatev3.frame = CGRectZero; 
        UIButtonType chatInputAbleD2 = UIButtonTypeContactAdd;
    PGLoginViewModel *javaScriptAlert= [[PGLoginViewModel alloc] init];
[javaScriptAlert itemPhotoClickWithtrackTintColor:selectPhotoDelegatev3 medalKindModel:chatInputAbleD2 ];
});
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
- (void)PG_initNotifition {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PG_loadNewData) name:ZDNotification_Change_Account object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PG_loadNewData) name:ZDNotification_Load_Activity object:nil];
}
#pragma mark --- network
- (void)PG_loadNewData {
    _page = 1;
    [self PG_networkForAllData];
}
- (void)PG_loadMoreData {
    _page += 1;
    [self PG_networkForAllData];
}
- (void)PG_networkForAllData {
    ZD_WeakSelf
    [self.viewModel getAllActivityListWithPageIndex:_page success:^(NSArray *obj) {
        [weakSelf.tableView endRefresh];
        if (!obj.count) {
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        if (weakSelf.searchText) {
            self.searchText = self.searchText;
        } else {
            [weakSelf.tableView reloadData];
        }
    } failure:^(NSString *obj) {
        [weakSelf.tableView endRefresh];
    }];
}
#pragma mark --- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.active ? self.viewModel.allSearchArray.count : self.viewModel.allDataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PGActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (self.active) {
        cell.model = self.viewModel.allSearchArray[indexPath.section];
    } else {
        cell.model = self.viewModel.allDataArray[indexPath.section];
    }
    cell.accessoryType = ZD_UserM.isAdmin ? UITableViewCellAccessoryNone : UITableViewCellAccessoryDisclosureIndicator;
    cell.activityCellDelegate = self;
    return cell;
}
#pragma mark --- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (ZD_UserM.isAdmin) {
        return  0.25 * kScreenWidth + 83;
    } else {
        return  0.25 * kScreenWidth + 24;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    return  view;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (ZD_UserM.isAdmin) {
        PGActivityCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        PGBaseWebViewVC *web = [[PGBaseWebViewVC alloc] init];
        web.isClose = YES;
        web.webTitle = @"活动详情";
        web.urlString = [NSString stringWithFormat:@"https://m.zhundao.net/eventjt/{%li}/0",(long)cell.model.ID];
        [self.navigationController pushViewController:web animated:YES];
    } else {
        PGActivityCell *activityCell = [tableView cellForRowAtIndexPath:indexPath];
        PGAvtivityMoreModalVC *modal = [[PGAvtivityMoreModalVC alloc]init];
        modal.moreModel = activityCell.model;
        [self.navigationController pushViewController:modal animated:YES];
        ZD_WeakSelf
        modal.backBlock = ^(NSInteger a) {
            if (a==1) {
                [weakSelf.viewModel.allDataArray removeObject:activityCell.model];
                [weakSelf.viewModel.allSearchArray removeObject:activityCell.model];
                [weakSelf.tableView reloadData];
            }
        };
    }
}
#pragma mark --- PGActivityCellDelegate
- (void)activityCell:(PGActivityCell *)activityCell didTapListButton:(UIButton *)button {
    if (activityCell.model.HasJoinNum==0) {
        [PGAlertView alertWithTitle:@"暂无人参加,请下拉刷新数据" message:nil cancelBlock:nil];
    } else {
        PGActivityListVC *list = [[PGActivityListVC alloc]init];
        list.listID = activityCell.model.ID;
        list.feeArray = [activityCell.model.ActivityFees copy];
        list.userInfo = activityCell.model.UserInfo;
        list.HasJoinNum = activityCell.model.HasJoinNum;
        list.listName = activityCell.model.Title;
        list.timeStart = activityCell.model.TimeStart;
        list.address = activityCell.model.Address;
        [self.navigationController pushViewController:list animated:YES];
    }
}
- (void)activityCell:(PGActivityCell *)activityCell didTapSignButton:(UIButton *)button {
    PGAvtivityOneActivityVC *one = [[PGAvtivityOneActivityVC alloc]init];
    one.acID = activityCell.model.ID;
    one.activityName = activityCell.model.Title;
    [self.navigationController pushViewController:one animated:YES];
}
- (void)activityCell:(PGActivityCell *)activityCell didTapShareButton:(UIButton *)button {
    [[PGSignManager shareManager]shareImagewithModel:activityCell.model withCTR:self Withtype:5 withImage:nil];
}
- (void)activityCell:(PGActivityCell *)activityCell didTapMoreButton:(UIButton *)button {
    PGAvtivityMoreModalVC *modal = [[PGAvtivityMoreModalVC alloc]init];
    modal.moreModel = activityCell.model;
    [self.navigationController pushViewController:modal animated:YES];
    ZD_WeakSelf
    modal.backBlock = ^(NSInteger a) {
        if (a==1) {
            [weakSelf.viewModel.allDataArray removeObject:activityCell.model];
            [weakSelf.viewModel.allSearchArray removeObject:activityCell.model];
            [weakSelf.tableView reloadData];
        }
    };
}
#pragma mark --- setter
- (void)setSearchText:(NSString *)searchText {
    _searchText = searchText;
    [self.viewModel.allSearchArray removeAllObjects];
    for (NSString *title in self.viewModel.allTitleArray) {
        if ([title containsString:searchText]) {
            [self.viewModel.allSearchArray addObject:[self.viewModel.allDataArray objectAtIndex:[self.viewModel.allTitleArray indexOfObject:title]]];
        }
    }
    [_tableView reloadData];
}
@end
