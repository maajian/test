#import <Foundation/Foundation.h>
@interface PGloginMainViewModel : NSObject
+ (void)getTokenByAccount:(NSString *)phoneStr passWord:(NSString *)password ;
+ (void)getTokenByWechat:(NSString *)code;
@end
