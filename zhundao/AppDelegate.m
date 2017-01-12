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
#import "ActivityViewController.h"
#import "WXApi.h"
#import "LoginViewController.h"
#import "SendViewController.h"
@class AFURLResponseSerialization;
//wxe25de2684f235a04 appid
//3286d02771487220b3135ed3620e552e appsecret
@interface AppDelegate ()<WXApiDelegate,UIApplicationDelegate>
{
    NSDictionary *userDict;
    
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    MainViewController *tabbar = [[MainViewController alloc]init];
     [WXApi registerApp:@"wxfe2a9da163481ba9" ];
    
    LoginViewController *login = [[LoginViewController alloc]init];
    

  NSString  *Unionid = [[NSUserDefaults standardUserDefaults]objectForKey:WX_UNION_ID];
   NSString *access = [[NSUserDefaults standardUserDefaults]objectForKey:AccessKey];
              //oX9XjjizWbtuCeHkJRKDwJDvPFEQ
              //oX9Xjjjk0W7TGowAdZZtcfdeNg0o uid
                
    
    if (Unionid==nil&&access==nil) {
        self.window.rootViewController = login;
    }
    if (Unionid||access) {

        self.window.rootViewController = tabbar;
    }
    [[AFNetworkReachabilityManager sharedManager]startMonitoring];
    [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {}];
    return YES;
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
- (void)onResp:(BaseResp *)resp {
    // 向微信请求授权后,得到响应结果
   SendViewController *send = [[SendViewController alloc]init];
    NSLog(@"resp = %@", resp.errStr);
    if (resp.errCode==0) {
        if ([resp isKindOfClass:[SendAuthResp class]]) {
            SendAuthResp *temp = (SendAuthResp *)resp;
            
            AFHTTPSessionManager *manager = [AFmanager shareManager];
            
            NSString *poststring =[NSString stringWithFormat:@"https://m.zhundao.net/oauth/appcallback?code=%@&type=android",temp.code];
            
            [manager POST:poststring parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                NSLog(@"responseObject= %@",responseObject);
                NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseObject];
                userDict = dic [@"Data"];
                NSString *imageurl = [NSString stringWithFormat:@"%@",userDict[@"HeadImgurl"]];
                NSString *sexurl = [NSString stringWithFormat:@"%@",userDict[@"Sex"]];
                NSString *nameurl = [NSString stringWithFormat:@"%@",userDict[@"NickName"]];
                NSLog(@"imageurl = %@",imageurl);
                NSString *Unionid = [NSString stringWithFormat:@"%@",userDict[WX_UNION_ID]];
                NSLog(@"Unionid= %@",Unionid);
                [[NSUserDefaults standardUserDefaults]setObject:Unionid forKey:WX_UNION_ID];
                [[NSUserDefaults standardUserDefaults]setObject:imageurl forKey:@"image"];
                [[NSUserDefaults standardUserDefaults]setObject:sexurl forKey:@"sex"];
                [[  NSUserDefaults standardUserDefaults  ]setObject:nameurl forKey:@"name"];
                NSString *path = NSHomeDirectory();
                NSLog(@"path : %@", path);
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                if ([userDict[@"Mobile"] isEqual:[NSNull null]]) {
                    self.window.rootViewController = send;
                }
                MainViewController *tabbar = [[MainViewController alloc]init];
                AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
                appDelegate.window.rootViewController= tabbar;
             
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"发送失败");
                
                
            }];
            
            
        }
    }

}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    
    [WXApi handleOpenURL:url delegate:self];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
