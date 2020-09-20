//
//  ZDDiscoverFaceModel.m
//  zhundao
//
//  Created by zhundao on 2017/7/21.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ZDDiscoverFaceModel.h"

@implementation ZDDiscoverFaceModel

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.Name = [aDecoder decodeObjectForKey:@"Name"];
        self.deviceKey = [aDecoder decodeObjectForKey:@"deviceKey"];
        self.stock = [aDecoder decodeIntegerForKey:@"stock"];
        self.checkInName = [aDecoder decodeObjectForKey:@"checkInName"];
        self.checkInId = [aDecoder decodeIntegerForKey:@"checkInId"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.Name forKey:@"Name"];
    [aCoder encodeObject:self.deviceKey forKey:@"deviceKey"];
    [aCoder encodeInteger:self.stock forKey:@"stock"];
    [aCoder encodeObject:self.checkInName forKey:@"checkInName"];
    [aCoder encodeInteger:self.checkInId forKey:@"checkInId"];
}

@end
