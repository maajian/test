#import "PGDailyCourseModel.h"
#import "PGMePromoteCustomContactVC.h"
#import "PGMePromoteIncomeVC.h"
#import "PGMePromoteUserNumberVC.h"
#import "PGMePromoteOrderVC.h"
#import "PGMePromoteQRCodeVC.h"
#import "PGMePromoteNoticeVC.h"
#import "PGMeDetailNoticeVC.h"
#import "PGMePromoteCustomContactCell.h"
#import "PGMePromoteCustomContactHeaderView.h"
#import "PGMePromoteCustomContactViewModel.h"
@interface PGMePromoteCustomContactVC ()<UITableViewDataSource, UITableViewDelegate, PGMePromoteCustomContactHeaderViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) PGMePromoteCustomContactHeaderView *headerView;
@property (nonatomic, strong) PGMePromoteCustomContactViewModel *viewModel;
@end
@implementation PGMePromoteCustomContactVC
- (void)viewDidLoad {
dispatch_async(dispatch_get_main_queue(), ^{
    UIEdgeInsets errorWithStatusm7 = UIEdgeInsetsMake(85,86,72,40); 
        UISwitch *videoSendIconb6= [[UISwitch alloc] initWithFrame:CGRectMake(215,69,178,62)]; 
    videoSendIconb6.on = YES; 
    videoSendIconb6.onTintColor = [UIColor whiteColor]; 
    PGDailyCourseModel *receiveRemoteNotification= [[PGDailyCourseModel alloc] init];
[receiveRemoteNotification interfaceOrientationMaskWithtrainCommentModel:errorWithStatusm7 receiveMemoryWarning:videoSendIconb6 ];
});
    [super viewDidLoad];
    [self PG_initSet];
    [self PG_initLayout];
    [self PG_networkForCustomContact];
    [self PG_networkForZDBi];
    [self PG_networkForNotice];
}
#pragma mark --- Lazyload
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.backgroundColor = ZDBackgroundColor;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[PGMePromoteCustomContactCell class] forCellReuseIdentifier:@"PGMePromoteCustomContactCell"];
        _tableView.rowHeight = 130;
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}
- (PGMePromoteCustomContactViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[PGMePromoteCustomContactViewModel alloc] init];
    }
    return _viewModel;
}
#pragma mark --- Init
- (void)PG_initSet {
    self.view.backgroundColor = ZDBackgroundColor;
    [self.view addSubview:self.tableView];
}
- (void)PG_initLayout {
   [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
#pragma mark --- Network
- (void)PG_networkForCustomContact {
    ZD_WeakSelf
    [self.viewModel getPromoteCustomContactSuccess:^{
        [weakSelf.tableView reloadData];
    } failure:^{
        [[PGSignManager shareManager] showNotHaveNet:self.view];
    }];
}
- (void)PG_networkForZDBi {
    ZD_WeakSelf
    [self.viewModel getZDBiSuccess:^{
        [weakSelf.tableView reloadData];
    } failure:^{
        [[PGSignManager shareManager] showNotHaveNet:self.view];
    }];
}
- (void)PG_networkForNotice {
dispatch_async(dispatch_get_main_queue(), ^{
    UIEdgeInsets assetExportSessiong1 = UIEdgeInsetsMake(166,98,117,128); 
        UISwitch *courseChoicenessColumnistJ1= [[UISwitch alloc] initWithFrame:CGRectZero]; 
    courseChoicenessColumnistJ1.on = YES; 
    courseChoicenessColumnistJ1.onTintColor = [UIColor whiteColor]; 
    PGDailyCourseModel *weekdayCalendarUnit= [[PGDailyCourseModel alloc] init];
[weekdayCalendarUnit interfaceOrientationMaskWithtrainCommentModel:assetExportSessiong1 receiveMemoryWarning:courseChoicenessColumnistJ1 ];
});
    ZD_WeakSelf
    [self.viewModel getNoticeSuccess:^{
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
    PGMePromoteCustomContactCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PGMePromoteCustomContactCell"];
    cell.model = self.viewModel.dataArray[indexPath.row];
    return cell;
}
#pragma mark --- UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    PGMePromoteCustomContactHeaderView *headerView = [[PGMePromoteCustomContactHeaderView alloc] initWithFrame:CGRectMake(0, 0, ZD_ScreenWidth, 120)];
    headerView.zhundaoBi = self.viewModel.zhundaoBi;
    headerView.noticeArray = self.viewModel.noticeArray;
    headerView.promoteCustomContactHeaderViewDelegate = self;
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 120;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PGMePromoteCustomContactModel *model = self.viewModel.dataArray[indexPath.row];
    if (model.promoteCustomContactType == PGMePromoteCustomContactTypeIncome) {
        PGMePromoteIncomeVC *income = [[PGMePromoteIncomeVC alloc] init];
        [self.navigationController pushViewController:income animated:YES];
    } else if (model.promoteCustomContactType == PGMePromoteCustomContactTypeUserNumber) {
        PGMePromoteUserNumberVC *userNumber = [[PGMePromoteUserNumberVC alloc] init];
        [self.navigationController pushViewController:userNumber animated:YES];
    } else {
        PGMePromoteOrderVC *order = [[PGMePromoteOrderVC alloc] init];
        [self.navigationController pushViewController:order animated:YES];
    }
}
#pragma mark --- PGMePromoteCustomContactHeaderViewDelegate
- (void)promoteCustomContactHeaderView:(PGMePromoteCustomContactHeaderView *)promoteCustomContactHeaderView didTapExtendButton:(UIButton *)button {
    PGMePromoteQRCodeVC *qrcode = [[PGMePromoteQRCodeVC alloc] init];
    [self.navigationController pushViewController:qrcode animated:YES];
}
- (void)promoteCustomContactHeaderView:(PGMePromoteCustomContactHeaderView *)promoteCustomContactHeaderView didTapMoreButton:(UIButton *)button {
    PGMePromoteNoticeVC *notice = [[PGMePromoteNoticeVC alloc] init];
    [self.navigationController pushViewController:notice animated:YES];
}
- (void)promoteCustomContactHeaderView:(PGMePromoteCustomContactHeaderView *)promoteCustomContactHeaderView didTapNotice:(nonnull PGMePromoteNoticeModel *)model {
    PGMeDetailNoticeVC *notice = [[PGMeDetailNoticeVC alloc] init];
    notice.detail = model.Detail;
    notice.detailTitle = model.Title;
    notice.time = model.AddTime;
    [self.navigationController pushViewController:notice animated:YES];
}
@end
