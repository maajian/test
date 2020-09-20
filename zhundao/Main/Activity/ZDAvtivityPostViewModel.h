//
//  ZDAvtivityPostViewModel.h
//  zhundao
//
//  Created by zhundao on 2017/9/13.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+block.h"
@interface ZDAvtivityPostViewModel : NSObject
/*! 获取图片 */
-  (void)getImage:(ZDSuccessBlock)successBlock error :(ZDErrorBlock)errorBlock;
/*! 活动开始时间 */
- (NSString *)beginTime:(ActivityModel *)activityModel;

/*! 活动结束时间 */
- (NSString *)stopTime:(ActivityModel *)activityModel;

/*! 报名开始时间 */
- (NSString *)startTime:(ActivityModel *)activityModel;

/*! 报名截止时间 */
- (NSString *)endTime:(ActivityModel *)activityModel;

/*! /获取未删除的费用项 */
-(NSMutableArray *) getFeeArrayNotDelete:(ActivityModel *)activityModel;

/*! 判断时间输入是否正确 */
-(BOOL)isFalseTime :(NSString *)beginTime stopTime :(NSString *)stopTime;

/*! 当前时间 */
- (NSString *)timeNow;

/*! 拼接后面的：00 */
- (NSString *)appendTime :(NSString *)timeStr;

/*! 是否开启报名用户提醒 */
- (NSInteger)isAlert:(NSDictionary *)dic;

/*! 获取基础报名项 */
- (NSString *)getUserInfo:(NSDictionary *)dic ALLOptionsArray :(NSArray *)ALLOptionsArray;

/*! 获取额外报名项 */
- (NSString *)getExtraUserInfo:(NSDictionary *)dic ALLOptionsArray :(NSArray *)ALLOptionsArray;

@end
