//
//  ZDDiscoverPromoteUserNumberVC.m
//  zhundao
//
//  Created by maj on 2020/1/6.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "ZDMePromoteUserNumberVC.h"

#import "ZDMePromoteUserNumberCell.h"

#import "ZDMePromoteUserNumberModel.h"
#import "ZDMePromoteUserNumberViewModel.h"

@interface ZDMePromoteUserNumberVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) ZDMePromoteUserNumberViewModel *viewModel;

@end

@implementation ZDMePromoteUserNumberVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSet];
    [self initLayout];
    [self networkForUserNumberList];
}
#pragma mark --- Lazyload
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = ZDBackgroundColor;
        _tableView.separatorColor = ZDLineColor;
        _tableView.rowHeight = 65;
        [_tableView registerClass:[ZDMePromoteUserNumberCell class] forCellReuseIdentifier:@"ZDMePromoteUserNumberCell"];
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.1)];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _tableView;
}
- (ZDMePromoteUserNumberViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ZDMePromoteUserNumberViewModel alloc] init];
    }
    return _viewModel;
}

#pragma mark --- Init
- (void)initSet {
    self.title = @"我的用户";
    [self.view addSubview:self.tableView];
}
- (void)initLayout {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(ZD_SAFE_BOTTOM_LAYOUT);
    }];
}

#pragma mark --- Network
- (void)networkForUserNumberList {
    ZD_WeakSelf
    [self.viewModel getUserNumberSuccess:^{
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
    ZDMePromoteUserNumberCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZDMePromoteUserNumberCell"];
    cell.model = self.viewModel.dataArray[indexPath.row];
    return cell;
}

@end
