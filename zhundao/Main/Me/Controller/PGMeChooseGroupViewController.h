#import "PGBaseVC.h"
typedef void(^groupblock) (NSString *groupName,NSInteger groupID);
@interface PGMeChooseGroupViewController : PGBaseVC
@property(nonatomic,copy)NSString *nameStr ;
@property(nonatomic,assign)NSInteger personid ;
@property(nonatomic,copy)groupblock block;
@end
