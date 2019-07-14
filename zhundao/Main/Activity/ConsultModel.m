//
//  ConsultModel.m
//  zhundao
//
//  Created by zhundao on 2017/8/3.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ConsultModel.h"

@implementation ConsultModel

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.AddTime = [aDecoder decodeObjectForKey:@"AddTime"];
        self.Answer = [aDecoder decodeObjectForKey:@"Answer"];
         self.HeadImgurl = [aDecoder decodeObjectForKey:@"HeadImgurl"];
         self.NickName = [aDecoder decodeObjectForKey:@"NickName"];
         self.Question = [aDecoder decodeObjectForKey:@"Question"];
         self.Title = [aDecoder decodeObjectForKey:@"Title"];
        self.ID = [aDecoder decodeIntegerForKey:@"ID"];
        self.IsRecommend = [aDecoder decodeIntegerForKey:@"IsRecommend"];
        self.IsReply = [aDecoder decodeIntegerForKey:@"IsReply"];
        
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.AddTime forKey:@"AddTime"];
    [aCoder encodeObject:self.Answer forKey:@"Answer"];
    [aCoder encodeObject:self.HeadImgurl forKey:@"HeadImgurl"];
    [aCoder encodeObject:self.NickName forKey:@"NickName"];
    [aCoder encodeObject:self.Question forKey:@"Question"];
    [aCoder encodeObject:self.Title forKey:@"Title"];
    [aCoder encodeInteger:self.ID forKey:@"ID"];
    [aCoder encodeInteger:self.IsRecommend forKey:@"IsRecommend"];
    [aCoder encodeInteger:self.IsReply forKey:@"IsReply"];
}


@end
