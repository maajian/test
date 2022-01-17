//
//  ZDSupplierMeModel.h
//  zhundao
//
//  Created by maj on 2021/9/2.
//  Copyright © 2021 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZDSupplierMeModel : NSObject<NSCoding>
@property (nonatomic, copy) NSString *company; // 公司
@property (nonatomic, copy) NSString *admin_name; // 名称
//@property (nonatomic, copy) NSString *business_license; // 头像

@property (nonatomic, copy) NSString *access_token; // 会务公司使用的token
@property (nonatomic, copy) NSString *headImg; // 头像
@property (nonatomic, copy) NSString *duty; // 职务
- (instancetype)initWithConferenceDic:(NSDictionary *)dic;
- (instancetype)initWithConferenceInfoDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
