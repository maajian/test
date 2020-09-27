#import "PGBaseVC.h"
typedef void(^selectBlock) (NSString *address);
typedef void(^latblock)(double latitude,double longitude);
@interface PGActivityMapVC : PGBaseVC
@property(nonatomic,copy)selectBlock block;
@property(nonatomic,copy)latblock latblock;
@property(nonatomic,assign)double latitude;
@property(nonatomic,assign)double longitude;
@end
