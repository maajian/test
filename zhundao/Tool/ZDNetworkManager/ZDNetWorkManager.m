//
//  SWNetWorkManager.m
//  zhundao
//
//  Created by maj on 2019/7/13.
//  Copyright © 2019 zhundao. All rights reserved.
//

#import "ZDNetWorkManager.h"

@interface ZDNetWorkManager()

@end

@implementation ZDNetWorkManager
ZD_Singleton_Implementation(NetWorkManager)

+ (AFHTTPSessionManager *)shareHTTPSessionManager {
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 20.f;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/octet-stream", @"application/json", @"text/json" , @"text/javascript", nil];
//        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    });
    return manager;
}

#pragma mark --- network
/**
 get请求
 */
- (void)getDataWithMethod:(NSString *)method parameters:(id)parameters succ:(ZDBlock_Dic)succ fail:(ZDBlock_Error)fail {
    [[ZDNetWorkManager shareHTTPSessionManager] GET:method parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        succ(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        if (error.code == -1011) {
            [ZD_NotificationCenter postNotificationName:ZDNotification_Logout object:nil];
        } else {
            fail([self networkError]);
        }
    }];
}

/**
 post请求
 */
- (void)postDataWithMethod:(NSString *)method parameters:(id)parameters succ:(ZDBlock_Dic)succ fail:(ZDBlock_Error)fail {
    [[ZDNetWorkManager shareHTTPSessionManager] POST:method parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        succ(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        if (error.code == -1011) {
            [ZD_NotificationCenter postNotificationName:ZDNotification_Logout object:nil];
        }  else {
            fail([self networkError]);
        }
    }];
}

- (void)postDataWithMethod:(NSString *)method parameters:(id)parameters constructing:(void (^)(id<AFMultipartFormData> formData))constructing succ:(ZDBlock_Dic)succ fail:(ZDBlock_Error)fail {
    [[ZDNetWorkManager shareHTTPSessionManager] POST:method parameters:parameters constructingBodyWithBlock:constructing progress: nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        succ(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        if (error.code == -1011) {
            [ZD_NotificationCenter postNotificationName:ZDNotification_Logout object:nil];
        } else {
           fail([self networkError]);
       }
    }];
}

#pragma mark --- public

- (NSError *)networkError {
    NSDictionary *dic = @{@"error code": @(1002),
                          @"error description": @"网络错误, 请检查网络设置",
                          };
    NSError *error = [NSError errorWithDomain:@"网络错误, 请检查网络设置" code:1002 userInfo:dic];
    return error;
}

#pragma mark 第一次网络请求错误时间
// 是否需要切换线路
- (void)autoChangeLine {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:ZDUserDefault_First_Network]) {
        NSString *dayStr = [[NSUserDefaults standardUserDefaults] objectForKey:ZDUserDefault_First_Network];
        NSInteger day = [NSDate getDifferenceByDate:dayStr];
        if (day >= 1) {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:ZDUserDefault_First_Network];
        }
    }
}

@end
