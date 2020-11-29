//
//  loginViewModel.m
//  zhundao
//
//  Created by xhkj on 2018/4/16.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import "loginViewModel.h"

@implementation loginViewModel
/**
 微信登录后获取token

 */
+ (void)getTokenByWechat:(NSString *)code{
    [ZD_NetWorkM getDataWithMethod:[NSString stringWithFormat:@"%@api/v2/weChatLogin?code=%@&type=1",zhundaoApi,code] parameters:nil succ:^(NSDictionary *obj) {
        if (obj[@"token"]) {
            [[NSUserDefaults standardUserDefaults] setObject:obj[@"token"] forKey:@"token"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    } fail:^(NSError *error) {
        
    }];
}

@end
