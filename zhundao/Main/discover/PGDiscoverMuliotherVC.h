#import "PGOtherSignViewController.h"
typedef void(^signStatusBlock) (NSInteger signStatus,FMResultSet * rs);
typedef void(^haveNetBlock) (NSInteger signStatus,NSDictionary  *dic);
@interface PGDiscoverMuliotherVC : PGOtherSignViewController
@property(nonatomic,copy)signStatusBlock signStatusBlock;
@property(nonatomic,copy)haveNetBlock haveNetBlock;
@property (nonatomic, copy) NSString *acckey;
@end
