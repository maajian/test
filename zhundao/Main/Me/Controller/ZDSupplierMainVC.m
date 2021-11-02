//
//  ZDSupplierMainVC.m
//  zhundao
//
//  Created by maj on 2021/9/2.
//  Copyright © 2021 zhundao. All rights reserved.
//

#import "ZDSupplierMainVC.h"

@interface ZDSupplierMainVC ()

@end

@implementation ZDSupplierMainVC

- (instancetype)init {
    if (self = [super init]) {
        if (ZD_UserM.identifierType == ZDIdentifierTypeSupplier) {
            self.urlString = [NSString stringWithFormat:@"https://app.zhundao.net/settlement/m/supplier_list.html?token=%@", [[SignManager shareManager] getToken]];
            self.webTitle = @"当前身份:供应商";
        } else if (ZD_UserM.identifierType == ZDIdentifierTypePartner) {
            self.urlString = [NSString stringWithFormat:@"https://app.zhundao.net/event/home/index.html?token=%@", [[SignManager shareManager] getToken]];
            self.webTitle = @"当前身份:参与者";
        } else {
            self.urlString = [NSString stringWithFormat:@"https://app.zhundao.net/settlement/m/index_list.html?token=%@", ZD_UserM.supplierMeModel.access_token];
            self.webTitle = @"当前身份:会务公司";
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = ZDBackgroundColor;
    self.webView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTopBarHeight + kSafeBottomLayout - kTabBarHeight);
}

- (void)popOne {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    } else {
        ZD_UserM.identifierType = ZDIdentifierTypeSponsor;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ZDMainSupplierTabbarPop" object:nil];
    }
}

@end
