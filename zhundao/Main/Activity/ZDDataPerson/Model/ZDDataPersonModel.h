//
//  ZDDataPersonModel.h
//  jingjing
//
//  Created by maj on 2020/8/10.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ZDDataPersonStatus) {
    ZDDataPersonStatusReview,
    ZDDataPersonStatusPass,
    ZDDataPersonStatusReject,
};

NS_ASSUME_NONNULL_BEGIN

//{
//    ActivityId = 239069;
//    AddById = 6037829;
//    AddByName = "\U5f90\U5448\U9f99";
//    AddTime = "2020-08-11T15:14:35.33";
//    DepartId = 146;
//    Id = 28;
//    IsExamine = 0;
//    Phone = 18368179123;
//    UserId = 388780;
//    UserName = "\U4e48\U4e48\U54d2";
//    ZdId = 3530062;
//}

@interface ZDDataPersonModel : NSObject
@property (nonatomic, assign) NSInteger ActivityId;
@property (nonatomic, copy) NSString *AddByName;

@property (nonatomic, copy) NSString *UserName;
@property (nonatomic, copy) NSString *Phone;
@property (nonatomic, copy) NSString *AddTime;
@property (nonatomic, assign) ZDDataPersonStatus dataPersonStatus;

// 扩展
@property (nonatomic, assign) NSInteger number; // 当前位置

@end

NS_ASSUME_NONNULL_END
