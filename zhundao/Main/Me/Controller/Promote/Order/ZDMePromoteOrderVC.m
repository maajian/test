//
//  ZDDiscoverPromoteOrderVC.m
//  zhundao
//
//  Created by maj on 2020/1/6.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "ZDMePromoteOrderVC.h"

#import "ZDMePromoteOrderCell.h"

#import "ZDMePromoteOrderModel.h"
#import "ZDMePromoteOrderViewModel.h"

@interface ZDMePromoteOrderVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) ZDMePromoteOrderViewModel *viewModel;

@end

@implementation ZDMePromoteOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSet];
    [self initLayout];
    [self networkForOrderList];
}
#pragma mark --- Lazyload
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = ZDBackgroundColor;
        _tableView.rowHeight = 170;
        [_tableView registerClass:[ZDMePromoteOrderCell class] forCellReuseIdentifier:@"ZDMePromoteOrderCell"];
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.1)];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _tableView;
}
- (ZDMePromoteOrderViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ZDMePromoteOrderViewModel alloc] init];
    }
    return _viewModel;
}

#pragma mark --- Init
- (void)initSet {
    self.title = @"我的订单";
    [self.view addSubview:self.tableView];
}
- (void)initLayout {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(ZD_SAFE_BOTTOM_LAYOUT);
    }];
}

#pragma mark --- Network
- (void)networkForOrderList {
    ZD_WeakSelf
    [self.viewModel getOrderSuccess:^{
        [weakSelf.tableView reloadData];
    } failure:^{
        [[ZDDataManager shareManager] showNotHaveNet:self.view];
    }];
}

#pragma mark --- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZDMePromoteOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZDMePromoteOrderCell"];
    cell.model = self.viewModel.dataArray[indexPath.row];
    return cell;
}

#pragma mark --- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
