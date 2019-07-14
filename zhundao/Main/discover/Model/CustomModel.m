//
//  CustomModel.m
//  zhundao
//
//  Created by zhundao on 2017/1/16.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "CustomModel.h"

@implementation CustomModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        self.ID = [dic[@"id"] integerValue];
        self.Title = dic[@"title"];
        self.Option = dic[@"option"];
        self.Required = [dic[@"required"] boolValue];
        self.Hidden = [dic[@"hidden"] boolValue];
        self.InputType = [dic[@"inputType"] integerValue];
    }
    return self;
}

@end
