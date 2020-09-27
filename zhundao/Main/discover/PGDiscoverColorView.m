#import "PGSuccessWithStatus.h"
#import "PGDiscoverColorView.h"
const static CGFloat buttonWidth = 20;
@interface PGDiscoverColorView()
@property(nonatomic,assign) NSInteger oriIndex ;
@property(nonatomic,copy)   NSArray *colorArray;
@property(nonatomic,strong) UIColor *currentColor;
@end
@implementation PGDiscoverColorView
- (instancetype)initWithColor :(UIColor *)originColor{
    if (self = [super init]) {
        if ([self.colorArray containsObject:originColor]) {
            _oriIndex = [self.colorArray indexOfObject:originColor]+100;
        }else{
            _oriIndex = 108;
        }
        _currentColor = originColor;
        [self PG_setupUI];
        [self addObserver:self forKeyPath:@"currentColor" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    }
    return self;
}
- (NSArray *)colorArray{
    if (!_colorArray) {
        _colorArray = @[kColorA(249, 249, 249, 1),
                        kColorA(43, 43, 43, 1),
                        kColorA(255, 29, 19, 1),
                        kColorA(251, 246, 4, 1),
                        kColorA(21, 226, 20, 1),
                        kColorA(26, 155, 255, 1),
                        kColorA(140, 45, 255, 1),
                        kColorA(248, 51, 255, 1)];
    }
    return _colorArray;
}
- (void)PG_setupUI{
    @autoreleasepool {
        for (int i = 0 ; i<9; i++) {
            UIButton *button;
            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            if (i==8) {
               button = [MyButton initWithButtonFrame:CGRectMake(230, 40, 20, 20) title:nil textcolor:nil Target:self action:@selector(buttonAction:) BackgroundColor:kColorA(249, 249, 249, 1) cornerRadius:buttonWidth/2 masksToBounds:1];
                shapeLayer.fillColor = _currentColor.CGColor;
            }else{
                button = [MyButton initWithButtonFrame:CGRectMake(15 + (buttonWidth+15)*i, 5, 20, 20) title:nil textcolor:nil Target:self action:@selector(buttonAction:) BackgroundColor:kColorA(249, 249, 249, 1) cornerRadius:buttonWidth/2 masksToBounds:1];
                UIColor *color =(UIColor *)_colorArray[i];
                shapeLayer.fillColor = color.CGColor;
            }
            CGFloat insideOvalDia = 16;
            UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(2, 2, insideOvalDia, insideOvalDia)];
            shapeLayer.path = path.CGPath;
            [button.layer addSublayer:shapeLayer];
            [self addSubview:button];
            button.tag = 100+i;
            if (button.tag == _oriIndex&&i!=8) {
                [UIView animateWithDuration:0.1 animations:^{
                    button.transform = CGAffineTransformScale(button.transform, 1.4, 1.4);
                }];
            }
        }
    };
        CAShapeLayer *layer = [CAShapeLayer layer];
        UIBezierPath *path = [UIBezierPath bezierPath];
        layer.strokeColor =  ZDLineColor.CGColor;
        layer.lineWidth = 2;
        layer.lineCap = kCALineCapRound;
        [path moveToPoint:CGPointMake(15, 60)];
        [path addLineToPoint:CGPointMake(65, 60)];
        [path moveToPoint:CGPointMake(95, 60)];
        [path addLineToPoint:CGPointMake(145, 60)];
        [path moveToPoint:CGPointMake(175, 60)];
        [path addLineToPoint:CGPointMake(225, 60)];
         layer.path = path.CGPath;
        [self.layer addSublayer:layer];
    const CGFloat *components = CGColorGetComponents(_currentColor.CGColor);
    NSArray *placeholderAray = @[@"R",@"G",@"B"];
    for (int i = 0; i<3; i++) {
        UITextField *textf = [myTextField initWithFrame:CGRectMake(80*i, 25, 80, 35) placeholder:placeholderAray[i] font:[UIFont systemFontOfSize:12] TextAlignment:NSTextAlignmentCenter textColor:[UIColor whiteColor]];
        textf.keyboardType = UIKeyboardTypeDecimalPad;
        textf.tag = 1000 +i;
        [textf addTarget:self action:@selector(PG_textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [textf addTarget:self action:@selector(PG_textFieldDidEndChange:) forControlEvents:UIControlEventEditingDidEnd];
        textf.text = [NSString stringWithFormat:@"%.1f",components[i]*256];
        [self addSubview:textf];
    }
}
#pragma mark --- 颜色按钮点击事件
- (void)buttonAction : (UIButton *)button
{
    if (_oriIndex == button.tag) {
        return;
    }
    if (button.tag!=8) {
        self.currentColor = [_colorArray objectAtIndex:button.tag-100];
        [self PG_changeColor];
    }else{
        return;
    }
    UIButton *oriButton =(UIButton *)[self viewWithTag:_oriIndex];
    [UIView animateWithDuration:0.1 animations:^{
        oriButton.transform = CGAffineTransformIdentity;
        button.transform = CGAffineTransformScale(button.transform, 1.4, 1.4);
    }];
    _oriIndex = button.tag;
    [_colorDelegate colorViewCurrrentColor:_currentColor];
}
- (void)PG_changeColor{
    UIButton *showButton = [self viewWithTag:108];
    for (CALayer *layer in showButton.layer.sublayers) {
        if ([layer isKindOfClass:[CAShapeLayer class]]) {
            CAShapeLayer *shapeLayer = (CAShapeLayer *)layer;
            shapeLayer.fillColor = _currentColor.CGColor ;
        }
    }
}
#pragma mark --- 输入框编辑事件
- (void)PG_textFieldDidChange:(UITextField *)textField{
    if ([textField.text floatValue]>256) {
        textField.text = @"256.0";
    }
    if ([textField.text componentsSeparatedByString:@"."].count==2) {
        NSString *secondStr =[textField.text componentsSeparatedByString:@"."].lastObject;
        if (secondStr.length>2) {
            secondStr = [secondStr substringToIndex:1];
            textField.text = [[[textField.text componentsSeparatedByString:@"."].firstObject stringByAppendingString:@"."]stringByAppendingString:secondStr];
        }
    }
}
- (void)PG_textFieldDidEndChange:(UITextField *)textField{
    switch (textField.tag) {
        case 1000:{
            UITextField *textf1 = [self viewWithTag:1001];
            UITextField *textf2 = [self viewWithTag:1002];
            self.currentColor = kColorA([textField.text floatValue], [textf1.text floatValue], [textf2.text floatValue], 1);
        }
            break;
        case 1001:{
            UITextField *textf1 = [self viewWithTag:1000];
            UITextField *textf2 = [self viewWithTag:1002];
            NSLog(@"%f",[textf1.text floatValue]);
            NSLog(@"%f",[textf2.text floatValue]);
            self.currentColor = kColorA([textf1.text floatValue], [textField.text floatValue], [textf2.text floatValue], 1);
        }
            break;
        case 1002:{
            UITextField *textf1 = [self viewWithTag:1000];
            UITextField *textf2 = [self viewWithTag:1001];
            self.currentColor = kColorA([textf1.text floatValue], [textf2.text floatValue], [textField.text floatValue], 1);
        }
            break;
        default:
            break;
    }
    [self PG_changeColor];
    [self PG_identityButton];
    [_colorDelegate colorViewCurrrentColor:_currentColor];
}
#pragma mark---颜色改变不再数组内，按钮还原
- (void)PG_identityButton{
dispatch_async(dispatch_get_main_queue(), ^{
    UITextView *assetReferenceRestrictionf7= [[UITextView alloc] initWithFrame:CGRectMake(244,255,96,107)]; 
    assetReferenceRestrictionf7.editable = NO; 
    assetReferenceRestrictionf7.font = [UIFont systemFontOfSize:21];
    assetReferenceRestrictionf7.text = @"baseViewController";
        UIButtonType integralMainDatao2 = UIButtonTypeContactAdd;
    PGSuccessWithStatus *routeSearchBase= [[PGSuccessWithStatus alloc] init];
[routeSearchBase trackingWithEventWithfinishPickingMedia:assetReferenceRestrictionf7 openWindowsAutomatically:integralMainDatao2 ];
});
    [_colorArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIColor *color = (UIColor *)obj;
        if (CGColorEqualToColor(color.CGColor , _currentColor.CGColor)) {
            *stop = YES;
        }
        if (idx ==_colorArray.count-1) {
            UIButton *button = [self viewWithTag:_oriIndex];
            [UIView animateWithDuration:0.1 animations:^{
                button.transform = CGAffineTransformIdentity;
            }];
        }
    }];
}
#pragma mark ---触发kvo
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    UIColor  *newColor = [change objectForKey:NSKeyValueChangeNewKey];
    const CGFloat *compoments = CGColorGetComponents(newColor.CGColor);
    for (int i =0; i <3; i++) {
         UITextField *textf = [self viewWithTag:1000+i];
        textf.text = [NSString stringWithFormat:@"%.1f",compoments[i]*256];
    }
}
- (void)dealloc{
    [self removeObserver:self forKeyPath:@"currentColor"];
}
@end
