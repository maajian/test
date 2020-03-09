//
//  ZDDiscoverPromoteIncomeVC.m
//  zhundao
//
//  Created by maj on 2020/1/6.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "ZDMePromoteIncomeVC.h"

#import "ZDMePromoteIncomeCell.h"
#import "ZDMePromoteIncomeHeaderView.h"

#import "ZDMePromoteIncomeModel.h"
#import "ZDMePromoteIncomeViewModel.h"

@interface ZDMePromoteIncomeVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) ZDMePromoteIncomeViewModel *viewModel;

@end

@implementation ZDMePromoteIncomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSet];
    [self initLayout];
    [self networkForIncomeList];
}
#pragma mark --- Lazyload
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = ZDBackgroundColor;
        _tableView.separatorColor = ZDLineColor;
        _tableView.rowHeight = 50;
        [_tableView registerClass:[ZDMePromoteIncomeCell class] forCellReuseIdentifier:@"ZDMePromoteUserNumberCell"];
        _tableView.tableHeaderView = [[ZDMePromoteIncomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _tableView;
}
- (ZDMePromoteIncomeViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ZDMePromoteIncomeViewModel alloc] init];
    }
    return _viewModel;
}

#pragma mark --- Init
- (void)initSet {
    self.title = @"我的收益";
    [self.view addSubview:self.tableView];
}
- (void)initLayout {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(ZD_SAFE_BOTTOM_LAYOUT);
    }];
}

#pragma mark --- Network
- (void)networkForIncomeList {
    ZD_WeakSelf
    [self.viewModel getIncomeSuccess:^{
        [weakSelf.tableView reloadData];
    } failure:^{
        [[SignManager shareManager] showNotHaveNet:self.view];
    }];
}

#pragma mark --- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZDMePromoteIncomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZDMePromoteUserNumberCell"];
    cell.model = self.viewModel.dataArray[indexPath.row];
    return cell;
}

@end
