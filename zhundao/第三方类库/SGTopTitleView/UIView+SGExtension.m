#import "UIView+SGExtension.h"
@implementation UIView (SGExtension)
- (void)setSG_x:(CGFloat)SG_x{
    CGRect frame = self.frame;
    frame.origin.x = SG_x;
    self.frame = frame;
}
- (void)setSG_y:(CGFloat)SG_y{
    CGRect frame = self.frame;
    frame.origin.y = SG_y;
    self.frame = frame;
}
- (void)setSG_width:(CGFloat)SG_width{
    CGRect frame = self.frame;
    frame.size.width = SG_width;
    self.frame = frame;
}
- (void)setSG_height:(CGFloat)SG_height{
    CGRect frame = self.frame;
    frame.size.height = SG_height;
    self.frame = frame;
}
- (CGFloat)SG_x{
    return self.frame.origin.x;
}
- (CGFloat)SG_y{
    return self.frame.origin.y;
}
- (CGFloat)SG_width{
    return self.frame.size.width;
}
- (CGFloat)SG_height{
    return self.frame.size.height;
}
- (CGFloat)SG_centerX{
    return self.center.x;
}
- (void)setSG_centerX:(CGFloat)SG_centerX{
    CGPoint center = self.center;
    center.x = SG_centerX;
    self.center = center;
}
- (CGFloat)SG_centerY{
    return self.center.y;
}
- (void)setSG_centerY:(CGFloat)SG_centerY{
    CGPoint center = self.center;
    center.y = SG_centerY;
    self.center = center;
}
- (void)setSG_size:(CGSize)SG_size{
    CGRect frame = self.frame;
    frame.size = SG_size;
    self.frame = frame;
}
- (CGSize)SG_size{
    return self.frame.size;
}
- (CGFloat)SG_right{
    return CGRectGetMaxX(self.frame);
}
- (CGFloat)SG_bottom{
    return CGRectGetMaxY(self.frame);
}
- (void)setSG_right:(CGFloat)SG_right{
    self.SG_x = SG_right - self.SG_width;
}
- (void)setSG_bottom:(CGFloat)SG_bottom{
    self.SG_y = SG_bottom - self.SG_height;
}
+ (instancetype)SG_viewFromXib {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}
@end
