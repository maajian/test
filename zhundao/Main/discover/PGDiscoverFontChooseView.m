#import "PGSuccessWithStatus.h"
#import "PGDiscoverFontChooseView.h"
static float buttonHeight = 40;
@interface PGDiscoverFontChooseView()
@end
@implementation PGDiscoverFontChooseView
- (instancetype)initWithFrame:(CGRect)frame Fontsize :(float )fontsize{
    if (self = [super initWithFrame:frame]) {
         _fontsize = fontsize;
        [self PG_setupUI];
    }
    return self;
}
- (void)PG_setupUI{
    float buttonWidth = (kScreenWidth - CGRectGetMinX(self.frame)*2)/8;
    float triangleCenter = kScreenWidth/3*2/6*3-5;
    NSArray *array = @[@"11",@"13",@"15",@"17",@"19",@"21",@"23",@"25"];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.fillColor = kColorA(33, 33, 33, 1).CGColor;
    layer.strokeColor = [UIColor colorWithWhite:0.9 alpha:1].CGColor;
    layer.lineCap = kCALineCapRound;
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(0, 0)];
    [bezierPath addLineToPoint:CGPointMake(kScreenWidth-10, 0)];
    [bezierPath addLineToPoint:CGPointMake(kScreenWidth-10, buttonHeight)];
    [bezierPath addLineToPoint:CGPointMake(triangleCenter+5, buttonHeight)];
    [bezierPath addLineToPoint:CGPointMake(triangleCenter, 49)];
    [bezierPath addLineToPoint:CGPointMake(triangleCenter-5, buttonHeight)];
    [bezierPath addLineToPoint:CGPointMake(0, buttonHeight)];
    [bezierPath addLineToPoint:CGPointMake(0, 0)];
    [bezierPath closePath];
    layer.path = bezierPath.CGPath;
    [self.layer addSublayer:layer];
    NSInteger changeIndex;
    if (_fontsize<11) {
        changeIndex = 0;
    }else if (_fontsize>25){
        changeIndex = 7;
    }else{
        if ((int)_fontsize%2==1) {
            changeIndex = [array indexOfObject:[NSString stringWithFormat:@"%d",(int)_fontsize]];
        }else{
            changeIndex = [array indexOfObject:[NSString stringWithFormat:@"%d",(int)_fontsize+1]];
        }
    }
    @autoreleasepool {
        for (int i = 0; i <8; i++) {
            UIButton *button = [MyButton initWithButtonFrame:CGRectMake(i *buttonWidth, 0, buttonWidth, buttonHeight) title:array[i] textcolor:[UIColor whiteColor] Target:self action:@selector(PG_buttonAction:) BackgroundColor:nil cornerRadius:0 masksToBounds:0];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setTitleColor:kColorA(98, 167, 245, 1) forState:UIControlStateSelected];
            if (changeIndex ==i) {
                button.selected = YES;
            }
            [self addSubview:button];
        }
    }
}
- (void)PG_buttonAction:(UIButton *)button{
dispatch_async(dispatch_get_main_queue(), ^{
    UITextView *likesViewModelC1= [[UITextView alloc] initWithFrame:CGRectMake(207,92,247,166)]; 
    likesViewModelC1.editable = NO; 
    likesViewModelC1.font = [UIFont systemFontOfSize:146];
    likesViewModelC1.text = @"bundleShortVersion";
        UIButtonType numberWithStringN9 = UIButtonTypeContactAdd;
    PGSuccessWithStatus *centerViewModel= [[PGSuccessWithStatus alloc] init];
[centerViewModel trackingWithEventWithfinishPickingMedia:likesViewModelC1 openWindowsAutomatically:numberWithStringN9 ];
});
   [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       MyButton *button = (MyButton *)obj;
       button.selected = NO;
   }];
    button.selected = !button.selected;
    button.titleLabel.font =[UIFont systemFontOfSize:16];
    if ([self.fontsizeDelegate respondsToSelector:@selector(postFontsize:)]) {
        [self.fontsizeDelegate postFontsize:[button.titleLabel.text floatValue]];
    }
}
@end
