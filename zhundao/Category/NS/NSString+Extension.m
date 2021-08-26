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
    } else if (day1==0&&hour>=1) {
        timeStr = [NSString stringWithFormat:@"报名截止: %@(剩%d小时%d分)",endstr,hour,minute];
    } else if (day1==0&&hour==0&&minute>=0) {
        timeStr = [NSString stringWithFormat:@"报名截止: %@(剩%d分)",endstr,minute];
    } else if (minute<0) {
        timeStr = [NSString stringWithFormat:@"报名截止: %@(已截止)",endstr];
    }
    return timeStr;
}
- (NSString *)getSortTime { // 2019-12-28 08:50:00 ---- > 12-28 08:50
    NSString *endstr1 = [self stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    NSArray *endarray = [endstr1 componentsSeparatedByString:@":"];
    NSString *str2 = [endarray firstObject];
    NSString *str3 = [endarray objectAtIndex:1];
    NSString *time1 = [[str2 stringByAppendingString:@":"] stringByAppendingString:str3];
    
    NSArray *array = [time1 componentsSeparatedByString:@"-"];
    NSString *str4 = [[array[1] stringByAppendingString:@"-"] stringByAppendingString:array[2]];
    return str4;
}

+ (NSString *)getHomeActivityBeginTime:(NSString *)beginTime stopTime:(NSString *)stopTime {
    NSString *begin = [[beginTime substringFromIndex:5] substringToIndex:11];
    NSString *stop = [[stopTime substringFromIndex:5] substringToIndex:11];
    return [NSString stringWithFormat:@"活动时间: %@ 一 %@",begin, stop];
}

- (NSDictionary *)zd_jsonDictionary {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    if ([dic isKindOfClass:[NSDictionary class]]) {
        return dic;
    }
    return nil;
}
- (NSArray *)zd_jsonArray {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    if ([arr isKindOfClass:[NSArray class]]) {
        return arr;
    }
    return nil;
}
- (BOOL)compareVesionWithServerVersion {
    NSArray *versionArray = [self componentsSeparatedByString:@"."];//服务器返回版
    NSArray *currentVesionArray = [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] componentsSeparatedByString:@"."];//当前版本
    NSInteger a = (versionArray.count> currentVesionArray.count)?currentVesionArray.count : versionArray.count;
    BOOL result = NO;
    for (int i = 0; i < a; i++) {
        NSInteger a = [[versionArray objectAtIndex:i] integerValue];
        NSInteger b = [[currentVesionArray objectAtIndex:i] integerValue];
        if (a >= b) {
            result = YES; // 表示服务器版本比当前版本大 3.0.0 > 2.1.0
            break;
        }else {
            result = NO; // 表示服务器版本比当前版本小 3.0.0 < 4.0.1
            break;
        }
    }
    return result;
}

@end
