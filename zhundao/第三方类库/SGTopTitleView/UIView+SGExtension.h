#import <UIKit/UIKit.h>
@interface UIView (SGExtension)
@property (nonatomic ,assign) CGFloat SG_x;
@property (nonatomic ,assign) CGFloat SG_y;
@property (nonatomic ,assign) CGFloat SG_width;
@property (nonatomic ,assign) CGFloat SG_height;
@property (nonatomic ,assign) CGFloat SG_centerX;
@property (nonatomic ,assign) CGFloat SG_centerY;
@property (nonatomic ,assign) CGSize SG_size;
@property (nonatomic, assign) CGFloat SG_right;
@property (nonatomic, assign) CGFloat SG_bottom;
+ (instancetype)SG_viewFromXib;
@end
