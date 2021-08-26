//
//  ZDMessageMainModel.h
//  zhundao
//
//  Created by maj on 2020/12/6.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, ZDMeMessageType) {
    ZDMeMessageTypeAdmin,
    ZDMeMessageTypeSystem,
};

//100app内打开网址，101app外打开网址，102打开消息列表，103打开消息详情 104打开报名名单
typedef NS_ENUM(NSInteger, ZDMeMessageClickType) {
    ZDMeMessageClickTypeNone = 0,
    ZDMeMessageClickTypeWebInApp1 = 100,
    ZDMeMessageClickTypeWebOutApp = 101,
    ZDMeMessageClickTypeMessageList = 102,
    ZDMeMessageClickTypeMessageDetail = 103,
    ZDMeMessageClickTypeApplyList = 104,
    ZDMeMessageClickTypeWebInApp2 = 105,
    ZDMeMessageClickTypeWebInApp3 = 106,
};

@interface ZDMessageMainModel : NSObject
@property (nonatomic, copy) NSString *AddTime;
@property (nonatomic, copy) NSString *Content;
@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, assign) NSInteger IsRead;
@property (nonatomic, assign) ZDMeMessageType Type;
@property (nonatomic, assign) NSInteger UserId;
@property (nonatomic, assign) NSInteger ZdId;

@property (nonatomic, assign) ZDMeMessageClickType click_type;
@property (nonatomic, strong) id param;
@property (nonatomic, copy) NSString *url;

@end

NS_ASSUME_NONNULL_END
