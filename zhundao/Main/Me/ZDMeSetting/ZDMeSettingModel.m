//
//  ZDMeSettingModel.m
//  jingjing
//
//  Created by maj on 2020/8/4.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "ZDMeSettingModel.h"

@implementation ZDMeSettingModel

+ (instancetype)modelWithTitle:(NSString *)title type:(ZDMeSettingType)type {
    ZDMeSettingModel *model = [[ZDMeSettingModel alloc] init];
    model.title = title;
    model.detailTitle = @"";
    model.type = type;
    return model;
}

+ (instancetype)aboutModel {
    return [ZDMeSettingModel modelWithTitle:@"关于金塔" type:(ZDMeSettingTypeAbout)];
}
+ (instancetype)privacyProtectModel {
    return [ZDMeSettingModel modelWithTitle:@"隐私政策" type:(ZDMeSettingTypePrivacyProtect)];
}
+ (instancetype)changePasswordModel {
    return [ZDMeSettingModel modelWithTitle:@"修改密码" type:(ZDMeSettingTypeChangePassword)];
}
+ (instancetype)userProtocolModel {
    return [ZDMeSettingModel modelWithTitle:@"用户服务协议" type:(ZDMeSettingTypeUserProtocol)];
}

@end
