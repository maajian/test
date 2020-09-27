#ifndef LMStyleSettings_h
#define LMStyleSettings_h
static NSString * const LMStyleSettingsBoldName = @"bold";
static NSString * const LMStyleSettingsItalicName = @"italic";
static NSString * const LMStyleSettingsUnderlineName = @"underline";
static NSString * const LMStyleSettingsFontSizeName = @"fontSize";
static NSString * const LMStyleSettingsTextColorName = @"textColor";
static NSString * const LMStyleSettingsFormatName = @"format";
@protocol PGStyleSettings <NSObject>
- (void)lm_didChangeStyleSettings:(NSDictionary *)settings;
@end
#endif 
