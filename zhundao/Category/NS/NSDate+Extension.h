//
//  NSDate+Extension.h
//  zhundao
//
//  Created by maj on 2019/7/14.
//  Copyright © 2019 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Extension)
// 当前日期字符串
+ (NSString *)getCurrentDayStr;
// 获取相差天数
+ (NSInteger)getDifferenceByDate:(NSString *)date;

@end

NS_ASSUME_NONNULL_END
