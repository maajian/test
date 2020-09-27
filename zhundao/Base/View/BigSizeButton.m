#import "BigSizeButton.h"
@implementation BigSizeButton
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
        CGRect btnBounds = self.bounds;
        btnBounds = CGRectInset(btnBounds, -30, -30);
        return CGRectContainsPoint(btnBounds, point);
}
@end
