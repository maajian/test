#import <Foundation/Foundation.h>
@interface PGLoginInfoEditViewModel : NSObject
- (void)loginWirhCode:(NSString *)code phoneStr:(NSString *)phoneStr name:(NSString *)name passWord:(NSString *)passWord  successBlock:(kZDCommonSucc)successBlock failBlock:(kZDCommonFail)failBlock;
@end
