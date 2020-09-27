#import <Foundation/Foundation.h>
#import "NSObject+block.h"
@interface PGMeChangeInfoViewModel : NSObject
- (void)UpdateUserInfo :(NSDictionary *)dic
          successBlock :(ZDSuccessBlock)successBlock
            errorBlock : (ZDErrorBlock)errorBlock;
- (void)getUserInfo:(ZDSuccessBlock)successBlock
        errorBlock : (ZDErrorBlock)errorBlock;
@end
