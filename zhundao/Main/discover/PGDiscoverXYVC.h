#import "PGBaseVC.h"
@protocol XYdelegate <NSObject>
- (void)backWithX :(NSString * )offsetx y :(NSString *)offsety;
@end
@interface PGDiscoverXYVC : PGBaseVC
@property(nonatomic,weak) id<XYdelegate> delegate ;
@end
