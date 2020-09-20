//
//  PGDiscoverPromoteCustomContactModel.m
//  zhundao
//
//  Created by maj on 2020/1/6.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "PGMePromoteCustomContactModel.h"

@implementation PGMePromoteCustomContactModel

+ (instancetype)incomeModelWithDic:(NSDictionary *)dic {
    PGMePromoteCustomContactModel *model = [[PGMePromoteCustomContactModel alloc] init];
    model.totalString = [dic[@"totalBonus"] stringValue];
    model.yesterdayString = [dic[@"yesterdayBonus"] stringValue];
    model.promoteCustomContactType = PGMePromoteCustomContactTypeIncome;
    return model;
}
+ (instancetype)orderModelWithDic:(NSDictionary *)dic {
    PGMePromoteCustomContactModel *model = [[PGMePromoteCustomContactModel alloc] init];
    model.totalString = [dic[@"totalOrder"] stringValue];
    model.yesterdayString = [dic[@"yesterdayOrder"] stringValue];
    model.promoteCustomContactType = PGMePromoteCustomContactTypeOrder;
    return model;
}
+ (instancetype)userNumberModelWithDic:(NSDictionary *)dic {
    PGMePromoteCustomContactModel *model = [[PGMePromoteCustomContactModel alloc] init];
    model.totalString = [dic[@"totalUser"] stringValue];
    model.yesterdayString = [dic[@"yesterdayOrder"] stringValue];
    model.promoteCustomContactType = PGMePromoteCustomContactTypeUserNumber;
    return model;
}

@end
