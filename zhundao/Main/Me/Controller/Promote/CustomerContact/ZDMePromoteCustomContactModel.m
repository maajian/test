//
//  ZDDiscoverPromoteCustomContactModel.m
//  zhundao
//
//  Created by maj on 2020/1/6.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "ZDMePromoteCustomContactModel.h"

@implementation ZDMePromoteCustomContactModel

+ (instancetype)incomeModelWithDic:(NSDictionary *)dic {
    ZDMePromoteCustomContactModel *model = [[ZDMePromoteCustomContactModel alloc] init];
    model.totalString = [dic[@"totalBonus"] stringValue];
    model.yesterdayString = [dic[@"yesterdayBonus"] stringValue];
    model.promoteCustomContactType = ZDMePromoteCustomContactTypeIncome;
    return model;
}
+ (instancetype)orderModelWithDic:(NSDictionary *)dic {
    ZDMePromoteCustomContactModel *model = [[ZDMePromoteCustomContactModel alloc] init];
    model.totalString = [dic[@"totalOrder"] stringValue];
    model.yesterdayString = [dic[@"yesterdayOrder"] stringValue];
    model.promoteCustomContactType = ZDMePromoteCustomContactTypeOrder;
    return model;
}
+ (instancetype)userNumberModelWithDic:(NSDictionary *)dic {
    ZDMePromoteCustomContactModel *model = [[ZDMePromoteCustomContactModel alloc] init];
    model.totalString = [dic[@"totalUser"] stringValue];
    model.yesterdayString = [dic[@"yesterdayOrder"] stringValue];
    model.promoteCustomContactType = ZDMePromoteCustomContactTypeUserNumber;
    return model;
}

@end
