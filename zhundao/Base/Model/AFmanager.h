//
//  AFmanager.h
//  zhundao
//
//  Created by zhundao on 2016/12/30.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface AFmanager : AFHTTPSessionManager

@property (nonatomic, assign) AFNetworkReachabilityStatus networkStatus;

+(AFmanager *)shareManager;


@end
