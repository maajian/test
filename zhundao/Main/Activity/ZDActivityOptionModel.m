//
//  ZDActivityOptionModel.m
//  zhundao
//
//  Created by maj on 2021/3/29.
//  Copyright © 2021 zhundao. All rights reserved.
//

#import "ZDActivityOptionModel.h"

@implementation ZDActivityOptionModel
- (id)mutableCopyWithZone:(NSZone *)zone {
    ZDActivityOptionModel *model = [[[self class] allocWithZone:zone] init];
    model.ID = self.ID;
    model.IsCheck = self.IsCheck;
    model.Required = self.Required;
    model.Title = self.Title;
    return model;
}

- (id)copyWithZone:(NSZone *)zone {
    ZDActivityOptionModel *model = [[[self class] allocWithZone:zone] init];
    model.ID = self.ID;
    model.IsCheck = self.IsCheck;
    model.Required = self.Required;
    model.Title = self.Title;
    return model;
}

@end
