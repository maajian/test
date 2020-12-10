
#import "ZDMessageMainVC.h"
#import "ZDMessageMainDetailVC.h"
#import "ZDMessageMainCell.h"
#import "ZDMessageMainViewModel.h"
@interface ZDMessageMainVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) ZDMessageMainViewModel *viewModel;
@property (nonatomic, assign) NSInteger page;
@end
@implementation ZDMessageMainVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSet];
    [self initLayout];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView.mj_header beginRefreshing];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)loadNewData {
    _page = 1;
    [self networkForGetMeMessageList];
}
- (void)loadMoreData {
    _page += 1;
    [self networkForGetMeMessageList];
}
#pragma mark --- Init
- (void)initSet {
    ZD_WeakSelf
    weakSelf.page = 1;
    self.title = @"准到";
    _viewModel = [[ZDMessageMainViewModel alloc] init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ZD_ScreenWidth, 0.1)];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.sectionHeaderHeight = CGFLOAT_MIN;
    self.tableView.sectionFooterHeight = CGFLOAT_MIN;
    [self.tableView registerClass:[ZDMessageMainCell class] forCellReuseIdentifier:NSStringFromClass([ZDMessageMainCell class])];
    self.tableView.mj_header = [ZDRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer = [ZDRefreshNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.errorViewTapedBlock = ^{
        weakSelf.isLoading = YES;
        weakSelf.page = 1;
        [weakSelf loadNewData];
        NSLog(@"点击error");
    };
    self.emptyViewTapedBlock = ^{
        weakSelf.isLoading = YES;
        weakSelf.page = 1;
        [weakSelf loadNewData];
        NSLog(@"点击了空");
    };
    
    self.tableView.rowHeight = 71;
    [self.view addSubview:self.tableView];
}
- (void)initLayout {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}
#pragma mark --- Network
- (void)networkForGetMeMessageList {
    ZD_WeakSelf
    [self.viewModel getMeMessageListWithPage:_page Success:^{
        weakSelf.isLoading = NO;
        weakSelf.isEmpty = weakSelf.viewModel.isEmpty;
        weakSelf.isError = weakSelf.viewModel.isError;
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
    } failure:^(NSString *error) {
        weakSelf.isLoading = NO;
        weakSelf.isEmpty = weakSelf.viewModel.isEmpty;
        weakSelf.isError = weakSelf.viewModel.isError;
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
       ZD_HUD_SHOW_ERROR_STATUS(error)

    }];
}
#pragma mark --- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZDMessageMainCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZDMessageMainCell class])];
    cell.model = self.viewModel.dataSource[indexPath.row];
    return cell;
}
#pragma mark --- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZDMessageMainDetailVC *detail = [[ZDMessageMainDetailVC alloc] init];
    detail.model = self.viewModel.dataSource[indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
}
@end