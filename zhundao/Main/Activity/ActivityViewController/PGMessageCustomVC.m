#import "PGInterfaceOrientationLandscape.h"
#import "PGMessageCustomVC.h"
#import "PGActivityMessageContentCell.h"
#import "PGActivityMessageContentViewModel.h"
#import "PGActivityMessageContentModel.h"
@interface PGMessageCustomVC ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)PGActivityMessageContentViewModel *viewModel;
@end
static NSString *cellID = @"PGActivityMessageContentCell";
@implementation PGMessageCustomVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self PG_initSet];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
}
- (void)dealloc{
    NSLog(@"%@", [NSString stringWithFormat:@"%@dealloc",self.title]);
}
#pragma mark --- init
- (void)PG_initSet {
     _viewModel = [[PGActivityMessageContentViewModel alloc]init];
    [self.view addSubview:self.tableView];
}
#pragma mark --- 网络请求
- (void)PG_getCustomContent{
    __weak typeof(self) weakSelf = self;
    [self.viewModel getCustomWithPageIndex:0 EsID:_es_id success:^(NSDictionary *obj) {
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSString *error) {
        [weakSelf.tableView.mj_header endRefreshing];
        [[PGSignManager shareManager]showNotHaveNet:weakSelf.view];
    }];
}
#pragma mark --- lazyload
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64 - 50)];
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.backgroundColor = ZDBackgroundColor;
        [_tableView registerClass:[PGActivityMessageContentCell class] forCellReuseIdentifier:@"PGActivityMessageContentCell"];
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.1)];
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.layer.borderWidth = 1;
        _tableView.layer.borderColor = ZDLineColor.CGColor;
        _tableView.mj_header = [PGRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(PG_getCustomContent)];
    }
    return _tableView;
}
#pragma mark -------UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.customArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PGActivityMessageContentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.model = self.viewModel.customArray[indexPath.row];
    return cell;
}
#pragma mark -------UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.viewModel.customHeightArray[indexPath.row] integerValue];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
dispatch_async(dispatch_get_main_queue(), ^{
    UITableViewStyle backButtonClicko2 = UITableViewStylePlain; 
        UIButtonType numberBadgeWithV5 = UIButtonTypeContactAdd;
    PGInterfaceOrientationLandscape *calendarUnitYear= [[PGInterfaceOrientationLandscape alloc] init];
[calendarUnitYear destinationFilePathWithcollectionOriginalTable:backButtonClicko2 effectThumbImage:numberBadgeWithV5 ];
});
    PGActivityMessageContentModel *model = self.viewModel.customArray[indexPath.row];
    if (model.messageStatusType != PGMessageStatusTypeSuccess) {
        return;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:ZDNotification_Message_Select object:model.es_content];
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) weakSelf = self;
    PGActivityMessageContentModel *model = self.viewModel.customArray[indexPath.row];
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDefault) title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [_viewModel deleteContent:model.ID esid:_es_id successBlock:^(id responseObject) {
            [weakSelf PG_getCustomContent];
        } error:^(NSError *error) {
            [[PGSignManager shareManager] showNotHaveNet:weakSelf.view];
        }];
    }];
    deleteAction.backgroundColor = [UIColor redColor];
    return @[deleteAction];
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        cell.layoutMargins = UIEdgeInsetsZero;
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        cell.separatorInset = UIEdgeInsetsZero;
    }
}
@end