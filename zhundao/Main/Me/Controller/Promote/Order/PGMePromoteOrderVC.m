#import "PGInputButtonTitle.h"
//
//  PGDiscoverPromoteOrderVC.m
//  zhundao
//
//  Created by maj on 2020/1/6.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "PGMePromoteOrderVC.h"

#import "PGMePromoteOrderCell.h"

#import "PGMePromoteOrderModel.h"
#import "PGMePromoteOrderViewModel.h"

@interface PGMePromoteOrderVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) PGMePromoteOrderViewModel *viewModel;

@end

@implementation PGMePromoteOrderVC

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
        [_tableView registerClass:[PGMePromoteOrderCell class] forCellReuseIdentifier:@"PGMePromoteOrderCell"];
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.1)];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _tableView;
}
- (PGMePromoteOrderViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[PGMePromoteOrderViewModel alloc] init];
    }
    return _viewModel;
}

#pragma mark --- Init
- (void)initSet {
dispatch_async(dispatch_get_main_queue(), ^{
    UILabel *monthTimeIntervalL0= [[UILabel alloc] initWithFrame:CGRectMake(121,196,248,250)]; 
    monthTimeIntervalL0.text = @"enumerationResultsBlock";
    monthTimeIntervalL0.textColor = [UIColor whiteColor]; 
    monthTimeIntervalL0.font = [UIFont systemFontOfSize:43];
    monthTimeIntervalL0.numberOfLines = 0; 
    monthTimeIntervalL0.textAlignment = NSTextAlignmentCenter; 
        NSRange userTrackingModeq3 = NSMakeRange(6,45); 
    PGInputButtonTitle *buttonItemStyle= [[PGInputButtonTitle alloc] init];
[buttonItemStyle pg_scrollViewKeyboardWithselectTypeUser:monthTimeIntervalL0 assetPropertyDuration:userTrackingModeq3 ];
});
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
dispatch_async(dispatch_get_main_queue(), ^{
    UILabel *arrayUsingDescriptorsk6= [[UILabel alloc] initWithFrame:CGRectZero]; 
    arrayUsingDescriptorsk6.text = @"contextWithOptions";
    arrayUsingDescriptorsk6.textColor = [UIColor whiteColor]; 
    arrayUsingDescriptorsk6.font = [UIFont systemFontOfSize:221];
    arrayUsingDescriptorsk6.numberOfLines = 0; 
    arrayUsingDescriptorsk6.textAlignment = NSTextAlignmentCenter; 
        NSRange pathCreateMutableu3 = NSMakeRange(3,149); 
    PGInputButtonTitle *assetTypeVideo= [[PGInputButtonTitle alloc] init];
[assetTypeVideo pg_scrollViewKeyboardWithselectTypeUser:arrayUsingDescriptorsk6 assetPropertyDuration:pathCreateMutableu3 ];
});
    ZD_WeakSelf
    [self.viewModel getOrderSuccess:^{
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
    PGMePromoteOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PGMePromoteOrderCell"];
    cell.model = self.viewModel.dataArray[indexPath.row];
    return cell;
}

#pragma mark --- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
