//
//  PGMeModel.h
//  zhundao
//
//  Created by maj on 2020/1/20.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, PGMeType) {
    PGMeTypeHeader,
    PGMeTypeNotice,
    PGMeTypeWallet,
    PGMeTypeMessage,
    PGMeTypeContact,
    PGMeTypeQuestion,
    PGMeTypeHonor,
    PGMeTypeZDBi,
    PGMeTypeVoucher,
    PGMeTypePromote,
    PGMeTypeSetting,
    PGMeTypePersonDataMessage,
};

NS_ASSUME_NONNULL_BEGIN

@interface PGMeModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) BOOL showRod;
@property (nonatomic, assign) PGMeType type;

+ (instancetype)headerModel;
+ (instancetype)PGMeNoticeModel;
+ (instancetype)walletModel;
+ (instancetype)messageModel;
+ (instancetype)PGMeContactModel;
+ (instancetype)questionModel;
+ (instancetype)honorModel;
+ (instancetype)zhundaobiModel;
+ (instancetype)voucherModel;
+ (instancetype)promoteModel;
+ (instancetype)settingModel;
+ (instancetype)personDataMessageModel;

@end

NS_ASSUME_NONNULL_END
