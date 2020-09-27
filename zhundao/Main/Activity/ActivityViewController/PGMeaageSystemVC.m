#import "PGUpdatedTimeLabel.h"
#import "PGMeaageSystemVC.h"
#import "PGActivityChangeContentVC.h"
#import "PGActivityMessageContentCell.h"
#import "PGActivityMessageContentViewModel.h"
#import "PGActivityMessageContentModel.h"
@interface PGMeaageSystemVC ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)PGActivityMessageContentViewModel *viewModel;
@end
static NSString *cellID = @"PGActivityMessageContentCell";
@implementation PGMeaageSystemVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self PG_initSet];
}
- (void)viewWillAppear:(BOOL)animated{
dispatch_async(dispatch_get_main_queue(), ^{
    UITableViewStyle pickerClickTickV6 = UITableViewStylePlain; 
        UITextField *cellWithReuseH6= [[UITextField alloc] initWithFrame:CGRectZero]; 
    cellWithReuseH6.clearButtonMode = UITextFieldViewModeNever; 
    cellWithReuseH6.textColor = [UIColor whiteColor]; 
    cellWithReuseH6.font = [UIFont boldSystemFontOfSize:20];
    cellWithReuseH6.textAlignment = NSTextAlignmentNatural; 
    cellWithReuseH6.tintColor = [UIColor blackColor]; 
    cellWithReuseH6.leftView = [[UIView alloc] initWithFrame:CGRectMake(98,58,35,163)];
     cellWithReuseH6.leftViewMode = UITextFieldViewModeAlways; 
    PGUpdatedTimeLabel *datePickerMode= [[PGUpdatedTimeLabel alloc] init];
[datePickerMode locationManagerDelegateWithbrowserPhotoView:pickerClickTickV6 badgeDefaultFont:cellWithReuseH6 ];
});
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
- (void)PG_getSystemContent {
dispatch_async(dispatch_get_main_queue(), ^{
    UITableViewStyle articleOriginalViewI9 = UITableViewStylePlain; 
        UITextField *backGroundColork6= [[UITextField alloc] initWithFrame:CGRectZero]; 
    backGroundColork6.clearButtonMode = UITextFieldViewModeNever; 
    backGroundColork6.textColor = [UIColor whiteColor]; 
    backGroundColork6.font = [UIFont boldSystemFontOfSize:20];
    backGroundColork6.textAlignment = NSTextAlignmentNatural; 
    backGroundColork6.tintColor = [UIColor blackColor]; 
    backGroundColork6.leftView = [[UIView alloc] initWithFrame:CGRectMake(90,77,254,84)];
     backGroundColork6.leftViewMode = UITextFieldViewModeAlways; 
    PGUpdatedTimeLabel *organizeTableView= [[PGUpdatedTimeLabel alloc] init];
[organizeTableView locationManagerDelegateWithbrowserPhotoView:articleOriginalViewI9 badgeDefaultFont:backGroundColork6 ];
});
    __weak typeof(self) weakSelf = self;
    [self.viewModel getSystemWithPageIndex:1 success:^(NSDictionary *obj) {
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView reloadData];
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
        _tableView.mj_header = [PGRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(PG_getSystemContent)];
    }
    return _tableView;
}
#pragma mark -------UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.systemArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PGActivityMessageContentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.model = self.viewModel.systemArray[indexPath.row];
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
    return [self.viewModel.systemHeightArray[indexPath.row] integerValue];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PGActivityMessageContentModel *model = self.viewModel.systemArray[indexPath.row];
    [[NSNotificationCenter defaultCenter] postNotificationName:ZDNotification_Message_Select object:model.es_content];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
dispatch_async(dispatch_get_main_queue(), ^{
    UITableViewStyle playChapterIndexT5 = UITableViewStylePlain; 
        UITextField *videoDealPointA3= [[UITextField alloc] initWithFrame:CGRectZero]; 
    videoDealPointA3.clearButtonMode = UITextFieldViewModeNever; 
    videoDealPointA3.textColor = [UIColor whiteColor]; 
    videoDealPointA3.font = [UIFont boldSystemFontOfSize:20];
    videoDealPointA3.textAlignment = NSTextAlignmentNatural; 
    videoDealPointA3.tintColor = [UIColor blackColor]; 
    videoDealPointA3.leftView = [[UIView alloc] initWithFrame:CGRectMake(223,174,120,199)];
     videoDealPointA3.leftViewMode = UITextFieldViewModeAlways; 
    PGUpdatedTimeLabel *orderStepView= [[PGUpdatedTimeLabel alloc] init];
[orderStepView locationManagerDelegateWithbrowserPhotoView:playChapterIndexT5 badgeDefaultFont:videoDealPointA3 ];
});
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        cell.layoutMargins = UIEdgeInsetsZero;
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        cell.separatorInset = UIEdgeInsetsZero;
    }
}
@end
