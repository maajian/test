#import <UIKit/UIKit.h>
@interface PGloginCodeLoginViewModel : UIView
@property (nonatomic, strong) NSDictionary *sendCodeJson;
- (void)sendCode:(NSString *)phoneStr successBlock:(kZDCommonSucc)successBlock failBlock:(kZDCommonFail)failBlock;
- (void)loginWirhCode:(NSString *)code phoneStr:(NSString *)phoneStr successBlock:(kZDCommonSucc)successBlock failBlock:(kZDCommonFail)failBlock ;
@end
