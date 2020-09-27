#import <UIKit/UIKit.h>
#import "PGMacro.h"
NS_ASSUME_NONNULL_BEGIN
@interface PGSignAlertView : UIView
+ (instancetype)alertWithTitle:(NSString *)title titleColor:(UIColor *)titleColor messageTitle:(NSString *)messageTitle cancelTitle:(NSString *)cancelTitle sureTitle:(NSString *)sureTitle cancelBlock:(ZDBlock_Void)cancelBlock sureBlock:(ZDBlock_Void)sureBlock;
@property (nonatomic, assign) NSTextAlignment messageAlignment;
@end
NS_ASSUME_NONNULL_END
