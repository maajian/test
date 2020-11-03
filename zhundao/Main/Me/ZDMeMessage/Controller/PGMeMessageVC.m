#import "PGWithLocaleIdentifier.h"
#import "PGMeMessageVC.h"
#import "PGMeMessageDetailVC.h"
#import "PGMeMessageCell.h"
#import "PGMeMessageViewModel.h"
@interface PGMeMessageVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) PGMeMessageViewModel *viewModel;
@property (nonatomic, assign) NSInteger page;
@end
@implementation PGMeMessageVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self PG_initSet];
    [self PG_initLayout];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView.mj_header beginRefreshing];
}
- (void)viewWillAppear:(BOOL)animated {
dispatch_async(dispatch_get_main_queue(), ^{
    CGPoint assetResourceLoaderr1 = CGPointZero;
        CGRect nameRightLabelB6 = CGRectZero;
    PGWithLocaleIdentifier *downLoadData= [[PGWithLocaleIdentifier alloc] init];
[downLoadData itemPhotoClickWithtrainsWithOffset:assetResourceLoaderr1 updateStatuMandatory:nameRightLabelB6 ];
});
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
        [_tableView registerClass:[PGMeMessageCell class] forCellReuseIdentifier:NSStringFromClass([PGMeMessageCell class])];
        _tableView.sectionHeaderHeight = 0.1;
        _tableView.sectionFooterHeight = 10;
        _tableView.mj_header = [PGRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(PG_loadNewData)];
        _tableView.mj_footer = [PGRefreshNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(PG_loadMoreData)];
        _tableView.rowHeight = 71;
    }
    return _tableView;
}
- (void)PG_loadNewData {
dispatch_async(dispatch_get_main_queue(), ^{
    CGPoint recordMovieBottome3 = CGPointZero;
        CGRect imageNamesGroupV0 = CGRectMake(198,61,103,2); 
    PGWithLocaleIdentifier *mobileCoreServices= [[PGWithLocaleIdentifier alloc] init];
[mobileCoreServices itemPhotoClickWithtrainsWithOffset:recordMovieBottome3 updateStatuMandatory:imageNamesGroupV0 ];
});
    _page = 1;
    [self PG_networkForGetMeMessageList];
}
- (void)PG_loadMoreData {
dispatch_async(dispatch_get_main_queue(), ^{
    CGPoint videoDealPointg4 = CGPointMake(2,193); 
        CGRect naviTitleAppearanceM6 = CGRectMake(124,191,177,203); 
    PGWithLocaleIdentifier *blockWithResult= [[PGWithLocaleIdentifier alloc] init];
[blockWithResult itemPhotoClickWithtrainsWithOffset:videoDealPointg4 updateStatuMandatory:naviTitleAppearanceM6 ];
});
    _page += 1;
    [self PG_networkForGetMeMessageList];
}
#pragma mark --- Init
- (void)PG_initSet {
    self.title = @"消息";
    _viewModel = [[PGMeMessageViewModel alloc] init];
    [self.view addSubview:self.tableView];
}
- (void)PG_initLayout {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}
#pragma mark --- Network
- (void)PG_networkForGetMeMessageList {
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
    PGMeMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PGMeMessageCell class])];
    cell.model = self.viewModel.dataSource[indexPath.row];
    return cell;
}
#pragma mark --- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PGMeMessageDetailVC *detail = [[PGMeMessageDetailVC alloc] init];
    detail.model = self.viewModel.dataSource[indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
}
@end