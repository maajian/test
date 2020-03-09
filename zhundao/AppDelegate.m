//
//  AppDelegate.m
//  zhundao
//
//  Created by zhundao on 2016/12/1.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseNavigationViewController.h"
#import "MainViewController.h"
//#import "ActivityViewController.h"
#import "WXApi.h"
#import "LoginViewController.h"
#import <UMSocialCore/UMSocialCore.h>
#import "SendViewController.h"
#import "UMMobClick/MobClick.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "JPUSHService.h"
#import "loginViewModel.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
NSString * const kdbManagerVersion = @"DBManagerVersion";
#define kYoumengAPPKEY @"58b3c7a275ca352ea8000c3a"
#define KMapkey @"ec66cd9c1c0675a526822e333504cad7"
@class AFURLResponseSerialization;

//58b3c7a275ca352ea8000c3a 友盟appkey
@interface AppDelegate ()<WXApiDelegate,UIApplicationDelegate,JPUSHRegisterDelegate>
{
    NSDictionary *userDict;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
     [WXApi registerApp:@"wxfe2a9da163481ba9" ];
    LoginViewController *login = [[LoginViewController alloc]init];
    NSString  *Unionid = [[NSUserDefaults standardUserDefaults]objectForKey:WX_UNION_ID];
    NSString *access = [[NSUserDefaults standardUserDefaults]objectForKey:AccessKey];
    NSString *mobile = [[NSUserDefaults standardUserDefaults]objectForKey:@"mobile"];
              //oX9XjjizWbtuCeHkJRKDwJDvPFEQ
              //oX9Xjjjk0W7TGowAdZZtcfdeNg0o uid
    /*! 数据库更新 */
    [self deleteDatabase];
    //友盟
    
    [[UMSocialManager defaultManager] openLog:YES];
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:kYoumengAPPKEY];
    [self configUSharePlatforms];
    [MobClick setLogEnabled:YES];
    UMConfigInstance.appKey = @"58b3c7a275ca352ea8000c3a";
    UMConfigInstance.channelId = @"App Store";
    [MobClick startWithConfigure:UMConfigInstance];
    
    //地图
    [AMapServices sharedServices].apiKey = KMapkey;  //地图apikey
    
    //推送
    [self JPushSet:launchOptions];
    
    //是否登录
    if (Unionid==nil&&access==nil) {
        self.window.rootViewController = login;
    }
    if (access) {
        MainViewController *tabbar = [[MainViewController alloc]init];
        self.window.rootViewController = tabbar;
    }
    if (Unionid&&[mobile isEqualToString:@"<null>"]) {
        self.window.rootViewController = login;
    }
    if (Unionid&&![mobile isEqualToString:@"<null>"]) {
        MainViewController *tabbar = [[MainViewController alloc]init];
        self.window.rootViewController = tabbar;
    }
    
    if (@available(iOS 11.0, *)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.mConnBLE = [[ConnectViewController alloc] initWithNibName:nil bundle:nil];
    
     // app杀死时通知
//    [self applicationHasKill:application Options:launchOptions];
    
    [[AFNetworkReachabilityManager sharedManager]startMonitoring];
    [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        ZD_NetWorkM.networkStatus = status;
    }];
    return YES;
}
#pragma mark -----数据库更新
- (void)deleteDatabase
{
    NSInteger version = [[NSUserDefaults standardUserDefaults] integerForKey:kdbManagerVersion];
    if (version != 1) {
        [[SignManager shareManager] createDatabase];
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
        [self saveDBVersion];
    }
}
- (void)saveDBVersion {
    [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:kdbManagerVersion];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma  mark -----极光推送设置 

- (void)JPushSet:(NSDictionary *)launchOptions
{
     static NSString *appkey = @"770f6e079395b847e46bc296";
      NSString *channel = @"appStore";
    
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    [JPUSHService setupWithOption:launchOptions appKey:appkey
                          channel:channel
                 apsForProduction:0   //0为开发 1为上传app
            advertisingIdentifier:nil];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#pragma mark  ------ 推送代理 JPUSHRegisterDelegate
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:kAppNotification object:nil userInfo:userInfo];
    completionHandler(UNNotificationPresentationOptionAlert);
    
}


- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:kAppNotification object:nil userInfo:userInfo];
    completionHandler();
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    NSLog(@"内容 = %@",userInfo);
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    NSLog(@"内容 = %@",userInfo);
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}

// app杀死的时候调用
//- (void)applicationHasKill:(UIApplication *)application Options:(NSDictionary *)launchOptions {
//    if (launchOptions != nil) {
//        NSDictionary * userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//            [[NSNotificationCenter defaultCenter] postNotificationName:kAppNotification object:nil userInfo:userInfo];
//            //这个方法用来做action点击的统计
//            [JPUSHService handleRemoteNotification:userInfo];
//        });
//    }
//}

#pragma mark ------友盟分享设置
- (void)configUSharePlatforms
{
     [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxfe2a9da163481ba9" appSecret:@"ace26a762813528cc2dbb65b4279398e" redirectURL:@"https://mobile.umeng.com/social"];

    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105950214"/*设置QQ平台的appID*/  appSecret:@"GAFeY0k6OGdPe1nb" redirectURL:@"https://mobile.umeng.com/social"];
}



-(BOOL)application:(UIApplication *)application openURL:(nonnull NSURL *)url options:(nonnull NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    /*! @brief 处理微信通过URL启动App时传递的数据
     *
     * 需要在 application:openURL:sourceApplication:annotation:或者application:handleOpenURL中调用。
     * @param url 微信启动第三方应用时传递过来的URL
     * @param delegate  WXApiDelegate对象，用来接收微信触发的消息。
     * @return 成功返回YES，失败返回NO。
     */
    return [WXApi handleOpenURL:url delegate:self];
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    [WXApi handleOpenURL:url delegate:self];
    return YES;
}
#pragma mark  -----微信授权回调
- (void)onResp:(BaseResp *)resp {
    // 向微信请求授权后,得到响应结果
    NSLog(@"resp = %i", resp.errCode);
    if (resp.errCode==0) {
        if ([resp isKindOfClass:[SendAuthResp class]]) {
            SendAuthResp *temp = (SendAuthResp *)resp;
            NSLog(@"temp.code = %@",temp.code);
            NSLog(@"state = %@",temp.state);
            
            NSString *poststring =[NSString stringWithFormat:@"%@api/v2/weChatLogin?code=%@&type=1",zhundaoApi,temp.code];
            [ZD_NetWorkM getDataWithMethod:poststring parameters:nil succ:^(NSDictionary *obj) {
                [[NSUserDefaults standardUserDefaults] setObject:obj[@"accessKey"] forKey:AccessKey];
                [[NSUserDefaults standardUserDefaults] setObject:obj[@"token"] forKey:@"token"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                [self getUserInfo];
            } fail:^(NSError *error) {
                NSLog(@"发送失败");
            }];
        }
    }

}

- (void)getUserInfo
{
    
    NSString *userstr = [NSString stringWithFormat:@"%@api/v2/user/getUserInfo?token=%@",zhundaoApi,[[SignManager shareManager] getToken]];
    [ZD_NetWorkM getDataWithMethod:userstr parameters:nil succ:^(NSDictionary *obj) {
        [ZDUserManager.shareManager initWithDic:[obj[@"data"] deleteNullObj]];
        NSDictionary *data = [NSDictionary dictionaryWithDictionary:obj];
        NSDictionary  *userdic = data[@"data"];
        // 手机号码
        NSString *mobile = userdic[@"phone"] ? userdic[@"phone"] : @"";
        if (mobile.length) {
            [[ NSUserDefaults  standardUserDefaults]setObject:mobile forKey:@"mobile"];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"wechatLogin"];
            // 等级
            [[NSUserDefaults standardUserDefaults]setObject:userdic[@"gradeId"] forKey:@"GradeId"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            [ZD_UserM saveLoginTime];
            MainViewController *tabbar = [[MainViewController alloc]init];
            AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
            appDelegate.window.rootViewController= tabbar;
        } else {
            SendViewController *send = [[SendViewController alloc]init];
            self.window.rootViewController = send;
            send.Unionid = [[SignManager shareManager] getaccseekey];
        }
    } fail:^(NSError *error) {
        
    }];
}

//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
//    
//    [WXApi handleOpenURL:url delegate:self];
//    return YES;
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [ZD_NetWorkM autoChangeLine];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
