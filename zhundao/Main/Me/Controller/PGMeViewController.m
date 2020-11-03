#import "PGCrashReportEnabled.h"
#import "PGMeViewController.h"
#import "PGMeSettingTableViewController.h"
#import "AppDelegate.h"
#import "PGMeHeaderCell.h"
#import "PGMeNormalCell.h"
#import "PGMeViewModel.h"
#import "PGLoginMainVC.h"
#import "PGMeMyWalletViewController.h"
#import "PGMeContactViewController.h"
#import "UIImageView+LBBlurredImage.h"
#import "PGSignInUpDataVC.h"
#import "PGMeNoticeVC.h"
#import "PGMeNoticeViewModel.h"
#import "Time.h"
#import "PGMePersonInfoVC.h"
#import "PGMeMyMessageVC.h"
#import "PGMePromoteMainVC.h"
#import "PGMeSettingVC.h"
#import "PGMeMessageVC.h"
@interface PGMeViewController ()<UITableViewDataSource, UITableViewDelegate, PGMeHeaderCellDelegate> {
    NSDictionary *userdic;
}
@property (nonatomic, strong) NSMutableArray<NSMutableArray <PGMeModel *> *> *dataSource;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) PGMeNoticeViewModel *noticeVM;
@property (nonatomic, strong) PGMeViewModel *viewModel;
@end
@implementation PGMeViewController
#pragma mark ------生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self PG_initSet];
    [self PG_initLayout];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self PG_getuser];
    if (ZD_UserM.isAdmin) {
        [self PG_networkForPromote];
        [self PG_isShowRed];
    }
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
#pragma mark --- Lazyload
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.separatorColor = ZDLineColor;
        _tableView.delegate = self;
        [_tableView registerClass:[PGMeHeaderCell class] forCellReuseIdentifier:@"PGMeHeaderCell"];
        [_tableView registerClass:[PGMeNormalCell class] forCellReuseIdentifier:@"PGMeNormalCell"];
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f,0.0f, kScreenWidth,15.0f)];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = ZDBackgroundColor;
    }
    return _tableView;
}
- (PGMeNoticeViewModel *)noticeVM{
    if (!_noticeVM) {
        _noticeVM = [[PGMeNoticeViewModel alloc]init];
    }
    return _noticeVM;
}
- (PGMeViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [PGMeViewModel new];
    }
    return _viewModel;
}
#pragma mark --- Init
- (void)PG_initSet {
    if (ZD_UserM.isAdmin) {
        _dataSource = @[@[[PGMeModel headerModel]],
        @[[PGMeModel PGMeNoticeModel]],
        @[[PGMeModel walletModel], [PGMeModel messageModel], [PGMeModel PGMeContactModel], [PGMeModel questionModel]],
        @[[PGMeModel settingModel]]].mutableCopy;
    } else {
        _dataSource = @[@[[PGMeModel headerModel]],
        @[[PGMeModel personDataMessageModel]],
        @[[PGMeModel settingModel]]].mutableCopy;
    }
    [self.view addSubview:self.tableView];
}
- (void)PG_initLayout {
dispatch_async(dispatch_get_main_queue(), ^{
    NSArray *titleLabelSelectededa4= [NSArray array];
        CGRect locationViewModelo7 = CGRectMake(72,24,122,183); 
    PGCrashReportEnabled *authorizationStatusAuthorized= [[PGCrashReportEnabled alloc] init];
[authorizationStatusAuthorized integralStoreViewWithverticalScrollIndicator:titleLabelSelectededa4 imageWithImage:locationViewModelo7 ];
});
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}
#pragma mark --- Network
- (void)PG_getuser {
    NSString *userstr = [NSString stringWithFormat:@"%@api/v2/user/getUserInfo?token=%@",zhundaoApi,[[PGSignManager shareManager] getToken]];
    [ZD_NetWorkM getDataWithMethod:userstr parameters:nil succ:^(NSDictionary *obj) {
        if ([obj[@"errcode"] integerValue] == 0) {
            [PGUserManager.shareManager initWithDic:[obj[@"data"] deleteNullObj]];
            userdic = [obj[@"data"] copy];
            [[NSUserDefaults standardUserDefaults]setObject:@(ZD_UserM.gradeId) forKey:@"GradeId"];
            [[NSUserDefaults  standardUserDefaults]setObject:ZD_UserM.phone forKey:@"mobile"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self.tableView reloadData];
        }
    } fail:^(NSError *error) {
        [[PGSignManager shareManager] showNotHaveNet:self.view];
    }];
}
- (void)PG_networkForPromote {
    ZD_WeakSelf
    [self.viewModel getPromoteSuccess:^{
        [weakSelf.tableView reloadData];
    } failure:^{
    }];
}
#pragma mark --- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource[section].count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        PGMeHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PGMeHeaderCell"];
        cell.model = self.dataSource[indexPath.section][indexPath.row];
        cell.meHeaderCellDelegate = self;
        return cell;
    } else {
        PGMeNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PGMeNormalCell"];
        cell.model = self.dataSource[indexPath.section][indexPath.row];
        return cell;
    }
}
#pragma mark --- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PGMeModel *model = self.dataSource[indexPath.section][indexPath.row];
    switch (model.type) {
        case PGMeTypeHeader: {
            [self PG_pushChangeInfo];
            break;
        }
        case PGMeTypeNotice: {
            [self PG_pushNotice];
            break;
        }
        case PGMeTypeWallet: {
            [self PG_pushWallet];
            break;
        }
        case PGMeTypeMessage: {
            [self PG_pushMessage];
            break;
        }
        case PGMeTypeContact: {
            [self pushList];
            break;
        }
        case PGMeTypeQuestion: {
            [self showsuggest];
            break;
        }
        case PGMeTypeHonor: {
            [self PG_showHonor];
            break;
        }
        case PGMeTypeZDBi: {
            [self PG_showZhundaoBi];
            break;
        }
        case PGMeTypeVoucher: {
            [self PG_showVoucher];
            break;
        }
        case PGMeTypePromote: {
            [self PG_showPromote];
            break;
        }
        case PGMeTypeSetting: {
            [self PG_pushSetting];
            break;
        }
        case PGMeTypePersonDataMessage: {
            [self PG_pushDataPersonMessage];
        }
        default:
            break;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    PGMeModel *model = self.dataSource[indexPath.section][indexPath.row];
    if (model.type == PGMeTypeHeader) {
        return 86;
    } else {
        return 44;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}
#pragma mark --- PGMeHeaderCellDelegate
- (void)headerCell:(PGMeHeaderCell *)headerCell didTapVIPLabel:(UILabel *)label {
    PGSignInUpDataVC *updata = [[PGSignInUpDataVC alloc]init];
    updata.urlString = [NSString stringWithFormat:@"%@Activity/Upgraded?accesskey=%@",zhundaoH5Api,[[PGSignManager shareManager] getaccseekey]];
    [self.navigationController pushViewController:updata animated:YES];
}
#pragma mark --- action
- (void)PG_pushMessage{
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"GradeId"] integerValue]>1) {
        PGMeMyMessageVC *message = [[PGMeMyMessageVC alloc]init];
        message.userDic = userdic;
        [self setHidesBottomBarWhenPushed: YES];
        [self.navigationController pushViewController:message animated:YES];
        [self setHidesBottomBarWhenPushed:NO];
    }
    else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"该功能仅限V2以上会员使用" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
- (void)PG_pushChangeInfo{
    PGBaseWebViewVC *web = [[PGBaseWebViewVC alloc] init];
    web.webTitle = @"个人信息";
    web.isClose = YES;
    web.urlString = [NSString stringWithFormat:@"%@/Activity/UserEdit?token=%@",zhundaoH5Api,[[PGSignManager shareManager] getToken]];
    [self.navigationController pushViewController:web animated:YES];
}
- (void)pushList
{
    PGMeContactViewController *contact = [[PGMeContactViewController alloc]init];
    [self.navigationController pushViewController:contact animated:YES];
}
- (void)showsuggest
{
    PGBaseWebViewVC *web = [[PGBaseWebViewVC alloc] init];
    web.webTitle = @"我的工单";
    web.isClose = YES;
    web.urlString = [NSString stringWithFormat:@"https://m.zhundao.net/Extra/TicketMain?token=%@",[[PGSignManager shareManager] getToken]];
    [self.navigationController pushViewController:web animated:YES];
}
- (void)PG_showVoucher {
    PGBaseWebViewVC *web = [[PGBaseWebViewVC alloc] init];
    web.webTitle = @"我的代金券";
    web.isClose = YES;
    web.urlString = [NSString stringWithFormat:@"https://app.zhundao.net/coupon/index.html#/mycoupon?token=%@",[[PGSignManager shareManager] getToken]];
    [self.navigationController pushViewController:web animated:YES];
}
- (void)PG_showHonor {
    PGBaseWebViewVC *web = [[PGBaseWebViewVC alloc] init];
    web.webTitle = @"我的勋章";
    web.isClose = YES;
    web.urlString = [NSString stringWithFormat:@"https://app.zhundao.net/account/index.html#!/nameplate?token=%@",[[PGSignManager shareManager] getToken]];
    [self.navigationController pushViewController:web animated:YES];
}
- (void)PG_showZhundaoBi {
dispatch_async(dispatch_get_main_queue(), ^{
    NSArray *backButtonClicko6= [NSArray array];
        CGRect collectionOriginalModelI7 = CGRectMake(199,209,181,80); 
    PGCrashReportEnabled *photosBytesWith= [[PGCrashReportEnabled alloc] init];
[photosBytesWith integralStoreViewWithverticalScrollIndicator:backButtonClicko6 imageWithImage:collectionOriginalModelI7 ];
});
    PGBaseWebViewVC *web = [[PGBaseWebViewVC alloc] init];
    web.webTitle = @"我的准币";
    web.isClose = YES;
    web.urlString = [NSString stringWithFormat:@"https://app.zhundao.net/shop/index.html#!/ZDWallet?token=%@",[[PGSignManager shareManager] getToken]];
    [self.navigationController pushViewController:web animated:YES];
}
- (void)PG_pushWallet {
dispatch_async(dispatch_get_main_queue(), ^{
    NSArray *locationStyleReusek3= [NSArray array];
        CGRect videoViewModelV9 = CGRectMake(82,220,136,171); 
    PGCrashReportEnabled *delegateMethodWith= [[PGCrashReportEnabled alloc] init];
[delegateMethodWith integralStoreViewWithverticalScrollIndicator:locationStyleReusek3 imageWithImage:videoViewModelV9 ];
});
    PGBaseWebViewVC *web = [[PGBaseWebViewVC alloc] init];
    web.webTitle = @"我的钱包";
    web.isClose = YES;
    web.urlString = [NSString stringWithFormat:@"https://m.zhundao.net/Activity/MyWallet?token=%@",[[PGSignManager shareManager] getToken]];
    [self.navigationController pushViewController:web animated:YES];
}
- (void)PG_pushNotice {
    PGMeNoticeVC *notice = [[PGMeNoticeVC alloc]init];
    [self.navigationController pushViewController:notice animated:YES];
}
- (void)PG_pushSetting {
    PGMeSettingVC *setting = [[PGMeSettingVC alloc] init];
    [self.navigationController pushViewController:setting animated:YES];
}
- (void)PG_showPromote {
    PGMePromoteMainVC *main = [[PGMePromoteMainVC alloc] init];
    [self.navigationController pushViewController:main animated:YES];
}
- (void)PG_pushDataPersonMessage {
    PGMeMessageVC *message = [[PGMeMessageVC alloc] init];
    [self.navigationController pushViewController:message animated:YES];
}
#pragma mark 通知公告小红点
- (void)PG_isShowRed {
    NSArray *array = [[NSUserDefaults standardUserDefaults]objectForKey:@"noticeTime"];
    if (array) {
       return  [self PG_getNotice:array];
    }else{
        [self PG_showRod:YES];
    }
}
- (void)PG_showRod:(BOOL)isShow {
    self.dataSource[1][0].showRod = isShow;
    [self.tableView reloadData];
}
- (void)PG_getNotice:(NSArray *)localArray {
    __block BOOL exist = NO;
    [self.noticeVM netWorkWithPage:0 Block:^(NSArray *array) {
        for (NSDictionary *dic in array) {
            NSString *time = dic[@"AddTime"] ;
            Time *nowTime1 = [Time bringWithTime:time];
            NSString *lastStr =  [[NSUserDefaults standardUserDefaults]objectForKey:@"noticeTime"];
            NSDateFormatter *dataFormatter =   [[NSDateFormatter alloc]init];
            [dataFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            NSTimeInterval lastTime = [[dataFormatter dateFromString:lastStr] timeIntervalSince1970];
            NSTimeInterval nowTime = [[dataFormatter dateFromString:nowTime1.timeStr] timeIntervalSince1970];
            if (nowTime >lastTime) {
                exist = YES;
            }
            break;
        }
    }];
    [self PG_showRod:exist];
}
@end