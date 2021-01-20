//
//  ZDActivityAdminMarkModel.h
//  zhundao
//
//  Created by maj on 2021/1/9.
//  Copyright © 2021 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ZDAdminMarkType) {
    ZDAdminMarkTypeMark,
    ZDAdminMarkTypeGuestType,
    ZDAdminMarkTypeRoom,
    ZDAdminMarkTypeSeat,
    ZDAdminMarkTypeSave,
};

@interface ZDActivityAdminMarkModel : NSObject
@property (nonatomic, copy) NSString *headerTitle;
@property (nonatomic, copy) NSString *placeHolder;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) ZDAdminMarkType type;

+ (ZDActivityAdminMarkModel *)markModelWithDic:(NSDictionary *)dic;
+ (ZDActivityAdminMarkModel *)guestTypeModelWithDic:(NSDictionary *)dic;
+ (ZDActivityAdminMarkModel *)roomModelWithDic:(NSDictionary *)dic;
+ (ZDActivityAdminMarkModel *)seatModelWithDic:(NSDictionary *)dic;
+ (ZDActivityAdminMarkModel *)saveModel;

@end

NS_ASSUME_NONNULL_END
