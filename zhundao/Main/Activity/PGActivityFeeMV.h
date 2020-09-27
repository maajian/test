#import <Foundation/Foundation.h>
typedef void(^feeBlock) (NSInteger isChange);
@interface PGActivityFeeMV : NSObject
@property(nonatomic,copy)feeBlock feeBlock;
- (void)netWorkWithID:(NSInteger)feeID;
- (void)sortData:(NSMutableArray *)array;
@end
