#import "PGBaseVC.h"
typedef void(^strBlock) (NSString *backStr);
@interface PGActivityEditMoreChooseVC : PGBaseVC
@property(nonatomic,copy)NSArray *allDataArray ;
@property(nonatomic,copy)NSArray *nowDataArray ;
@property(nonatomic,assign)BOOL isMoreChoose;
@property(nonatomic,copy)strBlock strBlock;
@property(nonatomic,assign) BOOL isMust;
@end
