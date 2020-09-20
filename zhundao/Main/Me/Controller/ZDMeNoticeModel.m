//
//  ZDMeNoticeModel.m
//  zhundao
//
//  Created by zhundao on 2017/8/15.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ZDMeNoticeModel.h"

@implementation ZDMeNoticeModel

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.AddTime = [aDecoder decodeObjectForKey:@"AddTime"];
        self.Detail = [aDecoder decodeObjectForKey:@"Detail"];
        self.SortName = [aDecoder decodeObjectForKey:@"SortName"];
        self.Title = [aDecoder decodeObjectForKey:@"Title"];
        self.ID = [aDecoder decodeIntegerForKey:@"ID"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.AddTime forKey:@"AddTime"];
    [aCoder encodeObject:self.Detail forKey:@"Detail"];
    [aCoder encodeObject:self.SortName forKey:@"SortName"];
    [aCoder encodeObject:self.Title forKey:@"Title"];
    [aCoder encodeInteger:self.ID forKey:@"ID"];
}



@end
///*! 添加时间 */
//@property(nonatomic,copy)NSString *AddTime;
///*! 详情内容 */
//@property(nonatomic,copy)NSString *Detail;
///*! 类别名称 */
//@property(nonatomic,copy)NSString *SortName;
///*! 文章名称 */
//@property(nonatomic,copy)NSString *Title;
/*! 文章id */
//@property(nonatomic,assign)NSInteger ID;
