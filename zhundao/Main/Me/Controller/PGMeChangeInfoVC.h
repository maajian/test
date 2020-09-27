#import "PGBaseVC.h"
typedef void(^infoBlock)(NSString *str);
@interface PGMeChangeInfoVC : PGBaseVC
@property(nonatomic,strong)NSString *oriStr;
@property(nonatomic,assign)NSInteger cellTag;
@property(nonatomic,copy)infoBlock infoBlock;
@end
