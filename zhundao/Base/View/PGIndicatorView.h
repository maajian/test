#import "JQIndicatorView.h"
NS_ASSUME_NONNULL_BEGIN
@interface PGIndicatorView : JQIndicatorView
+ (instancetype)shareIndicator;
+ (void)showIndicatorView:(UIView *)view;
+ (void)dismiss;
@end
NS_ASSUME_NONNULL_END
