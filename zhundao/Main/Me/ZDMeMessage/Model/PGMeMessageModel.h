//
//  PGMeMessageModel.h
//  jingjing
//
//  Created by maj on 2020/8/4.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, PGMeMessageType) {
    PGMeMessageTypeAdmin,
    PGMeMessageTypeSystem,
};

@interface PGMeMessageModel : NSObject
@property (nonatomic, copy) NSString *AddTime;
@property (nonatomic, copy) NSString *Content;

@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, assign) NSInteger IsRead;
@property (nonatomic, assign) PGMeMessageType Type;
@property (nonatomic, assign) NSInteger UserId;
@property (nonatomic, assign) NSInteger ZdId;


@end

NS_ASSUME_NONNULL_END
