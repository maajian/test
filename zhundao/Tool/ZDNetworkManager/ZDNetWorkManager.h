//
//  SWNetWorkManager.h
//  zhundao
//
//  Created by maj on 2019/7/13.
//  Copyright © 2019 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZDMacro.h"

#define ZD_NetWorkM [ZDNetWorkManager sharedNetWorkManager]

@interface ZDNetWorkManager : NSObject

+ (instancetype)sharedNetWorkManager;

+ (AFHTTPSessionManager *)shareHTTPSessionManager;
// 网络情况
@property (nonatomic, assign) AFNetworkReachabilityStatus networkStatus;
// 是否需要切换线路
- (void)autoChangeLine;

/**
 get请求
 */
- (void)getDataWithMethod:(NSString *)method parameters:(id)parameters succ:(ZDBlock_Dic)succ fail:(ZDBlock_Error)fail;
/**
 post请求
 */
- (void)postDataWithMethod:(NSString *)method parameters:(id)parameters succ:(ZDBlock_Dic)succ fail:(ZDBlock_Error)fail;

- (void)postDataWithMethod:(NSString *)method parameters:(id)parameters constructing:(void (^)(id<AFMultipartFormData> formData))constructing succ:(ZDBlock_Dic)succ fail:(ZDBlock_Error)fail;

@end
