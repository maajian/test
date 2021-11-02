//
//  MeViewController.m
//  zhundao
//
//  Created by zhundao on 2016/12/2.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import "MeViewController.h"

#import "SettingTableViewController.h"

#import "AppDelegate.h"

#import "ZDMeHeaderCell.h"
#import "ZDMeNormalCell.h"
#import "ZDMeAdsPopView.h"

#import "ZDMeViewModel.h"

#import "LoginViewController.h"
#import "MyWalletViewController.h"
#import "ContactViewController.h"
#import "UIImageView+LBBlurredImage.h"
#import "UpDataViewController.h"
#import "NoticeViewController.h"
#import "NoticeViewModel.h"
#import "Time.h"
#import "PersonInfoViewController.h"
#import "MyMessageViewController.h"
#import "ZDMePromoteMainVC.h"

#import "ZDMainSupplierTabbarVC.h"

@interface MeViewController ()<UITableViewDataSource, UITableViewDelegate, ZDMeHeaderCellDelegate> {
    NSDictionary *userdic;
}
@property (nonatomic, strong) NSMutableArray<NSMutableArray <ZDMeModel *> *> *dataSource;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NoticeViewModel *noticeVM;
@property (nonatomic, strong) ZDMeViewModel *viewModel;

@end

@implementation MeViewController
#pragma mark ------生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSet];
    [self initLayout];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem identifierButtonWithText:@"当前身份:主办方" Target:self action:@selector(changeIdentifier)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getuser];
    [self networkForPromote];
    [self isShowRed];
    [self checkVersin:^(BOOL obj) {
        ZD_UserM.iosHiddenFlag = obj;
    }];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    ZD_UserM.identifierType = ZDIdentifierTypeSupplier;
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
        [_tableView registerClass:[ZDMeHeaderCell class] forCellReuseIdentifier:@"ZDMeHeaderCell"];
        [_tableView registerClass:[ZDMeNormalCell class] forCellReuseIdentifier:@"ZDMeNormalCell"];
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f,0.0f, kScreenWidth,15.0f)];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = ZDBackgroundColor;
    }
    return _tableView;
}
- (NoticeViewModel *)noticeVM{
    if (!_noticeVM) {
        _noticeVM = [[NoticeViewModel alloc]init];
    }
    return _noticeVM;
}
- (ZDMeViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [ZDMeViewModel new];
    }
    return _viewModel;
}

#pragma mark --- Init
- (void)initSet {
    _dataSource = @[@[[ZDMeModel headerModel]],
                    @[[ZDMeModel noticeModel]],
                    @[[ZDMeModel walletModel], [ZDMeModel messageModel], [ZDMeModel contactModel], [ZDMeModel questionModel]],
                    @[[ZDMeModel honorModel], [ZDMeModel zhundaobiModel], [ZDMeModel voucherModel]].mutableCopy,
                    @[[ZDMeModel settingModel]]].mutableCopy;
    [self.view addSubview:self.tableView];
    [self networkGetNotify];
}
- (void)initLayout {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

#pragma mark --- Network
- (void)getuser {
    NSString *userstr = [NSString stringWithFormat:@"%@api/v2/user/getUserInfo?token=%@",zhundaoApi,[[SignManager shareManager] getToken]];
    [ZD_NetWorkM getDataWithMethod:userstr parameters:nil succ:^(NSDictionary *obj) {
        if ([obj[@"errcode"] integerValue] == 0) {
            [ZDUserManager.shareManager initWithDic:[obj[@"data"] deleteNullObj]];
            userdic = [obj[@"data"] copy];
            [[NSUserDefaults standardUserDefaults]setObject:@(ZD_UserM.gradeId) forKey:@"GradeId"];
            [[NSUserDefaults  standardUserDefaults]setObject:ZD_UserM.phone forKey:@"mobile"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self.tableView reloadData];
        }
    } fail:^(NSError *error) {
        [[SignManager shareManager] showNotHaveNet:self.view];
    }];
}
- (void)networkForPromote {
    ZD_WeakSelf
    [self.viewModel getPromoteSuccess:^{
        __block BOOL exist = NO;
        [weakSelf.dataSource enumerateObjectsUsingBlock:^(NSMutableArray<ZDMeModel *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj enumerateObjectsUsingBlock:^(ZDMeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (obj.type == ZDMeTypeSupplier || obj.type == ZDMeTypePromote) {
                    exist = YES;
                }
            }];
        }];
        if (!exist) {
            if (weakSelf.viewModel.allowPromote) {
                [self.dataSource[3] addObject:[ZDMeModel promoteModel]];
            }
//            if (weakSelf.viewModel.allowSupplier) {
//                [self.dataSource[3] addObject:[ZDMeModel supplierModel]];
//            }
        }
        [weakSelf.tableView reloadData];
    } failure:^{
        
    }];
}
- (void)checkVersin:(ZDBlock_BOOL)block {
    ZD_HUD_SHOW_WAITING
    NSString *url = [NSString stringWithFormat:@"%@api/v2/extra/getZdConfig?name=iOS-App", zhundaoApi];
    [ZD_NetWorkM getDataWithMethod:url parameters:nil succ:^(NSDictionary *obj) {
        ZD_HUD_DISMISS
        if ([obj[@"res"] boolValue]) {
            NSString *data = obj[@"data"];
            NSDictionary *dic = data.zd_jsonDictionary;
            NSString *version = ZD_SafeStringValue(dic[@"version"]);
            BOOL over = [version compareVesionWithServerVersion];
            block(!over);
        } else {
            block(true);
        }
    } fail:^(NSError *error) {
        block(true);
        ZD_HUD_DISMISS
    }];
}
// 获取弹窗推送
- (void)networkGetNotify {
    ZD_WeakSelf
    [self.viewModel networkGetNotifySuccess:^(ZDMeADModel * _Nullable model) {
        [SDWebImageManager.sharedManager downloadImageWithURL:[NSURL URLWithString:model.PicM] options:SDWebImageCacheMemoryOnly progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            [ZDMeAdsPopView showWithImage:image clickBlock:^{
                ZDWebViewController *web = [[ZDWebViewController alloc] init];
                web.urlString = model.UrlM;
                [weakSelf.navigationController pushViewController:web animated:YES];
                [weakSelf.viewModel networForAdsPopRespond:NO AdsPopID:model.ID];
            } cancelBlock:^{
                [weakSelf.viewModel networForAdsPopRespond:NO AdsPopID:model.ID];
            }];
        }];
    } failure:nil];
}
- (void)checkRegisterSupplier {
    NSString *url = [NSString stringWithFormat:@"https://settlement.zhundaoyun.com/api/check_register?token=%@",[[SignManager shareManager] getToken]];
    [ZD_NetWorkM getDataWithMethod:url parameters:nil succ:^(NSDictionary *obj) {
        if ([obj[@"code"] integerValue] == 0) {
            ZD_UserM.identifierType = ZDIdentifierTypeSupplier;
            ZD_UserM.supplier_access_token = obj[@"data"][@"supplier_access_token"];
            ZDMainSupplierTabbarVC *vc = [[ZDMainSupplierTabbarVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            ZDWebViewController *web = [[ZDWebViewController alloc] init];
            web.isClose = YES;
            web.urlString = [NSString stringWithFormat:@"https://app.zhundao.net/settlement/supplier.html?token=%@#/register/",[[SignManager shareManager] getToken]];
            [self setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:web animated:YES];
            [self setHidesBottomBarWhenPushed:NO];
        }
    } fail:^(NSError *error) {
        ZD_HUD_SHOW_ERROR(error)
    }];
}

// 检查是否有会务公司
- (void)checkRegisterConference {
    NSString *url = [NSString stringWithFormat:@"https://corp.zhundaoyun.com/api/get_bind_corp_list?token=%@",[[SignManager shareManager] getToken]];
    NSMutableArray *conferenceArray = [NSMutableArray array];
    [ZD_NetWorkM getDataWithMethod:url parameters:nil succ:^(NSDictionary *obj) {
        if ([obj[@"code"] integerValue] == 0) {
            for (NSDictionary *dic in obj[@"data"]) {
                ZDSupplierMeModel *model = [[ZDSupplierMeModel alloc] initWithConferenceDic:dic];
                [conferenceArray addObject:model];
            }
            if (conferenceArray.count) {
                [self showConferenceList:conferenceArray];
            }
        } else {
            ZD_HUD_SHOW_ERROR_STATUS(obj[@"msg"])
        }
    } fail:^(NSError *error) {
        ZD_HUD_SHOW_ERROR(error)
    }];
}

#pragma mark --- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource[section].count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ZDMeHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZDMeHeaderCell"];
        cell.model = self.dataSource[indexPath.section][indexPath.row];
        cell.meHeaderCellDelegate = self;
        return cell;
    } else {
        ZDMeNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZDMeNormalCell"];
        cell.model = self.dataSource[indexPath.section][indexPath.row];
        return cell;
    }
}

#pragma mark --- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZDMeModel *model = self.dataSource[indexPath.section][indexPath.row];
    switch (model.type) {
        case ZDMeTypeHeader: {
            [self pushChangeInfo];
            break;
        }
        case ZDMeTypeNotice: {
            [self pushNotice];
            break;
        }
        case ZDMeTypeWallet: {
            [self pushWallet];
            break;
        }
        case ZDMeTypeMessage: {
            [self pushMessage];
            break;
        }
        case ZDMeTypeContact: {
            [self pushList];
            break;
        }
        case ZDMeTypeQuestion: {
            [self showsuggest];
            break;
        }
        case ZDMeTypeHonor: {
            [self showHonor];
            break;
        }
        case ZDMeTypeZDBi: {
            [self showZhundaoBi];
            break;
        }
        case ZDMeTypeVoucher: {
            [self showVoucher];
            break;
        }
        case ZDMeTypePromote: {
            [self showPromote];
            break;
        }
        case ZDMeTypeSetting: {
            [self pushSetting];
            break;
        }
        case ZDMeTypeSupplier: {
            [self showSupplier];
            break;;
        }
            
        default:
            break;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZDMeModel *model = self.dataSource[indexPath.section][indexPath.row];
    if (model.type == ZDMeTypeHeader) {
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

#pragma mark --- ZDMeHeaderCellDelegate
- (void)headerCell:(ZDMeHeaderCell *)headerCell didTapVIPLabel:(UILabel *)label {
    UpDataViewController *updata = [[UpDataViewController alloc]init];
    updata.urlString = [NSString stringWithFormat:@"%@Activity/Upgraded?accesskey=%@",zhundaoH5Api,[[SignManager shareManager] getaccseekey]];
    [self.navigationController pushViewController:updata animated:YES];
}

#pragma mark --- action
- (void)pushMessage{
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"GradeId"] integerValue]>1) {
        MyMessageViewController *message = [[MyMessageViewController alloc]init];
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

- (void)pushChangeInfo{
    ZDWebViewController *web = [[ZDWebViewController alloc] init];
    web.webTitle = @"个人信息";
    web.isClose = YES;
    web.urlString = [NSString stringWithFormat:@"%@/Activity/UserEdit?token=%@",zhundaoH5Api,[[SignManager shareManager] getToken]];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:web animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}

- (void)pushList
{
    ContactViewController *contact = [[ContactViewController alloc]init];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:contact animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}
- (void)showsuggest
{
    ZDWebViewController *web = [[ZDWebViewController alloc] init];
    web.webTitle = @"我的工单";
    web.isClose = YES;
    web.urlString = [NSString stringWithFormat:@"https://m.zhundao.net/Extra/TicketMain?token=%@",[[SignManager shareManager] getToken]];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:web animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}
- (void)showVoucher {
    ZDWebViewController *web = [[ZDWebViewController alloc] init];
    web.webTitle = @"我的代金券";
    web.isClose = YES;
    web.urlString = [NSString stringWithFormat:@"https://app.zhundao.net/coupon/index.html?token=%@#/mycoupon",[[SignManager shareManager] getToken]];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:web animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}
- (void)showHonor {
    ZDWebViewController *web = [[ZDWebViewController alloc] init];
    web.webTitle = @"我的勋章";
    web.isClose = YES;
    web.urlString = [NSString stringWithFormat:@"https://app.zhundao.net/account/index.html?token=%@#!/nameplate",[[SignManager shareManager] getToken]];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:web animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}
- (void)showSupplier {
    ZDWebViewController *web = [[ZDWebViewController alloc] init];
    web.webTitle = @"准到供应商";
    web.isClose = YES;
    web.urlString = [NSString stringWithFormat:@"https://app.zhundao.net/settlement/m/supplier_list.html?token=%@",[[SignManager shareManager] getToken]];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:web animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}
- (void)showZhundaoBi {
    ZDWebViewController *web = [[ZDWebViewController alloc] init];
    web.webTitle = @"我的准币";
    web.isClose = YES;
    web.urlString = [NSString stringWithFormat:@"https://app.zhundao.net/shop/index.html?token=%@#!/ZDWallet",[[SignManager shareManager] getToken]];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:web animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}

- (void)pushWallet {
    ZDWebViewController *web = [[ZDWebViewController alloc] init];
    web.webTitle = @"我的钱包";
    web.isClose = YES;
    web.urlString = [NSString stringWithFormat:@"https://m.zhundao.net/Activity/MyWallet?token=%@",[[SignManager shareManager] getToken]];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:web animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}
/*! 通知公告 */
- (void)pushNotice {
    NoticeViewController *notice = [[NoticeViewController alloc]init];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:notice animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}
/*! 设置 */
- (void)pushSetting {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Me" bundle:[NSBundle mainBundle]];
    SettingTableViewController *vc = [sb instantiateViewControllerWithIdentifier:@"settingStoryboard"];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)showPromote {
    ZDMePromoteMainVC *main = [[ZDMePromoteMainVC alloc] init];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:main animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}
- (void)showPartner {
    ZD_UserM.identifierType = ZDIdentifierTypePartner;
    ZDMainSupplierTabbarVC *vc = [[ZDMainSupplierTabbarVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)changeIdentifier {
    [AJAlertSheet showWithArray:@[@"主办方", @"参与者", @"会务公司", @"供应商"] title:@"请选择你的身份" isDelete:NO selectBlock:^(NSInteger index) {
        if (index == 1) {
            [self showPartner];
        } else if (index == 2) {
            [self checkRegisterConference];
        } else if (index == 3) {
            [self checkRegisterSupplier];
        }
    }];
}
- (void)showConferenceList:(NSMutableArray<ZDSupplierMeModel *> *)conferenceArray {
    NSMutableArray *nameArray = [NSMutableArray array];
    [conferenceArray enumerateObjectsUsingBlock:^(ZDSupplierMeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [nameArray addObject:obj.company];
    }];
    [AJAlertSheet showWithArray:nameArray title:@"请选择会务公司" isDelete:NO selectBlock:^(NSInteger index) {
        ZD_UserM.supplierMeModel = conferenceArray[index];
        ZD_UserM.identifierType = ZDIdentifierTypeConference;
        ZDMainSupplierTabbarVC *vc = [[ZDMainSupplierTabbarVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
}

#pragma mark 通知公告小红点
/*! 是否显示小红点 */
- (void)isShowRed {
    NSArray *array = [[NSUserDefaults standardUserDefaults]objectForKey:@"noticeTime"];
    if (array) {
       return  [self getNotice:array];
    }else{
        [self showRod:YES];
    }
}

- (void)showRod:(BOOL)isShow {
    self.dataSource[1][0].showRod = isShow;
    [self.tableView reloadData];
}
/*! 判断是非存在ID ，不存在则创建layer */
- (void)getNotice:(NSArray *)localArray {
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
    [self showRod:exist];
}


@end
