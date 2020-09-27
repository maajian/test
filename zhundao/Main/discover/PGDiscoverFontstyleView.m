#import "PGModelWithAsset.h"
#import "PGDiscoverFontstyleView.h"
static float buttonHeight = 40;
@interface PGDiscoverFontstyleView()
@end
@implementation PGDiscoverFontstyleView
- (instancetype)initWithFrame:(CGRect)frame fontstyle :(NSString * )fontstyle{
    if (self = [super initWithFrame:frame]) {
        [self PG_setupUI];
        _foneName = fontstyle;
    }
    return self;
}
- (void)PG_setupUI{
    float buttonWidth = (kScreenWidth - CGRectGetMinX(self.frame)*2)/6;
    float triangleCenter = kScreenWidth/3*2/6*5-5;
    float viewWidth = CGRectGetWidth(self.frame);
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.fillColor = kColorA(33, 33, 33, 1).CGColor;
    layer.strokeColor = [UIColor colorWithWhite:0.9 alpha:1].CGColor;
    layer.lineCap = kCALineCapRound;
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(0, 0)];
    [bezierPath addLineToPoint:CGPointMake(viewWidth, 0)];
    [bezierPath addLineToPoint:CGPointMake(viewWidth, buttonHeight)];
    [bezierPath addLineToPoint:CGPointMake(triangleCenter+5, buttonHeight)];
    [bezierPath addLineToPoint:CGPointMake(triangleCenter, buttonHeight +9)];
    [bezierPath addLineToPoint:CGPointMake(triangleCenter-5, buttonHeight)];
    [bezierPath addLineToPoint:CGPointMake(0, buttonHeight)];
    [bezierPath addLineToPoint:CGPointMake(0, 0)];
    [bezierPath closePath];
    layer.path = bezierPath.CGPath;
    [self.layer addSublayer:layer];
    @autoreleasepool {
        for (int i = 0; i <8; i++) {
            UIButton *button = [MyButton initWithButtonFrame:CGRectMake(i *buttonWidth, 0, buttonWidth, buttonHeight) title:nil textcolor:[UIColor whiteColor] Target:self action:@selector(PG_buttonAction:) BackgroundColor:nil cornerRadius:0 masksToBounds:0];
            [self addSubview:button];
        }
    }
}
- (void)PG_buttonAction:(UIButton *)button{
    _foneName = @"Verdana-Italic";
    if ([self.fontstyleDelegate respondsToSelector:@selector(postFontstyle:)]) {
        [self.fontstyleDelegate postFontstyle:_foneName];
    }
}
@end
