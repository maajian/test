#import "PGBaseVC.h"
@interface PGActivityEditSignListVC : PGBaseVC
@property(nonatomic,assign)NSInteger activityID;   
@property(nonatomic,assign)NSInteger personID;
@property(nonatomic,copy)NSString *dataStr;  
@property(nonatomic,strong)NSArray *baseArray;  
@property(nonatomic,strong)NSArray *baseNameArray; 
@end
