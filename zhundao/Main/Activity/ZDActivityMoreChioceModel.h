//
//  ZDActivityMoreChioceModel.h
//  zhundao
//
//  Created by maj on 2021/3/30.
//  Copyright © 2021 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZDActivityOptionModel.h"

typedef NS_ENUM(NSInteger, ZDActivityShowListType) {
    ZDActivityShowListTypeCountAndNickname = 0, // 显示人数和昵称
    ZDActivityShowListTypeCount, // 显示人数
    ZDActivityShowListTypeNone, // 隐藏
    ZDActivityShowListTypeCountAndUsername, // 显示人数和姓名
};

typedef NS_ENUM(NSInteger, ZDActivityMoreChioceType) {
    ZDActivityMoreChioceTypeImage, // 分享小图
    ZDActivityMoreChioceTypeOption, // 报名填写项
    ZDActivityMoreChioceTypeAlert, // 用户报名提醒
    ZDActivityMoreChioceTypeShowList, // 报名名单显示和隐藏
    ZDActivityMoreChioceTypeSuccess, // 报名成功后设置
};

typedef NS_ENUM(NSInteger, ZDActivityOptionType) {
    ZDActivityOptionTypeNone, 
    ZDActivityOptionTypeUser, // 基本信息
    ZDActivityOptionTypeExtra, // 自定义
};

NS_ASSUME_NONNULL_BEGIN

@interface ZDActivityMoreChioceModel : NSObject
@property (nonatomic, copy) NSString *headerStr;
@property (nonatomic, copy) NSString *title; // 左边标题
@property (nonatomic, copy) NSString *detailTitle; // 副标题
@property (nonatomic, assign) ZDActivityMoreChioceType moreChioceType;

@property (nonatomic, assign) BOOL isAlert;
// 用户option
@property (nonatomic, strong) NSMutableArray<ZDActivityOptionModel *> *userInfoOptionArray;
// 其他自定义option
@property (nonatomic, strong) NSMutableArray<ZDActivityOptionModel *> *extraInfoOptionArray;

@property (nonatomic, assign) ZDActivityOptionType optionType;
@property (nonatomic, assign) ZDActivityShowListType showListType;
// 分享小图
@property (nonatomic, copy) NSString *imageUrl;

+ (instancetype)imageModelWithUrl:(NSString *)url;
+ (instancetype)optionModel;
+ (instancetype)alertModel:(BOOL)isAlert;
+ (instancetype)showListModel:(NSInteger)showList;
+ (instancetype)successModel:(NSInteger)showList;

@end

NS_ASSUME_NONNULL_END
