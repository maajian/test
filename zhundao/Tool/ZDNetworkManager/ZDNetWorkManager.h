//
//  SWNetWorkManager.h
//  zhundao
//
//  Created by maj on 2019/7/13.
//  Copyright © 2019 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZDNetWorkManager : NSObject
ZD_Singleton_Interface(ZDNetWorkManager)
+ (AFHTTPSessionManager *)shareHTTPSessionManager;

@end

NS_ASSUME_NONNULL_END
