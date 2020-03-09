//
//  ZDDiscoverPromoteCustomContactModel.h
//  zhundao
//
//  Created by maj on 2020/1/6.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ZDMePromoteCustomContactType) {
    ZDMePromoteCustomContactTypeIncome,
    ZDMePromoteCustomContactTypeUserNumber,
    ZDMePromoteCustomContactTypeOrder,
};

@interface ZDMePromoteCustomContactModel : NSObject
// 类型
@property (nonatomic, assign) ZDMePromoteCustomContactType promoteCustomContactType;

@property (nonatomic, copy) NSString *totalString;
@property (nonatomic, copy) NSString *yesterdayString;

+ (instancetype)incomeModelWithDic:(NSDictionary *)dic;
+ (instancetype)orderModelWithDic:(NSDictionary *)dic;
+ (instancetype)userNumberModelWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
