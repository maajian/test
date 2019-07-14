//
//  NSDate+Extension.m
//  zhundao
//
//  Created by maj on 2019/7/14.
//  Copyright © 2019 zhundao. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)
// 当前日期字符串
+ (NSString *)getCurrentDayStr {
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter stringFromDate:now];
}
// 获取相差天数
+ (NSInteger)getDifferenceByDate:(NSString *)date {
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *oldDate = [dateFormatter dateFromString:date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned int unitFlags = NSCalendarUnitDay;
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:oldDate  toDate:now  options:0];
    return [comps day];
}

@end
