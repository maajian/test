#import "PGBaseVC.h"
typedef void(^backBlock1) (NSArray *array);
@interface PGActivityFeeViewController : PGBaseVC
@property(nonatomic,copy)backBlock1 block;
@property(nonatomic,copy)NSArray *feeArray ;
@end
