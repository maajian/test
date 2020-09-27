#import "CALayer+nullLine.h"
@implementation CALayer (nullLine)
- (void)setBorderColorFromUIColor:(UIColor *)color
{
    self.borderColor = color.CGColor;
}
@end
