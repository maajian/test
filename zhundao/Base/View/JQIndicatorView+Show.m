#import "JQIndicatorView+Show.h"
@implementation JQIndicatorView (Show)
- (JQIndicatorView *)showWithView :(UIView *)view
{
  JQIndicatorView  *indicator = [[JQIndicatorView alloc]initWithType:3 tintColor: [UIColor colorWithRed:9.00f/255.0f green:187.00f/255.0f blue:7.00f/255.0f alpha:1] size:CGSizeMake(90, 70)];
    indicator.center = view.center;
    [view addSubview:indicator];
    [indicator startAnimating];
    return indicator;
}
@end
