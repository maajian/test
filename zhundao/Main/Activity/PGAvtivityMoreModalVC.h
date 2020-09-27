#import "PGBaseVC.h"
typedef void(^backBlock) (NSInteger backNumber);
@interface PGAvtivityMoreModalVC : PGBaseVC
@property(nonatomic,copy)backBlock backBlock;
@property(nonatomic,strong)ActivityModel *moreModel;
@end
