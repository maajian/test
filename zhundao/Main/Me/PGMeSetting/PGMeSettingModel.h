#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, PGMeSettingType) {
    PGMeSettingTypeAbout,
    PGMeSettingTypeChangePassword,
    PGMeSettingTypeChangeAccount,
    PGMeSettingTypeUserProtocol,
    PGMeSettingTypePrivacyProtect,
};
@interface PGMeSettingModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) PGMeSettingType type;
@property (nonatomic, assign) NSString *detailTitle;
+ (instancetype)aboutModel;
+ (instancetype)privacyProtectModel;
+ (instancetype)changePasswordModel;
+ (instancetype)userProtocolModel;
@end
NS_ASSUME_NONNULL_END
