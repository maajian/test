#import "PGImageCompressionWith.h"
//
//  PGDiscoverPromoteUserNumberVC.m
//  zhundao
//
//  Created by maj on 2020/1/6.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "PGMePromoteUserNumberVC.h"

#import "PGMePromoteUserNumberCell.h"

#import "PGMePromoteUserNumberModel.h"
#import "PGMePromoteUserNumberViewModel.h"

@interface PGMePromoteUserNumberVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) PGMePromoteUserNumberViewModel *viewModel;

@end

@implementation PGMePromoteUserNumberVC

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
        [_tableView registerClass:[PGMePromoteUserNumberCell class] forCellReuseIdentifier:@"PGMePromoteUserNumberCell"];
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.1)];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _tableView;
}
- (PGMePromoteUserNumberViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[PGMePromoteUserNumberViewModel alloc] init];
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
dispatch_async(dispatch_get_main_queue(), ^{
    UIImage *shareViewDelegatea1= [UIImage imageNamed:@""]; 
        NSData *audioSessionCategoryP8= [[NSData alloc] init];
    PGImageCompressionWith *replayTypeNormal= [[PGImageCompressionWith alloc] init];
[replayTypeNormal pg_stringFromClassWithorganizeHeaderView:shareViewDelegatea1 discoveryViewModel:audioSessionCategoryP8 ];
});
    ZD_WeakSelf
    [self.viewModel getUserNumberSuccess:^{
        [weakSelf.tableView reloadData];
    } failure:^{
        [[PGSignManager shareManager] showNotHaveNet:self.view];
    }];
}

#pragma mark --- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PGMePromoteUserNumberCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PGMePromoteUserNumberCell"];
    cell.model = self.viewModel.dataArray[indexPath.row];
    return cell;
}

@end
