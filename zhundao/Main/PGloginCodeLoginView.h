#import <UIKit/UIKit.h>
@protocol CodeLoginViewDelegate<NSObject>
- (void)backLogin;
- (void)PGloginCodeLoginView:(UIView *)PGloginCodeLoginView phoneStr:(NSString *)phoneStr;
- (void)goCodeWeb;
- (void)loginWithPhoneStr:(NSString *)phoneStr code:(NSString *)code;
@end
@interface PGloginCodeLoginView : UIView
@property (nonatomic, weak) id<CodeLoginViewDelegate> codeLoginViewDelegate;
@end
