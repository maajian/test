#import <Foundation/Foundation.h>
typedef void(^backpopBlock) (NSArray *backArray);
@interface PGSignInOnePersonDataNetWork : NSObject
- (void)getNewList :(NSInteger)listID BackBlock :(backpopBlock)backBlock ;
@end
