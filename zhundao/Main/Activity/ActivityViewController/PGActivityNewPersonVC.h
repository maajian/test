#import "PGBaseVC.h"
typedef void(^fleshBlock) (BOOL isSuccess);
@interface PGActivityNewPersonVC : PGBaseVC
@property(nonatomic,copy)fleshBlock fleshBlock;
@property(nonatomic,assign)NSInteger activityID;   
@property(nonatomic,copy)NSArray *feeArray;
@property(nonatomic,copy)NSString *userInfo;
@end
