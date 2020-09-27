#import "PGSelectOriginalPhoto.h"
#import "PGMePromoteNoticeVC.h"
#import "PGMeDetailNoticeVC.h"
#import "PGMePromoteNoticeModel.h"
#import "PGMePromoteNoticeViewModel.h"
@interface PGMePromoteNoticeVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) PGMePromoteNoticeViewModel *viewModel;
@end
@implementation PGMePromoteNoticeVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self PG_initSet];
    [self PG_initLayout];
    [self PG_networkForNoticeList];
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
- (PGMePromoteNoticeViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[PGMePromoteNoticeViewModel alloc] init];
    }
    return _viewModel;
}
#pragma mark --- PG_initSet
- (void)PG_initSet {
    self.title = @"全部公告";
    self.view.backgroundColor = ZDBackgroundColor;
    [self.view addSubview:self.tableView];
}
#pragma mark --- PG_initLayout
- (void)PG_initLayout {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(ZD_SAFE_BOTTOM);
    }];
}
#pragma mark --- network
- (void)PG_networkForNoticeList {
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PGMePromoteNoticeVC class])];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:NSStringFromClass([PGMePromoteNoticeVC class])];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.textColor = ZDBlackColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:11];
        cell.detailTextLabel.textColor = ZDHeaderTitleColor;
    }
    PGMePromoteNoticeModel *model = self.viewModel.dataArray[indexPath.row];
    cell.textLabel.text = model.Title;
    cell.detailTextLabel.text = model.AddTime;
    return cell;
}
#pragma mark --- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PGMePromoteNoticeModel *model = self.viewModel.dataArray[indexPath.row];
    PGMeDetailNoticeVC *notice = [[PGMeDetailNoticeVC alloc] init];
    notice.detail = model.Detail;
    notice.detailTitle = model.Title;
    notice.time = model.AddTime;
    [self.navigationController pushViewController:notice animated:YES];
}
@end
