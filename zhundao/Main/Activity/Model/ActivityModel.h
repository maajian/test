//
//  ActivityModel.h
//  zhundao
//
//  Created by zhundao on 2016/12/6.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ZDActivityADType) {
    ZDActivityADTypeNone = -1,
    ZDActivityADTypeImage = 0,
    ZDActivityADTypeLink = 1,
};

@class ZDActivityConfigModel;
@interface ActivityModel : NSObject

@property(nonatomic,copy)NSString *Title;
@property(nonatomic,copy)NSString *Content;
@property(nonatomic,copy)NSString *Address;
@property(nonatomic,copy)NSString *ShareImgurl;
@property(nonatomic,copy)NSString *TimeStart;
@property(nonatomic,copy)NSString *TimeStop;
@property(nonatomic,copy)NSString *EndTime;
@property(nonatomic,copy)NSString *StartTime;
@property(nonatomic,assign)float Amount;
@property(nonatomic,assign)NSInteger Status;
@property(nonatomic,assign)NSInteger UserLimit;
@property(nonatomic,assign)NSInteger HasJoinNum;
@property(nonatomic,assign)NSInteger ID;
@property(nonatomic,assign)NSInteger ClickNo;
@property(nonatomic,strong)NSArray *ActivityFees;
@property(nonatomic,assign)NSInteger Alert;
@property(nonatomic,copy)NSString *BackImgurl;
@property(nonatomic,copy)NSString *ExtraUserInfo;
@property (nonatomic, copy) NSString *Config;
@property (nonatomic, strong) ZDActivityConfigModel *configModel;
@property(nonatomic,copy)NSString *UserInfo;
@property(nonatomic,assign)NSInteger Fee;
@property(nonatomic,assign)NSInteger HideInfo;
//@property(nonatomic,assign)NSInteger iD;
@property(nonatomic,assign)NSInteger UserID;
@property(nonatomic,assign)double Lat;
@property(nonatomic,assign)double Lng;
@property (nonatomic, assign) NSInteger MinPeople;
@property (nonatomic, assign) NSInteger MaxPeople;
/*! 是否为团体报名 */
@property(nonatomic,assign)NSInteger ActivityGenre;
@end

@class ZDActivityADModel;
@class ZDActivityConfigUserInfoModel;
@interface ZDActivityConfigModel : NSObject
@property (nonatomic, assign) BOOL VerifyPhone;
@property (nonatomic, assign) BOOL OpenInvioce;
@property (nonatomic, assign) BOOL share;
@property (nonatomic, assign) BOOL PhoneStrict;
@property (nonatomic, assign) BOOL FaceImgIfNull;
@property (nonatomic, assign) BOOL EmailIfNull;
@property (nonatomic, assign) BOOL RewardFlag;

@property (nonatomic, assign) NSInteger IsTourist;
@property (nonatomic, assign) NSInteger JoinModel;
@property (nonatomic, assign) NSInteger MinPeople;
@property (nonatomic, assign) NSInteger MaxPeople;
@property (nonatomic, assign) NSInteger shareObject;

@property (nonatomic, copy)  NSString *shareBtnName;
@property (nonatomic, copy) NSString *queryBtnName;
//@property (nonatomic, copy) NSString *ad;

@property (nonatomic, strong) ZDActivityADModel *ad;
@property (nonatomic, strong) ZDActivityConfigUserInfoModel *userInfo;
@end

@interface ZDActivityADModel : NSObject
@property (nonatomic, assign) ZDActivityADType adtype;
@property (nonatomic, copy) NSString *adurl;
@property (nonatomic, copy) NSString *adimg;

@end

@interface ZDActivityConfigUserInfoModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *value;
@property (nonatomic, copy) NSString *cn;

@property (nonatomic, assign) BOOL select;
@property (nonatomic, assign) BOOL require;

@end
