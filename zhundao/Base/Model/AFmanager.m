//
//  AFmanager.m
//  zhundao
//
//  Created by zhundao on 2016/12/30.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import "AFmanager.h"

@implementation AFmanager


+(AFHTTPSessionManager *)shareManager {
    static AFHTTPSessionManager *manager=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
//        manager.requestSerializer = [AFJSONRequestSerializer serializer];
//        manager.responseSerializer = [AFJSONResponseSerializer serializer];
    });
    
    return manager;
}
@end
