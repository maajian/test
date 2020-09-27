#import <Foundation/Foundation.h>
typedef void(^AddAccountBlock) (BOOL isSuccess);
@interface PGMeAddAccountViewModel : NSObject
- (void)AddCreadCards :(NSDictionary *)dic  AddAccountBlock:(AddAccountBlock)AddAccountBlock;
- (BOOL)isCanPost :(NSDictionary *)postdic;
@end
