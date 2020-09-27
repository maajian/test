#import <UIKit/UIKit.h>
#import "PGBaseVC.h"
typedef void(^block)(NSInteger signNum);
typedef void(^signBlock)(BOOL isRed);
@interface PGSignInLoadAllSignVC : PGBaseVC
@property(nonatomic,copy)block block;
@property(nonatomic,assign)NSInteger signID;
@property(nonatomic,copy)signBlock signBlock;
@property(nonatomic,copy)NSString *signName;
@property(nonatomic,assign)NSInteger signNumber;
@property(nonatomic,assign)NSInteger activityID;
- (void)loadData;
@end
