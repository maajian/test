//
//  ZDUserManager.m
//  zhundao
//
//  Created by maj on 2019/7/15.
//  Copyright © 2019 zhundao. All rights reserved.
//

#import "ZDUserManager.h"
#import "LoginViewController.h"

@implementation ZDUserManager

+ (instancetype)shareManager {
    static ZDUserManager *user = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [[ZDUserManager alloc] init];
    });
    return user;
}

#pragma mark --- 签到判断
// 判断本地是否有签到
- (BOOL)hasLocalSign:(NSInteger)signID {
    return [[NSUserDefaults standardUserDefaults] boolForKey:[NSString stringWithFormat:@"%@%li", ZDUserDefault_Sign_Mark, signID]];
}
// 标记本地有签到
- (void)markLocalSign:(NSInteger)signID {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:[NSString stringWithFormat:@"%@%li", ZDUserDefault_Sign_Mark, signID]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
// 移除本地签到标记
- (void)removeLocalSign:(NSInteger)signID {
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:[NSString stringWithFormat:@"%@%li", ZDUserDefault_Sign_Mark, signID]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark --- 本地数据
/*! 退出登录清空数据 */
- (void)didLogout
{
    /*! 清除本地数据 */
    NSDictionary *userArray = [[NSUserDefaults standardUserDefaults]objectForKey:@"userArray"];
    NSString *appDomain = [[NSBundle mainBundle]bundleIdentifier];
    [[NSUserDefaults standardUserDefaults]removePersistentDomainForName:appDomain];
    [[NSUserDefaults standardUserDefaults] setObject:userArray forKey:@"userArray"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if ([[SignManager shareManager].dataBase open])
    {
        NSString *updateSql = [NSString stringWithFormat:@"DROP TABLE signList"];
        [[SignManager shareManager].dataBase executeUpdate:updateSql];
        NSString *updateSql1 = [NSString stringWithFormat:@"DROP TABLE muliSignList"];
        [[SignManager shareManager].dataBase executeUpdate:updateSql1];
        NSString *updateSql12 = [NSString stringWithFormat:@"DROP TABLE contact"];
        [[SignManager shareManager].dataBase executeUpdate:updateSql12];
        [[SignManager shareManager].dataBase close];
    }
    LoginViewController *login = [[LoginViewController alloc]init];
    [UIApplication sharedApplication].delegate.window.rootViewController = login;
}

@end
