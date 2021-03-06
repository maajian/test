//
//  ZDAllActivityVC.m
//  zhundao
//
//  Created by maj on 2019/6/30.
//  Copyright © 2019 zhundao. All rights reserved.
//

#import "ZDCloseActivityVC.h"

#import "moreModalViewController.h"
#import "ListViewController.h"
#import "oneActivityViewController.h"

#import "ZDActivityCell.h"

#import "ZDActivityViewModel.h"

@interface ZDCloseActivityVC ()<UITableViewDataSource, UITableViewDelegate, ZDActivityCellDelegate> {
    NSInteger _page;
}

@property (nonatomic, strong) UITableView         *tableView;
@property (nonatomic, strong) ZDActivityViewModel *viewModel;

@end

static NSString *cellID = @"ActivityCellID";

@implementation ZDCloseActivityVC

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSet];
    [self initLayout];
    [self initNotifition];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_tableView reloadData];
}

#pragma mark --- lazyload
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [_tableView registerClass:[ZDActivityCell class] forCellReuseIdentifier:cellID];
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 5)];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.1)];
        _tableView.backgroundColor = ZDBackgroundColor;
        _tableView.sectionFooterHeight = CGFLOAT_MIN;
        _tableView.sectionHeaderHeight = 10;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.mj_header = [ZDRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        _tableView.mj_footer = [ZDRefreshNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    }
    return _tableView;
}
- (ZDActivityViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ZDActivityViewModel alloc] initWithType:ZDActivityTypeClose];
    }
    return _viewModel;
}

#pragma mark --- init
- (void)initSet {
    [self.view addSubview:self.tableView];
    [self.tableView.mj_header beginRefreshing];
}
- (void)initLayout {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
- (void)initNotifition {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadNewData) name:ZDNotification_Change_Account object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadNewData) name:ZDNotification_Load_Activity object:nil];
}

#pragma mark --- network
- (void)loadNewData {
    _page = 1;
    [self networkForCloseData];
}
- (void)loadMoreData {
    _page += 1;
    [self networkForCloseData];
}
- (void)networkForCloseData {
    ZD_WeakSelf
    [self.viewModel getCloseActivityListWithPageIndex:_page success:^(NSArray *obj) {
        [weakSelf.tableView endRefresh];
        if (!obj.count) {
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        if (weakSelf.searchText) {
            self.searchText = self.searchText;
        } else {
            [weakSelf.tableView reloadData];
        }
    } failure:^{
        [weakSelf.tableView endRefresh];
    }];
}

#pragma mark --- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.active ? self.viewModel.closeSearchArray.count : self.viewModel.closeDataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZDActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (self.active) {
        cell.model = self.viewModel.closeSearchArray[indexPath.section];
    } else {
        cell.model = self.viewModel.closeDataArray[indexPath.section];
    }
    cell.activityCellDelegate = self;
    return cell;
}

#pragma mark --- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  0.25 * kScreenWidth + 83;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    return  view;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZDActivityCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    ZDWebViewController *web = [[ZDWebViewController alloc] init];
    web.webTitle = @"活动详情";
    web.isClose = YES;
    web.urlString = [NSString stringWithFormat:@"https://m.zhundao.net/event/%li?token=%@",(long)cell.model.ID,[[SignManager shareManager] getToken]];
    [self.navigationController pushViewController:web animated:YES];
}

#pragma mark --- ZDActivityCellDelegate
// 点击
- (void)activityCell:(ZDActivityCell *)activityCell didTapListButton:(UIButton *)button {
    if (activityCell.model.HasJoinNum==0) {
        [[SignManager shareManager]showAlertWithTitle:@"暂无人参加,请下拉刷新数据" WithMessage:nil WithCTR:self];
    } else {
        ListViewController *list = [[ListViewController alloc]init];
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
// 签到
- (void)activityCell:(ZDActivityCell *)activityCell didTapSignButton:(UIButton *)button {
    oneActivityViewController *one = [[oneActivityViewController alloc]init];
    one.acID = activityCell.model.ID;
    one.activityName = activityCell.model.Title;
    [self.navigationController pushViewController:one animated:YES];
}
// 分享
- (void)activityCell:(ZDActivityCell *)activityCell didTapShareButton:(UIButton *)button {
    [[SignManager shareManager]shareImagewithModel:activityCell.model withCTR:self Withtype:5 withImage:nil];
}
// 更多点击
- (void)activityCell:(ZDActivityCell *)activityCell didTapMoreButton:(UIButton *)button {
    moreModalViewController *modal = [[moreModalViewController alloc]init];
    modal.moreModel = activityCell.model;
    [self.navigationController pushViewController:modal animated:YES];
    ZD_WeakSelf
    modal.backBlock = ^(NSInteger a) {
        if (a==1) {
            [weakSelf.viewModel.closeDataArray removeObject:activityCell.model];
            [weakSelf.viewModel.closeSearchArray removeObject:activityCell.model];
            [weakSelf.tableView reloadData];
        }
    };
}

#pragma mark --- setter
- (void)setSearchText:(NSString *)searchText {
    _searchText = searchText;
    [self.viewModel.closeSearchArray removeAllObjects];
    for (NSString *title in self.viewModel.closeTitleArray) {
        if ([title containsString:searchText]) {
            [self.viewModel.closeSearchArray addObject:[self.viewModel.closeDataArray objectAtIndex:[self.viewModel.closeTitleArray indexOfObject:title]]];
        }
    }
    [_tableView reloadData];
}

@end
