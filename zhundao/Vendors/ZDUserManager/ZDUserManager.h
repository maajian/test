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

// 判断本地是否有签到
- (BOOL)hasLocalSign:(NSInteger)signID;
// 标记本地有签到
- (void)markLocalSign:(NSInteger)signID;
// 移除本地签到标记
- (void)removeLocalSign:(NSInteger)signID;

/*! 退出登录清空数据 */
- (void)didLogout;

@end

NS_ASSUME_NONNULL_END
