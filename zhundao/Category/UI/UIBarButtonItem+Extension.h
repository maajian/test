#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface UIBarButtonItem (Extension)
#pragma mark --- 图片
+ (UIBarButtonItem *)backImageItemWithTarget:(id)target action:(SEL)action;
+ (UIBarButtonItem *)addWhiteImageItemWithTarget:(id)target action:(SEL)action;
+ (UIBarButtonItem *)activityAddItemWithTarget:(id)target action:(SEL)action;
+ (UIBarButtonItem *)scanItemWithTarget:(id)target action:(SEL)action;
+ (UIBarButtonItem *)shareItemWithTarget:(id)target action:(SEL)action;
+ (UIBarButtonItem *)moreItemWithTarget:(id)target action:(SEL)action;
#pragma mark --- 文字
+ (UIBarButtonItem *)saveTextItemWithTarget:(id)target action:(SEL)action ;
@end
NS_ASSUME_NONNULL_END
