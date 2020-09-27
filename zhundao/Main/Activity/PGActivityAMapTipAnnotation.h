#import <Foundation/Foundation.h>
#import <AMapSearchKit/AMapCommonObj.h>
#import <MAMapKit/MAMapKit.h>
@interface PGActivityAMapTipAnnotation : NSObject <MAAnnotation>
- (instancetype)initWithMapTip:(AMapTip *)tip;
@property (nonatomic, readonly, strong) AMapTip *tip;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
- (NSString *)title;
- (NSString *)subtitle;
@end
