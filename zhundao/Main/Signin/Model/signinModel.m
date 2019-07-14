//
//  signinModel.m
//  zhundao
//
//  Created by zhundao on 2016/12/9.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import "signinModel.h"

@implementation signinModel




- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.Name = [aDecoder decodeObjectForKey:@"Name"];
        self.ActivityName = [aDecoder decodeObjectForKey:@"ActivityName"];
        self.AddTime = [aDecoder decodeObjectForKey:@"AddTime"];
        self.CheckInType = [aDecoder decodeIntegerForKey:@"CheckInType"];
         self.Status = [aDecoder decodeIntegerForKey:@"Status"];
         self.NumShould = [aDecoder decodeIntegerForKey:@"NumShould"];
         self.NumFact = [aDecoder decodeIntegerForKey:@"NumFact"];
         self.ID = [aDecoder decodeIntegerForKey:@"ID"];
         self.ActivityID = [aDecoder decodeIntegerForKey:@"ActivityID"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.Name forKey:@"Name"];
    [aCoder encodeObject:self.ActivityName forKey:@"ActivityName"];
    [aCoder encodeObject:self.AddTime forKey:@"AddTime"];
    [aCoder encodeInteger:self.CheckInType forKey:@"CheckInType"];
    [aCoder encodeInteger:self.Status forKey:@"Status"];
    [aCoder encodeInteger:self.NumShould forKey:@"NumShould"];
    [aCoder encodeInteger:self.NumFact forKey:@"NumFact"];
    [aCoder encodeInteger:self.ID forKey:@"ID"];
    [aCoder encodeInteger:self.ActivityID forKey:@"ActivityID"];
}


@end
