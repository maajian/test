#import "PGIndicatorView.h"
@implementation PGIndicatorView
+ (instancetype)shareIndicator {
    static PGIndicatorView *indicator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        indicator = [[PGIndicatorView alloc]initWithType:3 tintColor: [UIColor colorWithRed:9.00f/255.0f green:187.00f/255.0f blue:7.00f/255.0f alpha:1] size:CGSizeMake(90, 70)];
    });
    return indicator;
}
+ (void)showIndicatorView:(UIView *)view {
    [PGIndicatorView shareIndicator].center = view.center;
    [view addSubview:[PGIndicatorView shareIndicator]];
    [[PGIndicatorView shareIndicator] startAnimating];
}
+ (void)dismiss {
    [[PGIndicatorView shareIndicator] stopAnimating];
}
@end
