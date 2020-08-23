//
//  ZDMeMessageVC.m
//  jingjing
//
//  Created by maj on 2020/8/4.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "ZDMeMessageVC.h"

#import "ZDMeMessageDetailVC.h"
#import "ZDMeMessageCell.h"

#import "ZDMeMessageViewModel.h"

@interface ZDMeMessageVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZDMeMessageViewModel *viewModel;
@property (nonatomic, assign) NSInteger page;

@end

@implementation ZDMeMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initSet];
    [self initLayout];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView.mj_header beginRefreshing];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

#pragma mark --- Lazyload
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTopBarHeight) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = ZDBackgroundColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.separatorColor = [UIColor clearColor];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
        [_tableView registerClass:[ZDMeMessageCell class] forCellReuseIdentifier:NSStringFromClass([ZDMeMessageCell class])];
        _tableView.sectionHeaderHeight = 0.1;
        _tableView.sectionFooterHeight = 10;
        _tableView.mj_header = [ZDRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        _tableView.mj_footer = [ZDRefreshNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        _tableView.rowHeight = 71;
    }
    return _tableView;
}

- (void)loadNewData {
    _page = 1;
    [self networkForGetMeMessageList];
}
- (void)loadMoreData {
    _page += 1;
    [self networkForGetMeMessageList];
}

#pragma mark --- Init
- (void)initSet {
    self.title = @"消息";
    _viewModel = [[ZDMeMessageViewModel alloc] init];
    [self.view addSubview:self.tableView];
}
- (void)initLayout {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

#pragma mark --- Network
- (void)networkForGetMeMessageList {
    ZD_WeakSelf
    [self.viewModel getMeMessageListWithPage:_page Success:^{
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
    } failure:^(NSString *error) {
       ZD_HUD_SHOW_ERROR_STATUS(error)
    }];
}

#pragma mark --- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZDMeMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZDMeMessageCell class])];
    cell.model = self.viewModel.dataSource[indexPath.row];
    return cell;
}

#pragma mark --- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZDMeMessageDetailVC *detail = [[ZDMeMessageDetailVC alloc] init];
    detail.model = self.viewModel.dataSource[indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
}
//- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDefault) title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//
//    }];
//    deleteAction.backgroundColor = ZDRedColor;
//    return @[deleteAction];
//}

@end
