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
    }
    return self;
}

@end
