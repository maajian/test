#import "PGBottomViewDelegate.h"
#import "NewView.h"
#import "AppDelegate.h"
@interface NewView()
{
    UILabel *label;
}
@end
@implementation NewView
- (instancetype)initWithTitle:(NSString *)str
{
    self = [super init];
    if (self) {
        [self createLabel];
        label.text = str;
        [self createImage];
        self.alpha = 0.8;
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}
- (void)createLabel
{
    label = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-180, 120, 120, 40)];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:17];
    label.backgroundColor = [UIColor blackColor];
    label.layer.cornerRadius = 20;
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.masksToBounds = YES;
    label.layer.borderColor = [[UIColor whiteColor]CGColor];
    label.layer.borderWidth = 1;
    [self addSubview:label];
}
- (void)createImage
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-80, 70, 60, 40)];
    imageView.image = [UIImage imageNamed:@"fx_my_attention_guide_arrow"];
    [self addSubview:imageView];
}
@end
