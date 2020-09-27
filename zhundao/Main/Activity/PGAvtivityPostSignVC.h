#import "PGBaseVC.h"
typedef void(^bacBlock) (BOOL ischange);
typedef void(^deleteBlock)(BOOL isDelete);
typedef void(^postBlock) (BOOL isSuccess);
@interface PGAvtivityPostSignVC : PGBaseVC
@property(nonatomic,strong)NSString *activityName;
@property(nonatomic,assign)NSInteger acID;
@property(nonatomic,strong)NSArray *dataArray1;  
@property(nonatomic,assign)NSInteger selectIndex; 
@property(nonatomic,assign)NSInteger signID;
@end
