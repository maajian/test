//
//  PGDataPersonAddModel.m
//  jingjing
//
//  Created by maj on 2020/8/10.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "PGDataPersonAddModel.h"

@implementation PGDataPersonAddModel

+ (instancetype)modelWithContent:(NSString *)content text:(NSString *)text type:(ZDDataPersonAddType)type {
    PGDataPersonAddModel *model = [PGDataPersonAddModel new];
    model.content = content;
    model.text = text;
    model.type = type;
    return model;
}

+ (instancetype)phoneModel {
    return [PGDataPersonAddModel modelWithContent:@"" text:@"手机" type:(ZDDataPersonAddTypePhone)];
}
+ (instancetype)nameModel {
    return [PGDataPersonAddModel modelWithContent:@"" text:@"姓名" type:(ZDDataPersonAddTypeName)];
}

@end
