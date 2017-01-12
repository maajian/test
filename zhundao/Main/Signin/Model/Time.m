//
//  Time.m
//  zhundao
//
//  Created by zhundao on 2016/12/19.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import "Time.h"

@implementation Time
+(instancetype)bringWithTime:(NSString *)timeStr
{
    Time *time = [[Time alloc]init];
    if (time) {
        time.timeStr = timeStr;
    }
    return time;
}
//"2016-11-18T09:44:22.083";
- (void)setTimeStr:(NSString *)timeStr
{
    if (timeStr) {
        NSString *endstr1 = [timeStr stringByReplacingOccurrencesOfString:@"T" withString:@" "];
        
        NSArray *endarray = [endstr1 componentsSeparatedByString:@":"];
        NSString *str2 = [endarray firstObject];
        NSString *str3 = [endarray objectAtIndex:1];
        
        NSString *endstr2 = [str2 stringByAppendingString:@":"];
       _timeStr = [endstr2 stringByAppendingString:str3]; //2016-11-18 09:44
        
        
    }
    
}
@end
