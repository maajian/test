//
//  SWNetWorkManager.m
//  zhundao
//
//  Created by maj on 2019/7/13.
//  Copyright © 2019 zhundao. All rights reserved.
//

#import "ZDNetWorkManager.h"

@implementation ZDNetWorkManager
ZD_Singleton_Implementation(ZDNetWorkManager)

+ (AFHTTPSessionManager *)shareHTTPSessionManager {
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
    });
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    return manager;
}

/**
 get请求
 */
- (void)getDataWithMethod:(NSString *)method parameters:(id)parameters succ:(ZDBlock_Dic)succ fail:(ZDBlock_Error)fail {
    [[ZDNetWorkManager shareHTTPSessionManager] GET:method parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        succ(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(error);
    }];
}

/**
 post请求
 */
- (void)postDataWithMethod:(NSString *)method parameters:(id)parameters succ:(ZDBlock_Dic)succ fail:(ZDBlock_Error)fail {
    [[ZDNetWorkManager shareHTTPSessionManager] POST:method parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        succ(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(error);
    }];
}

- (void)postDataWithMethod:(NSString *)method parameters:(id)parameters constructing:(void (^)(id<AFMultipartFormData> formData))constructing succ:(ZDBlock_Dic)succ fail:(ZDBlock_Error)fail {
    [[ZDNetWorkManager shareHTTPSessionManager] POST:method parameters:parameters constructingBodyWithBlock:constructing progress: nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        succ(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(error);
    }];
}









@end
