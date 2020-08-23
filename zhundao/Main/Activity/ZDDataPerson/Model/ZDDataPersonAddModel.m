//
//  ZDDataPersonAddModel.m
//  jingjing
//
//  Created by maj on 2020/8/10.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "ZDDataPersonAddModel.h"

@implementation ZDDataPersonAddModel

+ (instancetype)modelWithContent:(NSString *)content text:(NSString *)text type:(ZDDataPersonAddType)type {
    ZDDataPersonAddModel *model = [ZDDataPersonAddModel new];
    model.content = content;
    model.text = text;
    model.type = type;
    return model;
}

+ (instancetype)phoneModel {
    return [ZDDataPersonAddModel modelWithContent:@"" text:@"手机" type:(ZDDataPersonAddTypePhone)];
}
+ (instancetype)nameModel {
    return [ZDDataPersonAddModel modelWithContent:@"" text:@"姓名" type:(ZDDataPersonAddTypeName)];
}

@end
