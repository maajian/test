#import "PGAvtivityPostViewModel.h"
#import "Time.h"
#import "ActivityModel.h"
@implementation PGAvtivityPostViewModel
-  (void)getImage:(ZDSuccessBlock)successBlock error :(ZDErrorBlock)errorBlock {
    NSString *str = @"https://www.zhundao.net/images.txt";
    PGNetWorkManager.shareHTTPSessionManager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json",
    @"text/html",
    @"text/json",
    @"text/javascript",
    @"text/plain",
    nil];
    NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:0
                                                            diskCapacity:0
                                                                diskPath:nil];
    [NSURLCache setSharedURLCache:sharedCache];
    [ZD_NetWorkM getDataWithMethod:str parameters:nil succ:^(NSDictionary *obj) {
        NSLog(@"responseObject = %@",obj);
        successBlock(obj);
    } fail:^(NSError *error) {
    }];
}
- (NSString *)beginTime:(ActivityModel *)activityModel
{
    Time *time = [[Time alloc]init];
    NSString *str = nil;
    if (activityModel) {
        Time *time1 = [Time bringWithTime:activityModel.TimeStart];
        str = time1.timeStr;
    }
    else{
        str =  [time nextDateWithNumber:7];
    }
    return str;
}
- (NSString *)stopTime:(ActivityModel *)activityModel
{
    Time *time = [[Time alloc]init];
    NSString *str = nil;
    if (activityModel) {
        if (activityModel.EndTime.length!=0) {
            Time *time1 = [Time bringWithTime:activityModel.EndTime];
            str = time1.timeStr;
        }else{
            str = [[Time alloc]nextDateWithNumber:7];
        }
    }
    else{
        str =  [time nextDateWithNumber:14];
    }
    return str;
}
- (NSString *)startTime:(ActivityModel *)activityModel
{
    NSString *str = nil;
    if (activityModel) {
        Time *time1 = [Time bringWithTime:activityModel.StartTime];
        str = time1.timeStr;
        if (str ==nil) str = @"";
    }
    else{
        str =  @"";
    }
    return str;
}
- (NSString *)endTime:(ActivityModel *)activityModel
{
    Time *time = [[Time alloc]init];
    NSString *str = nil;
    if (activityModel) {
        Time *time1 = [Time bringWithTime:activityModel.TimeStop];
        str = time1.timeStr;
    }
    else{
        str =  [time nextDateWithNumber:7];
    }
    return str;
}
-(NSMutableArray *) getFeeArrayNotDelete:(ActivityModel *)activityModel  
{
    NSMutableArray *array = [activityModel.ActivityFees mutableCopy];
    for (NSDictionary *dic in activityModel.ActivityFees) {
        if ([dic[@"IsDeleted"]integerValue]) {
            [array removeObject:dic];
        }
    }
    return  array;
}
-(BOOL)isFalseTime :(NSString *)beginTime stopTime :(NSString *)stopTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate* stopDate1 = [formatter dateFromString:stopTime];
    NSDate* beginDate2 = [formatter dateFromString:beginTime];
    NSString *timeStop = [NSString stringWithFormat:@"%ld", (long)[stopDate1 timeIntervalSince1970]];
    NSString *timeBegin = [NSString stringWithFormat:@"%ld", (long)[beginDate2 timeIntervalSince1970]];
    if ([timeStop integerValue]- [timeBegin integerValue]>0) {
        return NO;  
    }
    else{
        return YES;
    }
}
- (NSString *)timeNow
{
    Time *time = [[Time alloc]init];
    NSString *str = [time nextDateWithNumber:0];
    return str;
}
- (NSString *)appendTime :(NSString *)timeStr{
    if (timeStr.length) {
        return  [timeStr stringByAppendingString:@":00"];
    }
    return @"";
}
- (NSInteger)isAlert:(NSDictionary *)dic
{
    NSString *str = [dic valueForKey:@"AlertSwitch"];
    if ([str integerValue]==0) {
        return 0;
    }
    else{
        return 1;
    }
}
- (NSString *)getUserInfo:(NSDictionary *)dic ALLOptionsArray :(NSArray *)ALLOptionsArray
{
    NSArray *boolarray = [dic[@"Boolarray"] copy];
    NSInteger count = 0 ;
    NSString *str = @"";
    for (int i = 0; i<12; i++) {
        if ([boolarray[i] integerValue]) {
            count+=1;
            if (count>1) {
                str = [str stringByAppendingString:@","];
            }
            str =  [str stringByAppendingString:ALLOptionsArray[i]];
        }
    }
    NSLog(@"固定项字符串为%@",str);
    return str;
}
- (NSString *)getExtraUserInfo:(NSDictionary *)dic ALLOptionsArray :(NSArray *)ALLOptionsArray
{
    NSArray *boolarray = [dic[@"Boolarray"] copy];
    NSString *str = @"";
    NSInteger count = 0 ;
    if (boolarray.count>12) {
        for (int i=12; i<boolarray.count; i++) {
            if ([boolarray[i] integerValue]) {
                count+=1;
                if (count>1) {
                    str = [str stringByAppendingString:@","];
                }
                str =   [str stringByAppendingString:[NSString stringWithFormat:@"%@",ALLOptionsArray[i]]];
            }
        }
    }
    NSLog(@"选填项字符串为%@",str);
    return str;
}
@end
