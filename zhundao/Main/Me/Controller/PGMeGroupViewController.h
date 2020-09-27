#import "PGBaseVC.h"
typedef void(^deleteBlock) (BOOL isDelete);
@interface PGMeGroupViewController : PGBaseVC
@property(nonatomic,copy)deleteBlock deleteBlock;
@end
