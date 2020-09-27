#import "PGBaseVC.h"
typedef void(^popBolck) (NSDictionary *popdic);
typedef void(^jiebangBlock)(BOOL  issuccess);
@interface PGDiscoverDetailShakeVC : PGBaseVC
@property(nonatomic,strong)NSDictionary *dataDic;
@property(nonatomic,copy)popBolck block;
@property(nonatomic,strong)NSString *DeviceId;
@property(nonatomic,copy)jiebangBlock jiebangBlock;
@end
