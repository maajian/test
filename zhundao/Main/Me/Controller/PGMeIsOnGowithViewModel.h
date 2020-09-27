#import <Foundation/Foundation.h>
typedef void(^isonGowithBlock)(NSString *success);
@interface PGMeIsOnGowithViewModel : NSObject
- (void)Withdraw :(NSString *)amount
       accountId :(NSInteger)accountId
  isonGowithBlock:(isonGowithBlock)isonGowithBlock;
@end
