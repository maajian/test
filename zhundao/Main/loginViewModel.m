//
//  loginViewModel.m
//  zhundao
//
//  Created by xhkj on 2018/4/16.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import "loginViewModel.h"

@implementation loginViewModel

/*! 账号密码登录后获取token */
+ (void)getTokenByAccount:(NSString *)phoneStr passWord:(NSString *)password {
    AFmanager *manager = [AFmanager shareManager];
    [manager GET:[NSString stringWithFormat:@"%@api/v2/getToken?userName=%@&password=%@&loginType=2",zhundaoApi,phoneStr,password] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"token"]) {
            [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"token"] forKey:@"token"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

/**
 微信登录后获取token

 */
+ (void)getTokenByWechat:(NSString *)code{
    AFmanager *manager = [AFmanager shareManager];
    [manager GET:[NSString stringWithFormat:@"%@api/v2/weChatLogin?code=%@&type=1",zhundaoApi,code] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"token"]) {
        [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"token"] forKey:@"token"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

@end
