#import "PGMeSettingModel.h"
@implementation PGMeSettingModel
+ (instancetype)PG_modelWithTitle:(NSString *)title type:(PGMeSettingType)type {
    PGMeSettingModel *model = [[PGMeSettingModel alloc] init];
    model.title = title;
    model.detailTitle = @"";
    model.type = type;
    return model;
}
+ (instancetype)aboutModel {
    return [PGMeSettingModel PG_modelWithTitle:@"关于金塔" type:(PGMeSettingTypeAbout)];
}
+ (instancetype)privacyProtectModel {
    return [PGMeSettingModel PG_modelWithTitle:@"隐私政策" type:(PGMeSettingTypePrivacyProtect)];
}
+ (instancetype)changePasswordModel {
    return [PGMeSettingModel PG_modelWithTitle:@"修改密码" type:(PGMeSettingTypeChangePassword)];
}
+ (instancetype)userProtocolModel {
    return [PGMeSettingModel PG_modelWithTitle:@"用户服务协议" type:(PGMeSettingTypeUserProtocol)];
}
@end
