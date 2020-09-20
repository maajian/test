//
//  ZDMeModel.h
//  zhundao
//
//  Created by maj on 2020/1/20.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ZDMeType) {
    ZDMeTypeHeader,
    ZDMeTypeNotice,
    ZDMeTypeWallet,
    ZDMeTypeMessage,
    ZDMeTypeContact,
    ZDMeTypeQuestion,
    ZDMeTypeHonor,
    ZDMeTypeZDBi,
    ZDMeTypeVoucher,
    ZDMeTypePromote,
    ZDMeTypeSetting,
    ZDMeTypePersonDataMessage,
};

NS_ASSUME_NONNULL_BEGIN

@interface ZDMeModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) BOOL showRod;
@property (nonatomic, assign) ZDMeType type;

+ (instancetype)headerModel;
+ (instancetype)ZDMeNoticeModel;
+ (instancetype)walletModel;
+ (instancetype)messageModel;
+ (instancetype)ZDMeContactModel;
+ (instancetype)questionModel;
+ (instancetype)honorModel;
+ (instancetype)zhundaobiModel;
+ (instancetype)voucherModel;
+ (instancetype)promoteModel;
+ (instancetype)settingModel;
+ (instancetype)personDataMessageModel;

@end

NS_ASSUME_NONNULL_END
