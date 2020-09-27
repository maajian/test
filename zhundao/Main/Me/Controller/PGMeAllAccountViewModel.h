#import <Foundation/Foundation.h>
#import "NSObject+block.h"
typedef void(^allAccountBlock) (BOOL isSuccess,NSArray *Array);
@interface PGMeAllAccountViewModel : NSObject
- (void)GetCreditCards :(allAccountBlock)allAccountBlock;
- (void)deleteCreadCard :(NSInteger)ID successBlock:(ZDSuccessBlock)successBlock;
@end
