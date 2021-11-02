//
//  ZDPartnerMeVC.m
//  zhundao
//
//  Created by maj on 2021/9/23.
//  Copyright © 2021 zhundao. All rights reserved.
//

#import "ZDPartnerMeVC.h"

@interface ZDPartnerMeVC ()

@end

@implementation ZDPartnerMeVC

- (instancetype)init {
    if (self = [super init]) {
        self.urlString = [NSString stringWithFormat:@"https://app.zhundao.net/my/customer/index.html?token=%@",[[SignManager shareManager] getToken]];
        self.title = @"我";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem textBarButtonItemWithText:@"当前身份:参与者" color:ZDGrayColor2 Target:self action:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
