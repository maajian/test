//
//  PGAvtivitySignUpModel.m
//  zhundao
//
//  Created by xhkj on 2018/4/24.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import "PGAvtivitySignUpModel.h"

@implementation PGAvtivitySignUpModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        NSString *time = dic[@"date"];
        self.date = time ?  [time substringFromIndex:5] : @"";
        self.count = [dic[@"count"] integerValue];
        
        self.title = dic[@"title"] ? dic[@"title"] : @"";
        self.amount = dic[@"amount"] ? [dic[@"amount"] floatValue] : 0;
    }
    return self;
}

@end
