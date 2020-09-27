#import <UIKit/UIKit.h>
#import "PGBaseVC.h"
@interface PGActivityListVC : PGBaseVC
@property(nonatomic,copy)NSString *listName;
@property(nonatomic,assign)NSInteger listID;
@property(nonatomic,copy)NSArray *feeArray;
@property(nonatomic,copy)NSString *userInfo;
@property(nonatomic,assign)NSInteger HasJoinNum;
@property(nonatomic,copy)NSString *timeStart;
@property(nonatomic,copy)NSString *address;
- (void)loadData ;
@end
