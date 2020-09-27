#import "UIButton+UIButton_RightNav.h"
@implementation UIButton (UIButton_RightNav)
+(instancetype)initCreateButtonWithFrame:(CGRect)frame WithImageName:(NSString *)imageName Withtarget:(UIViewController *)target Selector:(SEL)selector
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    UIView *containVew = [[UIView alloc] initWithFrame:button.bounds];
    [containVew addSubview:button];
    UIBarButtonItem *rightItem1 = [[UIBarButtonItem alloc]initWithCustomView:containVew];
    target.navigationItem.rightBarButtonItem = rightItem1;
    return button;
}
@end
