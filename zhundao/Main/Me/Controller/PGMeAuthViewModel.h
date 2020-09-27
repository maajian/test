#import <Foundation/Foundation.h>
typedef void(^authBlock) (BOOL isSuccess);
@interface PGMeAuthViewModel : NSObject
- (void)postAuthentication :(NSDictionary *)dic authBlock :(authBlock)authBlock;
- (void)GetAuthorInfo;
@end
