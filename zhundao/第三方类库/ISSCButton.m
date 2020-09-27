#import "ISSCButton.h"
#import <QuartzCore/QuartzCore.h>
@implementation ISSCButton
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.borderWidth = 1.0f;
        self.layer.cornerRadius = 8.0f;
        [self setTitleColor:[UIColor colorWithRed:94.0f/255.0f green:155.0f/255.0f blue:215.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        self.layer.shadowOpacity = 0.5f;
        self.layer.shadowRadius = 1.0f;
        self.layer.masksToBounds = NO;
        [self setBackgroundColor:[UIColor whiteColor]];
        self.layer.shouldRasterize = YES;
        self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.borderColor = [UIColor grayColor].CGColor;
    self.layer.borderWidth = 1.0f;
    self.layer.cornerRadius = 8.0f;
    [self setTitleColor:[UIColor colorWithRed:94.0f/255.0f green:155.0f/255.0f blue:215.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    self.layer.shadowOpacity = 0.5f;
    self.layer.shadowRadius = 1.0f;
    self.layer.masksToBounds = NO;
    [self setBackgroundColor:[UIColor whiteColor]];
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}
@end
