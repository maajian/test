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
#import "LoginViewController.h"
#import "SendViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "loginViewModel.h"
//#import <UMCommon/UMCommon.h>
//#import <UMShare/UMShare.h>
#import "WXApi.h"
#import <GTSDK/GeTuiSdk.h> 

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
NSString * const kdbManagerVersion = @"DBManagerVersion";
#define kYoumengAPPKEY @"58b3c7a275ca352ea8000c3a"
#define KMapkey @"ec66cd9c1c0675a526822e333504cad7"
#define kGtAppId           @"icsAR4twklA9djLiG36sh8"
#define kGtAppKey          @"ay5fEPhmTZ9o4kH0rS4GC9"
#define kGtAppSecret       @"ywcGQYVFht7o7x9eZ6zHE9"

@class AFURLResponseSerialization;

//58b3c7a275ca352ea8000c3a 友盟appkey
@interface AppDelegate ()<WXApiDelegate,UIApplicationDelegate, GeTuiSdkDelegate, UNUserNotificationCenterDelegate>
{
    NSDictionary *userDict;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    LoginViewController *login = [[LoginViewController alloc]init];
    NSString  *Unionid = [[NSUserDefaults standardUserDefaults]objectForKey:WX_UNION_ID];
    NSString *access = [[NSUserDefaults standardUserDefaults]objectForKey:AccessKey];
    NSString *mobile = [[NSUserDefaults standardUserDefaults]objectForKey:@"mobile"];
              //oX9XjjizWbtuCeHkJRKDwJDvPFEQ
              //oX9Xjjjk0W7TGowAdZZtcfdeNg0o uid
    /*! 数据库更新 */
    [self deleteDatabase];
    
//    [WXApi startLogByLevel:WXLogLevelDetail logBlock:^(NSString * _Nonnull log) {
//        NSLog(@"WeChatSDK: %@", log);
//    }];
    [WXApi registerApp:@"wxfe2a9da163481ba9" universalLink:@"https://open.zhundao.net/app/"];
    
//    [WXApi checkUniversalLinkReady:^(WXULCheckStep step, WXCheckULStepResult* result) {
//        NSLog(@"%@, %u, %@, %@", @(step), result.success, result.errorInfo, result.suggestion);
//    }];
    
    //友盟
    //开发者需要显式的调用此函数，日志系统才能工作
//    [UMConfigure setLogEnabled:YES];//设置打开日志
//    [UMConfigure initWithAppkey:@"58b3c7a275ca352ea8000c3a" channel:nil];
//    [[UMSocialManager defaultManager] openLog:YES];
//    /* 设置微信的appKey和appSecret */
//    [UMSocialGlobal shareInstance].universalLinkDic = @{@(UMSocialPlatformType_WechatSession):@"https://open.zhundao.net/app/",
//                                                        @(UMSocialPlatformType_QQ):@"https://www.zhundao.net/"};
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxfe2a9da163481ba9" appSecret:@"ace26a762813528cc2dbb65b4279398e" redirectURL:@"http://mobile.umeng.com/social"];
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105950214"/*设置QQ平台的appID*/  appSecret:@"GAFeY0k6OGdPe1nb" redirectURL:@"http://mobile.umeng.com/social"];
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    
    //地图
    [AMapServices sharedServices].apiKey = KMapkey;  //地图apikey
    
    //推送
    [GeTuiSdk startSdkWithAppId:kGtAppId appKey:kGtAppKey appSecret:kGtAppSecret delegate:self];
    [GeTuiSdk registerRemoteNotification: (UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge)];
    
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


#pragma  mark ----- 推送设置
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    //向个推服务器注册deviceToken
//    [GeTuiSdk registerDeviceTokenData:deviceToken];
}
/// 通知展示（iOS10及以上版本）
/// @param center center
/// @param notification notification
/// @param completionHandler completionHandler
- (void)GeTuiSdkNotificationCenter:(UNUserNotificationCenter *)center
           willPresentNotification:(UNNotification * )notification
             completionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler
__API_AVAILABLE(macos(10.14), ios(10.0), watchos(3.0), tvos(10.0)) {
    if (@available(iOS 10.0, *)) {
        if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            [GeTuiSdk resetBadge];
            if ([SignManager shareManager].getToken.length) {
                [ZD_NotificationCenter postNotificationName:ZDNotification_GetMessageList object:nil];
            }
        }else{
            //应用处于前台时的本地推送接受
        }
        //当应用处于前台时提示设置，需要哪个可以设置哪一个
        completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
    }
}

 
/// 收到通知信息
/// @param userInfo apns通知内容
/// @param center UNUserNotificationCenter（iOS10及以上版本）
/// @param response UNNotificationResponse（iOS10及以上版本）
/// @param completionHandler 用来在后台状态下进行操作（iOS10以下版本）
- (void)GeTuiSdkDidReceiveNotification:(NSDictionary *)userInfo
                    notificationCenter:(nullable UNUserNotificationCenter *)center
                              response:(nullable UNNotificationResponse *)response
                fetchCompletionHandler:(nullable void (^)(UIBackgroundFetchResult))completionHandler {
    [GeTuiSdk handleRemoteNotification:userInfo];
    NSLog(@"内容 = %@",userInfo);
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
        if ([SignManager shareManager].getToken.length) {
            [ZD_NotificationCenter postNotificationName:ZDNotification_GetMessageList object:nil];
        }
    } else{
        [GeTuiSdk resetBadge];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [ZD_NotificationCenter postNotificationName:ZDNotification_Push object:nil];
        });
    }
    if(completionHandler) {
        completionHandler(UIBackgroundFetchResultNoData);
    }
}


/// 收到透传消息
/// @param userInfo    推送消息内容
/// @param fromGetui   YES: 个推通道  NO：苹果apns通道
/// @param offLine     是否是离线消息，YES.是离线消息
/// @param appId       应用的appId
/// @param taskId      推送消息的任务id
/// @param msgId       推送消息的messageid
/// @param completionHandler 用来在后台状态下进行操作（通过苹果apns通道的消息 才有此参数值）
- (void)GeTuiSdkDidReceiveSlience:(NSDictionary *)userInfo
                        fromGetui:(BOOL)fromGetui
                          offLine:(BOOL)offLine
                            appId:(nullable NSString *)appId
                           taskId:(nullable NSString *)taskId
                            msgId:(nullable NSString *)msgId
           fetchCompletionHandler:(nullable void (^)(UIBackgroundFetchResult))completionHandler {
    [GeTuiSdk handleRemoteNotification:userInfo];
    NSLog(@"内容 = %@",userInfo);
    [GeTuiSdk resetBadge];
    if ([SignManager shareManager].getToken.length) {
        [ZD_NotificationCenter postNotificationName:ZDNotification_GetMessageList object:nil];
    }
    if(completionHandler) {
        completionHandler(UIBackgroundFetchResultNoData);
    }
}

- (void)GeTuiSdkNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification {
    // [ 参考代码，开发者注意根据实际需求自行修改 ] 根据APP需要自行修改参数值
}

// app杀死的时候调用
- (void)applicationHasKill:(UIApplication *)application Options:(NSDictionary *)launchOptions {
   if (launchOptions != nil) {
       NSDictionary * userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
       NSLog(@"userInfo = %@",userInfo);
       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           //关闭友盟自带的弹出框
           [GeTuiSdk resetBadge];
           if ([SignManager shareManager].getToken.length) {
               [ZD_NotificationCenter postNotificationName:ZDNotification_Push object:nil];
           }
       });
   }
}

/** SDK启动成功返回cid */
- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId {
    //个推SDK已注册，返回clientId
    NSLog(@"\n>>>[GeTuiSdk RegisterClient]:%@\n\n", clientId);
    ZD_UserM.clientId = clientId;
}

#pragma mark --- 三方授权
-(BOOL)application:(UIApplication *)application openURL:(nonnull NSURL *)url options:(nonnull NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    BOOL wxRes = [WXApi handleOpenURL:url delegate:self];
    return wxRes;
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:self];
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
    // 向微信请求授权后,得到响应结果
    NSLog(@"resp = %i", resp.errCode);
    if (resp.errCode==0) {
        if ([resp isKindOfClass:[SendAuthResp class]]) {
            SendAuthResp *temp = (SendAuthResp *)resp;
            NSLog(@"temp.code = %@",temp.code);
            NSLog(@"state = %@",temp.state);
            
            NSString *poststring =[NSString stringWithFormat:@"%@api/v2/weChatLogin?code=%@&type=1&from=ios",zhundaoApi,temp.code];
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

- (void)getUserInfo {
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
