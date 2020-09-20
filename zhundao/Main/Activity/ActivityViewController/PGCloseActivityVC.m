#import "PGWithArticleOriginal.h"
//
//  PGAllActivityVC.m
//  zhundao
//
//  Created by maj on 2019/6/30.
//  Copyright © 2019 zhundao. All rights reserved.
//

#import "PGCloseActivityVC.h"

#import "PGAvtivityMoreModalVC.h"
#import "PGActivityListVC.h"
#import "PGAvtivityOneActivityVC.h"

#import "PGActivityCell.h"

#import "PGActivityViewModel.h"

@interface PGCloseActivityVC ()<UITableViewDataSource, UITableViewDelegate, PGActivityCellDelegate> {
    NSInteger _page;
}

@property (nonatomic, strong) UITableView         *tableView;
@property (nonatomic, strong) PGActivityViewModel *viewModel;

@end

static NSString *cellID = @"ActivityCellID";

@implementation PGCloseActivityVC

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
        [_tableView registerClass:[PGActivityCell class] forCellReuseIdentifier:cellID];
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 5)];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.1)];
        _tableView.backgroundColor = ZDBackgroundColor;
        _tableView.sectionFooterHeight = CGFLOAT_MIN;
        _tableView.sectionHeaderHeight = 10;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.mj_header = [PGRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        _tableView.mj_footer = [PGRefreshNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    }
    return _tableView;
}
- (PGActivityViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[PGActivityViewModel alloc] initWithType:PGActivityTypeClose];
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
dispatch_async(dispatch_get_main_queue(), ^{
    UITextFieldViewMode playerDecodeErrort4 = UITextFieldViewModeAlways; 
        NSMutableArray *photoSelectableWithT2= [NSMutableArray arrayWithCapacity:0];
    PGWithArticleOriginal *edgeInsetsZero= [[PGWithArticleOriginal alloc] init];
[edgeInsetsZero pg_mainCommentTableWithpressEmojiAction:playerDecodeErrort4 userCommentModel:photoSelectableWithT2 ];
});
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
    } failure:^(NSString *obj) {
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
    PGActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (self.active) {
        cell.model = self.viewModel.closeSearchArray[indexPath.section];
    } else {
        cell.model = self.viewModel.closeDataArray[indexPath.section];
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
// 点击
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
// 签到
- (void)activityCell:(PGActivityCell *)activityCell didTapSignButton:(UIButton *)button {
    PGAvtivityOneActivityVC *one = [[PGAvtivityOneActivityVC alloc]init];
    one.acID = activityCell.model.ID;
    one.activityName = activityCell.model.Title;
    [self.navigationController pushViewController:one animated:YES];
}
// 分享
- (void)activityCell:(PGActivityCell *)activityCell didTapShareButton:(UIButton *)button {
    [[PGSignManager shareManager]shareImagewithModel:activityCell.model withCTR:self Withtype:5 withImage:nil];
}
// 更多点击
- (void)activityCell:(PGActivityCell *)activityCell didTapMoreButton:(UIButton *)button {
    PGAvtivityMoreModalVC *modal = [[PGAvtivityMoreModalVC alloc]init];
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
