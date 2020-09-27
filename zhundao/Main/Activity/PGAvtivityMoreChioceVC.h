#import "PGBaseVC.h"
typedef void(^BackBlock) (NSDictionary *dic,NSString *smallStr,BOOL isPost);
@interface PGAvtivityMoreChioceVC : PGBaseVC
@property(nonatomic,strong)NSArray *optionsArray;
@property(nonatomic,copy)BackBlock block;
@property(nonatomic,strong)NSDictionary  *datadic;
@property(nonatomic,strong)NSString *imageStr;
@property(nonatomic,assign)BOOL isSmallPost;
@end
