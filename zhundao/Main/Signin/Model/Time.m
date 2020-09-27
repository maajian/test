#import "PGCaseInsensitiveSearch.h"
#import "Time.h"  
@interface Time()
@property(nonatomic,strong)NSDateFormatter *DateFormatter;
@end
@implementation Time
+(instancetype)bringWithTime:(NSString *)timeStr
{
    Time *time = [[Time alloc]init];
    if (time) {
        time.timeStr = timeStr;
    }
    return time;
}
- (void)setTimeStr:(NSString *)timeStr 
{
    if (timeStr.length>0) {
        NSString *endstr1 = [timeStr stringByReplacingOccurrencesOfString:@"T" withString:@" "];
        NSArray *endarray = [endstr1 componentsSeparatedByString:@":"];
        NSString *str2 = [endarray firstObject];
        NSString *str3 = [endarray objectAtIndex:1];
        NSString *endstr2 = [str2 stringByAppendingString:@":"];
       _timeStr = [endstr2 stringByAppendingString:str3]; 
    }
}
- (NSString *)leftYearStrWithStr : (NSString *) str  
{
    NSArray *firstArr = [str componentsSeparatedByString:@" "];
    return firstArr.firstObject;
}
- (NSString *)nextDateWithNumber :(NSInteger)number  
{
    NSDate *date= [NSDate date];
    NSDate *nextdate = [NSDate dateWithTimeInterval:24*60*60*number sinceDate:date]; 
    NSDateFormatter *DateFormatter = [[NSDateFormatter alloc]init];
    [DateFormatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSString *datatime = [DateFormatter stringFromDate:nextdate];
    return datatime;
}
- (NSDate *)getDateWithNumber :(NSInteger)number
{
    NSDate *date= [NSDate date];
    NSDate *nextdate = [NSDate dateWithTimeInterval:24*60*60*number sinceDate:date]; 
    return nextdate;
}
- (NSDate *)getDateFromStr :(NSString *)timestr
{
    NSDateFormatter *DateFormatter = [[NSDateFormatter alloc]init];
    [DateFormatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSDate *date = [DateFormatter dateFromString:timestr];
    return date;
}
- (NSString *)getReciverStr:(NSString *)addStr{
    NSDateFormatter *DateFormatter = [[NSDateFormatter alloc]init];
    [DateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *endstr1 = [addStr stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    NSDate *date = [DateFormatter dateFromString:[endstr1 componentsSeparatedByString:@" "].firstObject];
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期天", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:date];
    if ([[weekdays objectAtIndex:theComponents.weekday] isEqualToString:@"星期四"]||[[weekdays objectAtIndex:theComponents.weekday] isEqualToString:@"星期五"]) {
      return   [DateFormatter stringFromDate:[NSDate dateWithTimeInterval:24*60*60*4 sinceDate:date]];
    }else if ([[weekdays objectAtIndex:theComponents.weekday] isEqualToString:@"星期六"]){
        return   [DateFormatter stringFromDate:[NSDate dateWithTimeInterval:24*60*60*3 sinceDate:date]];
    }else{
        return   [DateFormatter stringFromDate:[NSDate dateWithTimeInterval:24*60*60*2 sinceDate:date]];
    }
}
@end
