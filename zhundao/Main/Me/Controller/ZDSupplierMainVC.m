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

- (void)viewDidLoad {
    if (ZD_UserM.identifierType == ZDIdentifierTypeSupplier) {
        self.urlString = [NSString stringWithFormat:@"https://app.zhundao.net/settlement/m/supplier_list.html?token=%@", [[SignManager shareManager] getToken]];
        self.webTitle = @"准到";
    } else if (ZD_UserM.identifierType == ZDIdentifierTypePartner) {
        self.urlString = [NSString stringWithFormat:@"https://app.zhundao.net/event/home/index.html?token=%@", [[SignManager shareManager] getToken]];
        self.webTitle = @"准到";
    } else {
        self.urlString = [NSString stringWithFormat:@"https://app.zhundao.net/settlement/m/index_list.html?token=%@", ZD_UserM.supplierMeModel.access_token];
        self.webTitle = @"准到";
    }
    
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = nil;
    self.view.backgroundColor = ZDBackgroundColor;
    self.webView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTopBarHeight + kSafeBottomLayout - kTabBarHeight);
    self.webTitle = @"准到";
}

@end
