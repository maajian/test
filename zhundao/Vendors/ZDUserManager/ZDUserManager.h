//
//  ZDUserManager.h
//  zhundao
//
//  Created by maj on 2019/7/15.
//  Copyright © 2019 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define ZD_UserM [ZDUserManager shareManager]

@interface ZDUserManager : NSObject

+ (instancetype)shareManager;

/*! 退出登录清空数据 */
- (void)didLogout;

@end

NS_ASSUME_NONNULL_END
