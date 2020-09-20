//
//  PGAvtivitySignUpViewModel.h
//  zhundao
//
//  Created by xhkj on 2018/4/24.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PGAvtivitySignUpModel.h"

@interface PGAvtivitySignUpViewModel : NSObject
/*! x轴显示 */
@property (nonatomic, strong) NSMutableArray<NSString *> *xLabelArray;
/*! 数据 */
@property (nonatomic, strong) NSMutableArray *dataArray;
/*! 付款人数 */
@property (nonatomic, strong) NSMutableArray *personCountArray;

/*! 根据时间获取报名人数数据 */
- (void)getActivityListDate:(NSInteger)activityId
                  beginDate:(NSString *)beginDate
                    endDate:(NSString *)endDate
               successBlock:(kZDCommonSucc)successBlock
                  failBlock:(kZDCommonFail)failBlock ;

/*! 获取浏览人数数据 */
- (void)getActivityReadDate:(NSInteger)activityId
                  beginDate:(NSString *)beginDate
                    endDate:(NSString *)endDate
               successBlock:(kZDCommonSucc)successBlock
                  failBlock:(kZDCommonFail)failBlock;

/*! 付款人数 */
- (void)getFeePeopleNoDate:(NSInteger)activityId
              successBlock:(kZDCommonSucc)successBlock
                 failBlock:(kZDCommonFail)failBlock;

/*! 项目收入 */
- (void)getEachFeeDate:(NSInteger)activityId
          successBlock:(kZDCommonSucc)successBlock
             failBlock:(kZDCommonFail)failBlock;

@end
