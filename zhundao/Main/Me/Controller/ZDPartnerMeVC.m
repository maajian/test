//
//  ZDPartnerMeVC.m
//  zhundao
//
//  Created by maj on 2021/9/23.
//  Copyright © 2021 zhundao. All rights reserved.
//

#import "ZDPartnerMeVC.h"

#import "ZDMainSupplierTabbarVC.h"
#import "MainViewController.h"

@interface ZDPartnerMeVC ()

@end

@implementation ZDPartnerMeVC

- (void)viewDidLoad {
    self.urlString = [NSString stringWithFormat:@"https://app.zhundao.net/my/customer/index.html?token=%@",[[SignManager shareManager] getToken]];
    self.webTitle = @"准到";
    [super viewDidLoad];
    self.title = @"准到";
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem identifierButtonWithText:@"当前身份:参与者" Target:self action:@selector(changeIdentifier)];
    self.navigationItem.leftBarButtonItem = nil;
}

#pragma mark --- Action
- (void)changeIdentifier {
    [AJAlertSheet showWithArray:@[@"主办方", @"参与者", @"会务公司", @"供应商"] title:@"请选择你的身份" isDelete:NO selectBlock:^(NSInteger index) {
        if (index == 1) {
            
        } else if (index == 2) {
            [self checkRegisterConference];
        } else if (index == 3) {
            [self checkRegisterSupplier];
        } else {
            MainViewController *tabbar = [[MainViewController alloc] init];
            tabbar.selectedIndex = 3;
            ZD_UserM.identifierType = ZDIdentifierTypeSponsor;
            [UIApplication sharedApplication].delegate.window.rootViewController= tabbar;
        }
    }];
}
- (void)checkRegisterSupplier {
    NSString *url = [NSString stringWithFormat:@"https://settlement.zhundaoyun.com/api/check_register?token=%@",[[SignManager shareManager] getToken]];
    [ZD_NetWorkM getDataWithMethod:url parameters:nil succ:^(NSDictionary *obj) {
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
