//
//  PGMeSettingModel.m
//  jingjing
//
//  Created by maj on 2020/8/4.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "PGMeSettingModel.h"

@implementation PGMeSettingModel

+ (instancetype)modelWithTitle:(NSString *)title type:(PGMeSettingType)type {
    PGMeSettingModel *model = [[PGMeSettingModel alloc] init];
    model.title = title;
    model.detailTitle = @"";
    model.type = type;
    return model;
}

+ (instancetype)aboutModel {
    return [PGMeSettingModel modelWithTitle:@"关于金塔" type:(PGMeSettingTypeAbout)];
}
+ (instancetype)privacyProtectModel {
    return [PGMeSettingModel modelWithTitle:@"隐私政策" type:(PGMeSettingTypePrivacyProtect)];
}
+ (instancetype)changePasswordModel {
    return [PGMeSettingModel modelWithTitle:@"修改密码" type:(PGMeSettingTypeChangePassword)];
}
+ (instancetype)userProtocolModel {
    return [PGMeSettingModel modelWithTitle:@"用户服务协议" type:(PGMeSettingTypeUserProtocol)];
}

@end
