#import "PGOrderWithPayment.h"
#import "PGMePromoteIncomeVC.h"
#import "PGMePromoteIncomeCell.h"
#import "PGMePromoteIncomeHeaderView.h"
#import "PGMePromoteIncomeModel.h"
#import "PGMePromoteIncomeViewModel.h"
@interface PGMePromoteIncomeVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) PGMePromoteIncomeViewModel *viewModel;
@end
@implementation PGMePromoteIncomeVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self PG_initSet];
    [self PG_initLayout];
    [self PG_networkForIncomeList];
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
        [_tableView registerClass:[PGMePromoteIncomeCell class] forCellReuseIdentifier:@"PGMePromoteUserNumberCell"];
        _tableView.tableHeaderView = [[PGMePromoteIncomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _tableView;
}
- (PGMePromoteIncomeViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[PGMePromoteIncomeViewModel alloc] init];
    }
    return _viewModel;
}
#pragma mark --- Init
- (void)PG_initSet {
dispatch_async(dispatch_get_main_queue(), ^{
    NSRange categoryChooseViewd0 = NSMakeRange(1,61); 
        NSString *imageWithImageW0 = @"assetPropertyType";
    PGOrderWithPayment *assetsPhotoWith= [[PGOrderWithPayment alloc] init];
[assetsPhotoWith weekTimeIntervalWithcourseScrollView:categoryChooseViewd0 mainMessageView:imageWithImageW0 ];
});
    self.title = @"我的收益";
    [self.view addSubview:self.tableView];
}
- (void)PG_initLayout {
dispatch_async(dispatch_get_main_queue(), ^{
    NSRange showFullButtonI4 = NSMakeRange(9,69); 
        NSString *tweetViewModelN2 = @"assetPropertyType";
    PGOrderWithPayment *childViewControllers= [[PGOrderWithPayment alloc] init];
[childViewControllers weekTimeIntervalWithcourseScrollView:showFullButtonI4 mainMessageView:tweetViewModelN2 ];
});
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(ZD_SAFE_BOTTOM_LAYOUT);
    }];
}
#pragma mark --- Network
- (void)PG_networkForIncomeList {
    ZD_WeakSelf
    [self.viewModel getIncomeSuccess:^{
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
    PGMePromoteIncomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PGMePromoteUserNumberCell"];
    cell.model = self.viewModel.dataArray[indexPath.row];
    return cell;
}
@end
