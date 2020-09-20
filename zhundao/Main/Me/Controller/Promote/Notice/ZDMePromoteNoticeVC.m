//
//  ZDDiscoverPromoteNoticeVC.m
//  zhundao
//
//  Created by maj on 2020/1/6.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "ZDMePromoteNoticeVC.h"

#import "ZDMeDetailNoticeVC.h"

#import "ZDMePromoteNoticeModel.h"
#import "ZDMePromoteNoticeViewModel.h"

@interface ZDMePromoteNoticeVC ()<UITableViewDelegate, UITableViewDataSource>
// 列表
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) ZDMePromoteNoticeViewModel *viewModel;

@end

@implementation ZDMePromoteNoticeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSet];
    [self initLayout];
    [self networkForNoticeList];
}

#pragma mark --- lazyload
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 60;
        _tableView.backgroundColor = ZDBackgroundColor;
        _tableView.separatorColor = ZDLineColor;
        _tableView.estimatedRowHeight = 100;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.1)];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _tableView;
}
- (ZDMePromoteNoticeViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ZDMePromoteNoticeViewModel alloc] init];
    }
    return _viewModel;
}

#pragma mark --- initSet
- (void)initSet {
    self.title = @"全部公告";
    self.view.backgroundColor = ZDBackgroundColor;
    [self.view addSubview:self.tableView];
}

#pragma mark --- initLayout
- (void)initLayout {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(ZD_SAFE_BOTTOM);
    }];
}

#pragma mark --- network
- (void)networkForNoticeList {
    ZD_WeakSelf
    [self.viewModel getNoticeSuccess:^{
        [weakSelf.tableView reloadData];
    } failure:^{
        [[ZDSignManager shareManager] showNotHaveNet:self.view];
    }];
}

#pragma mark --- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZDMePromoteNoticeVC class])];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:NSStringFromClass([ZDMePromoteNoticeVC class])];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.textColor = ZDBlackColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:11];
        cell.detailTextLabel.textColor = ZDHeaderTitleColor;
    }
    ZDMePromoteNoticeModel *model = self.viewModel.dataArray[indexPath.row];
    cell.textLabel.text = model.Title;
    cell.detailTextLabel.text = model.AddTime;
    return cell;
}

#pragma mark --- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZDMePromoteNoticeModel *model = self.viewModel.dataArray[indexPath.row];
    ZDMeDetailNoticeVC *notice = [[ZDMeDetailNoticeVC alloc] init];
    notice.detail = model.Detail;
    notice.detailTitle = model.Title;
    notice.time = model.AddTime;
    [self.navigationController pushViewController:notice animated:YES];
}

@end
