//
//  SWNetWorkManager.m
//  zhundao
//
//  Created by maj on 2019/7/13.
//  Copyright © 2019 zhundao. All rights reserved.
//

#import "ZDNetWorkManager.h"

@interface ZDNetWorkManager()
// 网络线路
@property (nonatomic, assign) BOOL isDefaultNetworkLine;

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
    });
    return manager;
}

#pragma mark --- network
/**
 get请求
 */
- (void)getDataWithMethod:(NSString *)method parameters:(id)parameters succ:(ZDBlock_Dic)succ fail:(ZDBlock_Error)fail {
     __block BOOL hasRequest = NO;
    ZD_WeakSelf
    ZDBlock_Void getBlock = ^(NSString *url, id param, ZDBlock_Str firstFail) {
        [[ZDNetWorkManager shareHTTPSessionManager] GET:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            DDLogVerbose(@"responseObject = %@, method = %@, param = %@", responseObject, method, parameters);
            succ(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            DDLogVerbose(@"error = %@, method = %@", error, method);
            NSString *newMethod = [self getNewMethodWithOldMethod:method];
            if (newMethod.length && hasRequest == NO) {
                hasRequest = YES;
                firstFail(newMethod);
            } else {
                hasRequest = YES;
                fail([weakSelf networkError]);
            }
        }];
    };
    getBlock(method, parameters, ^(NSString *str) {
        getBlock(str, parameters, nil);
    });
}

/**
 post请求
 */
- (void)postDataWithMethod:(NSString *)method parameters:(id)parameters succ:(ZDBlock_Dic)succ fail:(ZDBlock_Error)fail {
    __block BOOL hasRequest = NO;
   ZD_WeakSelf
   ZDBlock_Void postBlock = ^(NSString *url, id param, ZDBlock_Str firstFail) {
       [[ZDNetWorkManager shareHTTPSessionManager] POST:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           DDLogVerbose(@"responseObject = %@, method = %@, param = %@", responseObject, method, parameters);
           succ(responseObject);
       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           DDLogVerbose(@"error = %@, method = %@", error, method);
           NSString *newMethod = [self getNewMethodWithOldMethod:method];
           if (newMethod.length && hasRequest == NO) {
               hasRequest = YES;
               firstFail(newMethod);
           } else {
               hasRequest = YES;
               fail([weakSelf networkError]);
           }
       }];
   };
    postBlock(method, parameters, ^(NSString *str) {
        postBlock(str, parameters, nil);
   });
}

- (void)postDataWithMethod:(NSString *)method parameters:(id)parameters constructing:(void (^)(id<AFMultipartFormData> formData))constructing succ:(ZDBlock_Dic)succ fail:(ZDBlock_Error)fail {
    __block BOOL hasRequest = NO;
   ZD_WeakSelf
   ZDBlock_Void postBlock = ^(NSString *url, id param, ZDBlock_Str firstFail) {
       [[ZDNetWorkManager shareHTTPSessionManager] POST:url parameters:parameters constructingBodyWithBlock:constructing progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           DDLogVerbose(@"responseObject = %@, method = %@, param = %@", responseObject, method, parameters);
           succ(responseObject);
       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           DDLogVerbose(@"error = %@, method = %@", error, method);
           NSString *newMethod = [self getNewMethodWithOldMethod:method];
           if (newMethod.length && hasRequest == NO) {
               hasRequest = YES;
               firstFail(newMethod);
           } else {
               hasRequest = YES;
               fail([weakSelf networkError]);
           }
       }];
   };
    postBlock(method, parameters, ^(NSString *str) {
        postBlock(str, parameters, nil);
   });
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
- (NSString *)getNewMethodWithOldMethod:(NSString *)method {
    NSString *newUrl = @"open.zhundaoyun.com";
    NSString *oldUrl = @"open.zhundao.com.cn";
    if ([method containsString:oldUrl]) {
        method = [method stringByReplacingOccurrencesOfString:oldUrl withString:newUrl];
    } else if ([method containsString:newUrl]) {
        method = [method stringByReplacingOccurrencesOfString:newUrl withString:oldUrl];
    } else {
        method = @"";
    }
    return method;
}

//#define zhundaoApi ([[NSUserDefaults standardUserDefaults]objectForKey:@"ZDUserDefault_Network_Line"]?@"https://open.zhundao.com.cn/":@"https://open.zhundaoyun.com/")

#pragma mark --- getter
- (BOOL)isDefaultNetworkLine {
    if ([[ NSUserDefaults standardUserDefaults]objectForKey:ZDUserDefault_Network_Line]) {
        return NO;
    }else{
        return YES;
    }
}


@end
