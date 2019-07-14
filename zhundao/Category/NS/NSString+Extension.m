//
//  NSString+Extension.m
//  zhundao
//
//  Created by maj on 2019/7/6.
//  Copyright © 2019 zhundao. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

#pragma mark --- 获取首页时间
- (NSString *)getHomeActivityEndTime {
    NSDateFormatter *dateFormatter  = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *endstr1 = [self stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    NSArray *endarray = [endstr1 componentsSeparatedByString:@":"];
    NSString *str2 = [endarray firstObject];
    NSString *str3 = [endarray objectAtIndex:1];
    NSString *endstr2 = [str2 stringByAppendingString:@":"];
    NSString *timeStr = [endstr2 stringByAppendingString:str3]; //2016-11-18 09:44
    NSArray *onlyarr = [timeStr componentsSeparatedByString:@"-"];
    NSString *str4 = [onlyarr objectAtIndex:1];
    NSString *str5 = [onlyarr objectAtIndex:2];
    NSString *str6 = [str4 stringByAppendingString:@"-"];
    NSString  *endstr = [str6 stringByAppendingString:str5];
    NSString *sss = [timeStr stringByAppendingString:@":00"];
    NSDate *endD = [dateFormatter dateFromString:sss];
    NSTimeInterval start = [[NSDate date] timeIntervalSince1970]*1;
    NSTimeInterval end = [endD timeIntervalSince1970]*1;
    NSTimeInterval value = end - start;
    int minute = (int)value /60%60;
    int hour = (int)value / (3600)%24;
    int day1 = (int)value / (24 * 3600);
    if (day1>=1) {
        timeStr = [NSString stringWithFormat:@"报名截止: %@(剩%d天%d小时)",endstr,day1,hour];
    }
    if (day1==0&&hour>=1) {
        timeStr = [NSString stringWithFormat:@"报名截止: %@(剩%d小时%d分)",endstr,hour,minute];
    }
    if (day1==0&&hour==0&&minute>=0) {
        timeStr = [NSString stringWithFormat:@"报名截止: %@(剩%d分)",endstr,minute];
    }
    if (minute<0) {
        timeStr = [NSString stringWithFormat:@"报名截止: %@",endstr];
    }
    return timeStr;
}
- (NSString *)getHomeActivityBeginTime {
    NSDateFormatter *dateFormatter  = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *endstr1 = [self stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    NSArray *endarray = [endstr1 componentsSeparatedByString:@":"];
    NSString *str2 = [endarray firstObject];
    NSString *str3 = [endarray objectAtIndex:1];
    NSString *endstr2 = [str2 stringByAppendingString:@":"];
    NSString *timeStr = [endstr2 stringByAppendingString:str3]; //2016-11-18 09:44
    NSArray *onlyarr = [timeStr componentsSeparatedByString:@"-"];
    NSString *str4 = [onlyarr objectAtIndex:1];
    NSString *str5 = [onlyarr objectAtIndex:2];
    NSString *str6 = [str4 stringByAppendingString:@"-"];
    NSString  *endstr = [str6 stringByAppendingString:str5];
    NSString *sss = [timeStr stringByAppendingString:@":00"];
    NSDate *endD = [dateFormatter dateFromString:sss];
    NSTimeInterval start = [[NSDate date] timeIntervalSince1970]*1;
    NSTimeInterval end = [endD timeIntervalSince1970]*1;
    NSTimeInterval value = end - start;
    int minute = (int)value /60%60;
    int hour = (int)value / (3600)%24;
    int day1 = (int)value / (24 * 3600);
    if (day1>=1) {
        timeStr = [NSString stringWithFormat:@"活动开始: %@(剩%d天%d小时)",endstr,day1,hour];
    }
    if (day1==0&&hour>=1) {
        timeStr = [NSString stringWithFormat:@"活动开始: %@(剩%d小时%d分)",endstr,hour,minute];
    }
    if (day1==0&&hour==0&&minute>=0) {
        timeStr = [NSString stringWithFormat:@"活动开始: %@(剩%d分)",endstr,minute];
    }
    if (minute<0) {
        timeStr = [NSString stringWithFormat:@"活动开始: %@",endstr];
    }
    return timeStr;
}

@end
