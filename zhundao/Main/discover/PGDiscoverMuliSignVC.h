#import "PGSaoYiSaoViewController.h"
typedef void(^signStatusBlock) (NSInteger signStatus,FMResultSet * rs);
typedef void(^haveNetBlock) (NSInteger signStatus,NSDictionary  *dic);
@interface PGDiscoverMuliSignVC : PGSaoYiSaoViewController
@property(nonatomic,copy)signStatusBlock signStatusBlock;
@property(nonatomic,copy)haveNetBlock haveNetBlock;
@property (nonatomic, copy) NSString *acckey;
@end
