#import "PGCachingImageManager.h"
#import "PGActivityAMapTipAnnotation.h"
@interface PGActivityAMapTipAnnotation()
@property (nonatomic, readwrite, strong) AMapTip *tip;
@end
@implementation PGActivityAMapTipAnnotation
- (NSString *)title
{
    return self.tip.name;
}
- (NSString *)subtitle
{
    return self.tip.address;
}
- (CLLocationCoordinate2D)coordinate
{
    return CLLocationCoordinate2DMake(self.tip.location.latitude, self.tip.location.longitude);
}
- (instancetype)initWithMapTip:(AMapTip *)tip
{
    self = [super init];
    if (self)
    {
        self.tip = tip;
    }
    return self;
}
@end
