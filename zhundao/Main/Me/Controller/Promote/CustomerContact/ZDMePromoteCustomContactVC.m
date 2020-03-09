//
//  ZDDiscoverPromoteCostomContactVC.m
//  zhundao
//
//  Created by maj on 2020/1/6.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "ZDMePromoteCustomContactVC.h"

#import "ZDMePromoteIncomeVC.h"
#import "ZDMePromoteUserNumberVC.h"
#import "ZDMePromoteOrderVC.h"
#import "ZDMePromoteQRCodeVC.h"
#import "ZDMePromoteNoticeVC.h"
#import "DetailNoticeViewController.h"

#import "ZDMePromoteCustomContactCell.h"
#import "ZDMePromoteCustomContactHeaderView.h"

#import "ZDMePromoteCustomContactViewModel.h"

@interface ZDMePromoteCustomContactVC ()<UITableViewDataSource, UITableViewDelegate, ZDMePromoteCustomContactHeaderViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
// 头视图
@property (nonatomic, strong) ZDMePromoteCustomContactHeaderView *headerView;

@property (nonatomic, strong) ZDMePromoteCustomContactViewModel *viewModel;

@end

@implementation ZDMePromoteCustomContactVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSet];
    [self initLayout];
    [self networkForCustomContact];
    [self networkForZDBi];
    [self networkForNotice];
}

#pragma mark --- Lazyload
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.backgroundColor = ZDBackgroundColor;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[ZDMePromoteCustomContactCell class] forCellReuseIdentifier:@"ZDMePromoteCustomContactCell"];
        _tableView.rowHeight = 130;
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}
- (ZDMePromoteCustomContactViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ZDMePromoteCustomContactViewModel alloc] init];
    }
    return _viewModel;
}

#pragma mark --- Init
- (void)initSet {
    self.view.backgroundColor = ZDBackgroundColor;
    [self.view addSubview:self.tableView];
}

- (void)initLayout {
   [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark --- Network
- (void)networkForCustomContact {
    ZD_WeakSelf
    [self.viewModel getPromoteCustomContactSuccess:^{
        [weakSelf.tableView reloadData];
    } failure:^{
        [[SignManager shareManager] showNotHaveNet:self.view];
    }];
}
- (void)networkForZDBi {
    ZD_WeakSelf
    [self.viewModel getZDBiSuccess:^{
        [weakSelf.tableView reloadData];
    } failure:^{
        [[SignManager shareManager] showNotHaveNet:self.view];
    }];
}
- (void)networkForNotice {
    ZD_WeakSelf
    [self.viewModel getNoticeSuccess:^{
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
    ZDMePromoteCustomContactCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZDMePromoteCustomContactCell"];
    cell.model = self.viewModel.dataArray[indexPath.row];
    return cell;
}

#pragma mark --- UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ZDMePromoteCustomContactHeaderView *headerView = [[ZDMePromoteCustomContactHeaderView alloc] initWithFrame:CGRectMake(0, 0, ZD_ScreenWidth, 120)];
    headerView.zhundaoBi = self.viewModel.zhundaoBi;
    headerView.noticeArray = self.viewModel.noticeArray;
    headerView.promoteCustomContactHeaderViewDelegate = self;
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZDMePromoteCustomContactModel *model = self.viewModel.dataArray[indexPath.row];
    if (model.promoteCustomContactType == ZDMePromoteCustomContactTypeIncome) {
        ZDMePromoteIncomeVC *income = [[ZDMePromoteIncomeVC alloc] init];
        [self.navigationController pushViewController:income animated:YES];
    } else if (model.promoteCustomContactType == ZDMePromoteCustomContactTypeUserNumber) {
        ZDMePromoteUserNumberVC *userNumber = [[ZDMePromoteUserNumberVC alloc] init];
        [self.navigationController pushViewController:userNumber animated:YES];
    } else {
        ZDMePromoteOrderVC *order = [[ZDMePromoteOrderVC alloc] init];
        [self.navigationController pushViewController:order animated:YES];
    }
}

#pragma mark --- ZDMePromoteCustomContactHeaderViewDelegate
- (void)promoteCustomContactHeaderView:(ZDMePromoteCustomContactHeaderView *)promoteCustomContactHeaderView didTapExtendButton:(UIButton *)button {
    ZDMePromoteQRCodeVC *qrcode = [[ZDMePromoteQRCodeVC alloc] init];
    [self.navigationController pushViewController:qrcode animated:YES];
}
- (void)promoteCustomContactHeaderView:(ZDMePromoteCustomContactHeaderView *)promoteCustomContactHeaderView didTapMoreButton:(UIButton *)button {
    ZDMePromoteNoticeVC *notice = [[ZDMePromoteNoticeVC alloc] init];
    [self.navigationController pushViewController:notice animated:YES];
}
- (void)promoteCustomContactHeaderView:(ZDMePromoteCustomContactHeaderView *)promoteCustomContactHeaderView didTapNotice:(nonnull ZDMePromoteNoticeModel *)model {
    DetailNoticeViewController *notice = [[DetailNoticeViewController alloc] init];
    notice.detail = model.Detail;
    notice.detailTitle = model.Title;
    notice.time = model.AddTime;
    [self.navigationController pushViewController:notice animated:YES];
}

@end
