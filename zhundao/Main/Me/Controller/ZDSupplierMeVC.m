//
//  ZDSupplierMeVC.m
//  zhundao
//
//  Created by maj on 2021/9/2.
//  Copyright © 2021 zhundao. All rights reserved.
//

#import "ZDSupplierMeVC.h"
#import "ZDMainSupplierTabbarVC.h"
#import "MainViewController.h"

#import "ZDSupplierMeCell.h"

#import "ZDSupplierMeModel.h"

@interface ZDSupplierMeVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ZDSupplierMeVC
ZDGetter_MutableArray(dataSource)

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSet];
    [self initLayout];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self networkForGetInfo];
}

#pragma mark --- Init
- (void)initSet {
    self.navigationItem.title = @"准到";
    [self.view addSubview:self.tableView];
    if(ZD_UserM.identifierType == ZDIdentifierTypeSupplier)  {
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem identifierButtonWithText:@"当前身份:供应商" Target:self action:@selector(changeIdentifier)];
    } else {
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem identifierButtonWithText:@"当前身份:会务公司" Target:self action:@selector(changeIdentifier)];
    }
}
- (void)initLayout {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

#pragma mark --- network
- (void)networkForGetInfo {
    ZD_WeakSelf
    if (ZD_UserM.identifierType == ZDIdentifierTypeSupplier) {
        [self checkRegisterSupplier:^(NSDictionary *obj) {
            if ([obj[@"code"] integerValue] == 0) {
                ZD_UserM.identifierType = ZDIdentifierTypeSupplier;
                ZD_UserM.supplier_access_token = obj[@"data"][@"supplier_access_token"];
                NSString *url = @"https://settlement.zhundaoyun.com/api/supplier/get_supplier_info";
                [ZDNetWorkManager.shareHTTPSessionManager.requestSerializer setValue:ZD_UserM.supplier_access_token forHTTPHeaderField:@"supplier_access_token"];
                NSLog(@"ZD_UserM.supplier_access_token = %@", ZD_UserM.supplier_access_token);
                [ZD_NetWorkM getDataWithMethod:url parameters:nil succ:^(NSDictionary *obj) {
                    if ([obj[@"code"] integerValue] == 0) {
                        [weakSelf.dataSource removeAllObjects];
                        ZDSupplierMeModel *model = [ZDSupplierMeModel yy_modelWithJSON:obj[@"data"]];
                        model.headImg = ZD_UserM.headImgUrl;
                        model.duty = ZD_UserM.duty;
                        [weakSelf.dataSource addObject:model];
                        [weakSelf.tableView reloadData];
                    } else {
                        ZD_HUD_SHOW_ERROR_STATUS(obj[@"msg"])
                    }
                } fail:^(NSError *error) {
                    ZD_HUD_SHOW_ERROR(error);
                }];
            }
        }];
    } else {
        NSString *url = @"https://corp.zhundaoyun.com/api/get_user_info";
        [ZDNetWorkManager.shareHTTPSessionManager.requestSerializer setValue:ZD_UserM.supplierMeModel.access_token forHTTPHeaderField:@"access_token"];
        [ZD_NetWorkM getDataWithMethod:url parameters:nil succ:^(NSDictionary *obj) {
            if ([obj[@"code"] integerValue] == 0) {
                [weakSelf.dataSource removeAllObjects];
                ZDSupplierMeModel *model = [[ZDSupplierMeModel alloc] initWithConferenceInfoDic:[obj[@"data"] deleteNullObj]];
                model.headImg = ZD_UserM.headImgUrl;
                [weakSelf.dataSource addObject:model];
                [weakSelf.tableView reloadData];
            } else {
                ZD_HUD_SHOW_ERROR_STATUS(obj[@"msg"])
            }
        } fail:^(NSError *error) {
            ZD_HUD_SHOW_ERROR(error);
        }];
    }
}

#pragma mark --- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZDSupplierMeCell *cell = [tableView dequeueReusableCellWithIdentifier:ZD_ClassName([ZDSupplierMeCell class])];
    cell.backgroundColor = [UIColor whiteColor];
    ZDSupplierMeModel *model = self.dataSource[indexPath.row];
    cell.model = model;
    return cell;
}

#pragma mark --- UITableViewDelegate

#pragma mark --- Lazyload
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = 70;
        _tableView.backgroundColor = ZDBackgroundColor;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
        [_tableView registerClass:[ZDSupplierMeCell class] forCellReuseIdentifier:ZD_ClassName([ZDSupplierMeCell class])];
    }
    return _tableView;
}

#pragma mark --- Action
- (void)changeIdentifier {
    [AJAlertSheet showWithArray:@[@"主办方", @"参与者", @"会务公司", @"供应商"] title:@"请选择你的身份" isDelete:NO selectBlock:^(NSInteger index) {
        if (index == 1) {
            [self showPartner];
        } else if (index == 2) {
            [self checkRegisterConference];
        } else if (index == 3) {
            if(ZD_UserM.identifierType == ZDIdentifierTypeConference)  {
                [self jumpSupplier];
            }
        } else {
            MainViewController *tabbar = [[MainViewController alloc] init];
            tabbar.selectedIndex = 3;
            [UIApplication sharedApplication].delegate.window.rootViewController= tabbar;
            ZD_UserM.identifierType = ZDIdentifierTypeSponsor;
        }
    }];
}
- (void)showPartner {
    ZD_UserM.identifierType = ZDIdentifierTypePartner;
    ZDMainSupplierTabbarVC *vc = [[ZDMainSupplierTabbarVC alloc] init];
    vc.selectedIndex = 2;
    [UIApplication sharedApplication].delegate.window.rootViewController = vc;
}
- (void)checkRegisterSupplier:(ZDBlock_Dic)success {
    NSString *url = [NSString stringWithFormat:@"https://settlement.zhundaoyun.com/api/check_register?token=%@",[[SignManager shareManager] getToken]];
    [ZD_NetWorkM getDataWithMethod:url parameters:nil succ:^(NSDictionary *obj) {
        ZDDo_Block_Safe_Main1(success, obj)
    } fail:^(NSError *error) {
        ZD_HUD_SHOW_ERROR(error)
    }];
}
- (void)jumpSupplier {
    [self checkRegisterSupplier:^(NSDictionary *obj) {
        if ([obj[@"code"] integerValue] == 0) {
            ZD_UserM.identifierType = ZDIdentifierTypeSupplier;
            ZD_UserM.supplier_access_token = obj[@"data"][@"supplier_access_token"];
            ZDMainSupplierTabbarVC *vc = [[ZDMainSupplierTabbarVC alloc] init];
            vc.selectedIndex = 2;
            [UIApplication sharedApplication].delegate.window.rootViewController = vc;
        } else {
            ZDWebViewController *web = [[ZDWebViewController alloc] init];
            web.isClose = YES;
            web.urlString = [NSString stringWithFormat:@"https://app.zhundao.net/settlement/supplier.html?token=%@#/register/",[[SignManager shareManager] getToken]];
            [self setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:web animated:YES];
            [self setHidesBottomBarWhenPushed:NO];
        }
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
- (void)showConferenceList:(NSMutableArray<ZDSupplierMeModel *> *)conferenceArray {
    NSMutableArray *nameArray = [NSMutableArray array];
    [conferenceArray enumerateObjectsUsingBlock:^(ZDSupplierMeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [nameArray addObject:obj.company];
    }];
    [AJAlertSheet showWithArray:nameArray title:@"请选择会务公司" isDelete:NO selectBlock:^(NSInteger index) {
        ZD_UserM.supplierMeModel = conferenceArray[index];
        ZD_UserM.identifierType = ZDIdentifierTypeConference;
        ZDMainSupplierTabbarVC *vc = [[ZDMainSupplierTabbarVC alloc] init];
        vc.selectedIndex = 2;
        [UIApplication sharedApplication].delegate.window.rootViewController = vc;
    }];
}

@end
