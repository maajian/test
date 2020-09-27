#import <Foundation/Foundation.h>
#import "NSObject+block.h"
#import "PGMeMoreAccountModel.h"
@interface PGMeMoreAccountViewModel : NSObject
@property (nonatomic, strong) NSMutableArray<PGMeMoreAccountModel *> *userArray;
- (void)getListData:(dispatch_block_t)successBlock;
- (void)didLogout;
@end
