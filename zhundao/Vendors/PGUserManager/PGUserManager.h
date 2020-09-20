//
//  PGUserManager.h
//  zhundao
//
//  Created by maj on 2019/7/15.
//  Copyright © 2019 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define ZD_UserM [PGUserManager shareManager]

@interface PGUserManager : NSObject

+ (instancetype)shareManager;

@property (nonatomic, assign) NSInteger userID;
@property (nonatomic, assign) CGFloat balance;
@property (nonatomic, assign) CGFloat factorageRate;
@property (nonatomic, assign) NSInteger gradeId;
@property (nonatomic, assign) BOOL hasPayPassWord;
@property (nonatomic, assign) NSInteger userSex;

@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *company;
@property (nonatomic, copy) NSString *duty;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *headImgUrl;
@property (nonatomic, copy) NSString *idCard;
@property (nonatomic, copy) NSString *industry;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *openid;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *trueName;

#pragma mark --- 扩展
// 是否显示过隐私
@property (nonatomic, assign) BOOL hasShowPrivacy;
// 登录信息是否过期
@property (nonatomic, assign) BOOL loginExpired;

@property (nonatomic, assign) BOOL isAdmin; // 是否管理员 ， 否则就是数据员
// token
@property (nonatomic, copy) NSString *token;
// 登录的账号
@property (nonatomic, copy) NSString *loginAccount;

 
#pragma mark --- public
- (void)initWithDic:(NSDictionary *)dic;

// 保存登录时间
- (void)saveLoginTime;

// 判断本地是否有签到
- (BOOL)hasLocalSign:(NSInteger)signID;
// 标记本地有签到
- (void)markLocalSign:(NSInteger)signID;
// 移除本地签到标记
- (void)removeLocalSign:(NSInteger)signID;

/*! 退出登录清空数据 */
- (void)didLogout;

@end

NS_ASSUME_NONNULL_END
