#import "BigTextView.h"
@implementation BigTextView
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    CGRect btnBounds = self.bounds;
    btnBounds = CGRectInset(btnBounds, -30, -30);
    return CGRectContainsPoint(btnBounds, point);
}
@end
