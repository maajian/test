//
//  PGDataPersonModel.m
//  jingjing
//
//  Created by maj on 2020/8/10.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "PGDataPersonModel.h"

@implementation PGDataPersonModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"dataPersonStatus" : @"IsExamine"
             };
}

@end
