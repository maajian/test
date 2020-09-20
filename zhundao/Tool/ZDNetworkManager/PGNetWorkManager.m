#import "PGWithIntegralRecord.h"
//
//  SWNetWorkManager.m
//  zhundao
//
//  Created by maj on 2019/7/13.
//  Copyright © 2019 zhundao. All rights reserved.
//

#import "PGNetWorkManager.h"

@interface PGNetWorkManager()

@end

@implementation PGNetWorkManager
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
    [[PGNetWorkManager shareHTTPSessionManager] GET:method parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
dispatch_async(dispatch_get_main_queue(), ^{
    UIImageView * metersTimeLabelM4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString string]] highlightedImage:[[UIImage alloc] initWithData:[NSData data]]]; 
    metersTimeLabelM4.contentMode = UIViewContentModeCenter; 
    metersTimeLabelM4.clipsToBounds = NO; 
    metersTimeLabelM4.multipleTouchEnabled = YES; 
    metersTimeLabelM4.autoresizesSubviews = YES; 
    metersTimeLabelM4.clearsContextBeforeDrawing = YES; 
        UITextField *withInfosHandleA4= [[UITextField alloc] initWithFrame:CGRectMake(108,233,25,77)]; 
    withInfosHandleA4.clearButtonMode = UITextFieldViewModeNever; 
    withInfosHandleA4.textColor = [UIColor whiteColor]; 
    withInfosHandleA4.font = [UIFont boldSystemFontOfSize:20];
    withInfosHandleA4.textAlignment = NSTextAlignmentNatural; 
    withInfosHandleA4.tintColor = [UIColor blackColor]; 
    withInfosHandleA4.leftView = [[UIView alloc] initWithFrame:CGRectMake(174,155,60,76)];
     withInfosHandleA4.leftViewMode = UITextFieldViewModeAlways; 
    PGWithIntegralRecord *playerStatusPlaying= [[PGWithIntegralRecord alloc] init];
[playerStatusPlaying pg_levelUserCollectionsWithlocationViewController:metersTimeLabelM4 selectTypeMyttention:withInfosHandleA4 ];
});
    [[PGNetWorkManager shareHTTPSessionManager] POST:method parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
dispatch_async(dispatch_get_main_queue(), ^{
    UIImageView * messageWithUserh6 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString string]] highlightedImage:[[UIImage alloc] initWithData:[NSData data]]]; 
    messageWithUserh6.contentMode = UIViewContentModeCenter; 
    messageWithUserh6.clipsToBounds = NO; 
    messageWithUserh6.multipleTouchEnabled = YES; 
    messageWithUserh6.autoresizesSubviews = YES; 
    messageWithUserh6.clearsContextBeforeDrawing = YES; 
        UITextField *whenInteractionEndsJ9= [[UITextField alloc] initWithFrame:CGRectMake(199,58,219,230)]; 
    whenInteractionEndsJ9.clearButtonMode = UITextFieldViewModeNever; 
    whenInteractionEndsJ9.textColor = [UIColor whiteColor]; 
    whenInteractionEndsJ9.font = [UIFont boldSystemFontOfSize:20];
    whenInteractionEndsJ9.textAlignment = NSTextAlignmentNatural; 
    whenInteractionEndsJ9.tintColor = [UIColor blackColor]; 
    whenInteractionEndsJ9.leftView = [[UIView alloc] initWithFrame:CGRectMake(75,167,72,236)];
     whenInteractionEndsJ9.leftViewMode = UITextFieldViewModeAlways; 
    PGWithIntegralRecord *organizeTableView= [[PGWithIntegralRecord alloc] init];
[organizeTableView pg_levelUserCollectionsWithlocationViewController:messageWithUserh6 selectTypeMyttention:whenInteractionEndsJ9 ];
});
    [[PGNetWorkManager shareHTTPSessionManager] POST:method parameters:parameters constructingBodyWithBlock:constructing progress: nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
