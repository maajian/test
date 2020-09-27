#import <UIKit/UIKit.h>
#import "PGBaseVC.h"
@interface PGSignInResultsVC : PGBaseVC<UISearchResultsUpdating>
@property (nonatomic, strong) NSArray *alldata;
@property(nonatomic,assign)NSInteger signID;
@property(nonatomic,assign)NSInteger activityID;
@end
