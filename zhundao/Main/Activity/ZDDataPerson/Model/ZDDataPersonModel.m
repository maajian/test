//
//  ZDDataPersonModel.m
//  jingjing
//
//  Created by maj on 2020/8/10.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "ZDDataPersonModel.h"

@implementation ZDDataPersonModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"dataPersonStatus" : @"IsExamine"
             };
}

@end
