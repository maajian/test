#import "PGServiceAlertView.h"
NS_ASSUME_NONNULL_BEGIN
@interface PGServiceAlertView (ZDAdd)
+ (instancetype)privacyAlertWithDelegate:(id)delegate;
+ (instancetype)privacyNeedCheckAlertWithDelegate:(id)delegate;
@end
NS_ASSUME_NONNULL_END
