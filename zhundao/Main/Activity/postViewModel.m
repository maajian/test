//
//  postViewModel.m
//  zhundao
//
//  Created by zhundao on 2017/9/13.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "postViewModel.h"
#import "Time.h"
#import "ActivityModel.h"
@implementation postViewModel

/*! 获取图片数组 */

-  (void)getImage:(ZDSuccessBlock)successBlock error :(ZDErrorBlock)errorBlock {
    NSString *str = @"https://www.zhundao.net/images.txt";
    AFmanager *manager = [AFmanager shareManager];
    NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:0
                                                            diskCapacity:0
                                                                diskPath:nil];
    [NSURLCache setSharedURLCache:sharedCache];
    [manager GET:str parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject = %@",responseObject);
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error);
    }];
}


/*! 活动开始时间 */
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
/*! 活动结束时间 */
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
/*! 报名开始时间 */
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
/*! 报名截止时间 */
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
/*! 获取未删除的费用项 */
-(NSMutableArray *) getFeeArrayNotDelete:(ActivityModel *)activityModel  //获取未删除的费用项
{
    NSMutableArray *array = [activityModel.ActivityFees mutableCopy];
    for (NSDictionary *dic in activityModel.ActivityFees) {
        if ([dic[@"IsDeleted"]integerValue]) {
            [array removeObject:dic];
        }
    }
    return  array;
}
/*! 判断时间输入是否正确 */
-(BOOL)isFalseTime :(NSString *)beginTime stopTime :(NSString *)stopTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate* stopDate1 = [formatter dateFromString:stopTime];//结束时间
    NSDate* beginDate2 = [formatter dateFromString:beginTime];//开始时间
    NSString *timeStop = [NSString stringWithFormat:@"%ld", (long)[stopDate1 timeIntervalSince1970]];
    NSString *timeBegin = [NSString stringWithFormat:@"%ld", (long)[beginDate2 timeIntervalSince1970]];
    if ([timeStop integerValue]- [timeBegin integerValue]>0) {
        return NO;  //时间正确
    }
    else{
        return YES;//时间错误
    }
}
/*! 当前时间 */
- (NSString *)timeNow
{
    Time *time = [[Time alloc]init];
    NSString *str = [time nextDateWithNumber:0];
    return str;
}
/*! 拼接后面的：00 */
- (NSString *)appendTime :(NSString *)timeStr{
    if (timeStr.length) {
        return  [timeStr stringByAppendingString:@":00"];
    }
    return @"";
}
/*! 是否开启报名用户提醒 */
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

/*! 获取基础报名项 */
- (NSString *)getUserInfo:(NSDictionary *)dic ALLOptionsArray :(NSArray *)ALLOptionsArray
{
    NSArray *boolarray = [dic[@"Boolarray"] copy];
    NSInteger count = 0 ;//计算添加逗号, 100,101
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
/*! 获取额外报名项 */
- (NSString *)getExtraUserInfo:(NSDictionary *)dic ALLOptionsArray :(NSArray *)ALLOptionsArray
{
    NSArray *boolarray = [dic[@"Boolarray"] copy];
    NSString *str = @"";
    NSInteger count = 0 ;//计算添加逗号, 100,101
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
