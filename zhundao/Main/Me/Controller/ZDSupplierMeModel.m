//
//  ZDSupplierMeModel.m
//  zhundao
//
//  Created by maj on 2021/9/2.
//  Copyright © 2021 zhundao. All rights reserved.
//

#import "ZDSupplierMeModel.h"

@implementation ZDSupplierMeModel

- (instancetype)initWithConferenceDic:(NSDictionary *)dic {
    if (self = [super init]) {
        self.company = ZD_SafeStringValue(dic[@"corp_name"]);
        self.admin_name = ZD_SafeStringValue(dic[@"legal_rep"]);
        self.access_token = ZD_SafeStringValue(dic[@"access_token"]);
    }
    return self;
}
- (instancetype)initWithConferenceInfoDic:(NSDictionary *)dic {
    if (self = [super init]) {
        self.company = ZD_SafeStringValue(dic[@"dept_name"]);
        self.admin_name = ZD_SafeStringValue(dic[@"true_name"]);
        self.duty = ZD_SafeStringValue(dic[@"position"]);
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.company = [aDecoder decodeObjectForKey:@"company"];
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.admin_name = [aDecoder decodeObjectForKey:@"admin_name"];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.company forKey:@"company"];
    [aCoder encodeObject:self.admin_name forKey:@"admin_name"];
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
}

@end
