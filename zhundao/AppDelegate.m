#import "PGLocationHeaderView.h"
//
//  AppDelegate.m
//  zhundao
//
//  Created by zhundao on 2016/12/1.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import "AppDelegate.h"
#import "PGBaseNavVC.h"
#import "PGBaseTabbarVC.h"
#import "PGLoginMainVC.h"
#import "PGloginSendVC.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "JPUSHService.h"
#import "PGloginMainViewModel.h"
#import <UMCommon/UMCommon.h>
#import <UMShare/UMShare.h>
#import "WXApi.h"

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
NSString * const kdbManagerVersion = @"DBManagerVersion";
#define kYoumengAPPKEY @"58b3c7a275ca352ea8000c3a"
#define KMapkey @"20ef0c1ba6b34bbe79a814a3578b0639"
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
    
    PGLoginMainVC *login = [[PGLoginMainVC alloc]init];
    NSString  *Unionid = [[NSUserDefaults standardUserDefaults]objectForKey:WX_UNION_ID];
    NSString *access = [[NSUserDefaults standardUserDefaults]objectForKey:AccessKey];
    NSString *mobile = [[NSUserDefaults standardUserDefaults]objectForKey:@"mobile"];
              //oX9XjjizWbtuCeHkJRKDwJDvPFEQ
              //oX9Xjjjk0W7TGowAdZZtcfdeNg0o uid
    /*! 数据库更新 */
    [self deleteDatabase];
    
    //友盟
    //开发者需要显式的调用此函数，日志系统才能工作
    [UMConfigure setLogEnabled:YES];//设置打开日志
    [UMConfigure initWithAppkey:@"58b3c7a275ca352ea8000c3a" channel:@"App Store"];
    [[UMSocialManager defaultManager] openLog:YES];
    /* 设置微信的appKey和appSecret */
    [WXApi registerApp:@"wx03bd16d684b23cb3" universalLink:@"https://app.zhundao.net/jttj/"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx03bd16d684b23cb3" appSecret:@"ace26a762813528cc2dbb65b4279398e" redirectURL:@"http://mobile.umeng.com/social"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105950214"/*设置QQ平台的appID*/  appSecret:@"GAFeY0k6OGdPe1nb" redirectURL:@"http://mobile.umeng.com/social"];
    [UMSocialGlobal shareInstance].universalLinkDic = @{@(UMSocialPlatformType_WechatSession):@"https://app.zhundao.net/jttj/",
                                                        @(UMSocialPlatformType_QQ):@"https://www.zhundao.net/"};
 
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    
    //地图
    [AMapServices sharedServices].apiKey = KMapkey;  //地图apikey
    
    //推送
    [self JPushSet:launchOptions];
    
    //是否登录
    if (Unionid==nil&&access==nil) {
        self.window.rootViewController = [[PGBaseNavVC alloc] initWithRootViewController:login];;
    }
    if (access) {
        PGBaseTabbarVC *tabbar = [[PGBaseTabbarVC alloc]init];
        self.window.rootViewController = tabbar;
    }
    if (Unionid&&[mobile isEqualToString:@"<null>"]) {
        self.window.rootViewController = [[PGBaseNavVC alloc] initWithRootViewController:login];
    }
    if (Unionid&&![mobile isEqualToString:@"<null>"]) {
        PGBaseTabbarVC *tabbar = [[PGBaseTabbarVC alloc]init];
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
        [[PGSignManager shareManager] createDatabase];
        if ([[PGSignManager shareManager].dataBase open])
        {
            NSString *updateSql = [NSString stringWithFormat:@"DROP TABLE signList"];
            [[PGSignManager shareManager].dataBase executeUpdate:updateSql];
            NSString *updateSql1 = [NSString stringWithFormat:@"DROP TABLE muliSignList"];
            [[PGSignManager shareManager].dataBase executeUpdate:updateSql1];
            NSString *updateSql12 = [NSString stringWithFormat:@"DROP TABLE contact"];
            [[PGSignManager shareManager].dataBase executeUpdate:updateSql12];
            [[PGSignManager shareManager].dataBase close];
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
dispatch_async(dispatch_get_main_queue(), ^{
    NSTextAlignment scrollDirectionRightc3 = NSTextAlignmentCenter; 
        UITableViewStyle contentBackgroundColoru4 = UITableViewStylePlain; 
    PGLocationHeaderView *swimMoviePlay= [[PGLocationHeaderView alloc] init];
[swimMoviePlay assetExportPresetWithlocationViewModel:scrollDirectionRightc3 imageWithLeft:contentBackgroundColoru4 ];
});
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
dispatch_async(dispatch_get_main_queue(), ^{
    NSTextAlignment commentSelectImageA6 = NSTextAlignmentCenter; 
        UITableViewStyle organizeHeaderViewL9 = UITableViewStylePlain; 
    PGLocationHeaderView *articleOriginalView= [[PGLocationHeaderView alloc] init];
[articleOriginalView assetExportPresetWithlocationViewModel:commentSelectImageA6 imageWithLeft:organizeHeaderViewL9 ];
});
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

-(BOOL)application:(UIApplication *)application openURL:(nonnull NSURL *)url options:(nonnull NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    BOOL wxRes = [WXApi handleOpenURL:url delegate:self];
    return result & wxRes;
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
- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler {
    return [WXApi handleOpenUniversalLink:userActivity delegate:self];;
}
#pragma mark  -----微信授权回调
- (void)onResp:(BaseResp *)resp {
    // 向微信请求授权后,得到响应结果'
    ZD_WeakSelf
    NSLog(@"resp = %i", resp.errCode);
    if (resp.errCode==0) {
        if ([resp isKindOfClass:[SendAuthResp class]]) {
            SendAuthResp *temp = (SendAuthResp *)resp;
            NSLog(@"temp.code = %@",temp.code);
            NSLog(@"state = %@",temp.state);
            
            NSDictionary *codeParam = @{@"appid" : ZDKey_Wechat_Key,
                                        @"secret" : ZDKey_Wechat_Secret,
                                        @"code" : temp.code,
                                        @"grant_type" : @"authorization_code"
            };
            NSString *authUrl = @"https://api.weixin.qq.com/sns/oauth2/access_token";
            [ZD_NetWorkM getDataWithMethod:authUrl parameters:codeParam succ:^(NSDictionary *obj) {
                if (ZD_SafeStringValue(obj[@"unionid"])) {
                    [weakSelf loginWehchatWithUnionId:obj[@"unionid"]];
                }
            } fail:^(NSError *error) {
                ZD_HUD_SHOW_ERROR_STATUS(@"微信登录失败")
            }];
        }
    }
}

- (void)loginWehchatWithUnionId:(NSString *)unionId {
    NSDictionary *dic = @{@"BusinessCode": @"WxLogin",
                          @"Data" : @{
                                  @"unionId": unionId,
                         }
    };
    NSString *url = [NSString stringWithFormat:@"%@jinTaData", zhundaoLogApi];
    ZD_HUD_SHOW_WAITING
    [ZD_NetWorkM postDataWithMethod:url parameters:dic succ:^(NSDictionary *obj) {
        ZD_HUD_DISMISS
        if ([obj[@"res"] boolValue]) {
            [ZD_UserM saveLoginTime];
            [[NSUserDefaults standardUserDefaults] setObject:obj[@"data"][@"token"] forKey:@"token"];
            [[NSUserDefaults standardUserDefaults]setObject:obj[@"data"][@"accessKey"] forKey:AccessKey];
            [[NSUserDefaults standardUserDefaults]synchronize];
            ZD_UserM.isAdmin = [obj[@"data"][@"role"] isEqualToString:@"admin"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                PGBaseTabbarVC *tabbar = [[PGBaseTabbarVC alloc] init];
                [UIApplication sharedApplication].delegate.window.rootViewController= tabbar;
            });
        } else {
            ZD_HUD_SHOW_ERROR_STATUS(obj[@"errmsg"]);
        }
    } fail:^(NSError *error) {
        ZD_HUD_SHOW_ERROR(error);
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
dispatch_async(dispatch_get_main_queue(), ^{
    NSTextAlignment finishPickingMediaF3 = NSTextAlignmentCenter; 
        UITableViewStyle mainScreenHeightD1 = UITableViewStylePlain; 
    PGLocationHeaderView *photoPickerBrowser= [[PGLocationHeaderView alloc] init];
[photoPickerBrowser assetExportPresetWithlocationViewModel:finishPickingMediaF3 imageWithLeft:mainScreenHeightD1 ];
});
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
