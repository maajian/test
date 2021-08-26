//
//  printView.m
//  zhundao
//
//  Created by zhundao on 2017/7/19.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "printView.h"
@interface printView()

@property(nonatomic,strong)         UITextField *tf1 ;

@property(nonatomic,strong)        UITextField *tf2 ;

@property(nonatomic,strong)        UIButton * sureButton ;

@property(nonatomic,strong)        UIView    *pushView ;


@end

static const int viewWidth = 300;
static const int viewHeight = 150;
@implementation printView


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFirstIndex :(NSInteger )index
{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(out)];
        [self addGestureRecognizer:tap];
        [self addSubview:self.pushView];
        self.tf1.text = [NSString stringWithFormat:@"%li",(long)index];
        [_tf2 becomeFirstResponder];
    }
    return self;
}


#pragma mark ------懒加载 


- (UIView *)pushView
{
    if (!_pushView) {
        _pushView  = [[UIView alloc]initWithFrame:CGRectMake(self.center.x- viewWidth/2, 50, viewWidth, viewHeight)];
        _pushView.backgroundColor = [UIColor whiteColor];
        _pushView.layer.cornerRadius = 5 ;
        _pushView.layer.masksToBounds = YES;
        [_pushView addSubview:self.tf1];
        [_pushView addSubview:self.tf2];
        [_pushView addSubview:self.sureButton];
        [self drawline];
    }
    return _pushView;
}


//划线 上移。pushView变小  tf1 变大
//- (void)drawRect:(CGRect)rect
//{
//    UIBezierPath
//}

-(UITextField *)tf1
{
   
    if (!_tf1) {
        _tf1 = [myTextField initWithFrame:CGRectMake(30, 30, 70, 40) placeholder:@"起始序号" font:[UIFont systemFontOfSize:13] TextAlignment:NSTextAlignmentCenter textColor:[UIColor blackColor]];
        _tf1.layer.cornerRadius = 5 ;
        _tf1.layer.masksToBounds = YES;
        _tf1.layer.borderColor = ZDGreenColor.CGColor;
        _tf1.layer.borderWidth = 1 ;
        _tf1.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _tf1;
}


- (UITextField *)tf2
{
    if (!_tf2) {
        _tf2 = [myTextField initWithFrame:CGRectMake(200, 30, 70, 40) placeholder:@"结束序号" font:[UIFont systemFontOfSize:13] TextAlignment:NSTextAlignmentCenter textColor:[UIColor blackColor]];
        _tf2.layer.cornerRadius = 5 ;
        _tf2.layer.masksToBounds = YES;
        _tf2.layer.borderColor = ZDGreenColor.CGColor;
        _tf2.layer.borderWidth = 1 ;
        _tf2.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _tf2;
}

- (UIButton *)sureButton
{
    if (!_sureButton) {
        _sureButton = [MyButton initWithButtonFrame:CGRectMake(115, 100, 70, 40) title:@"开始打印" textcolor:[UIColor whiteColor] Target:self action:@selector(sureAction) BackgroundColor:ZDGreenColor cornerRadius:5 masksToBounds:YES];
        _sureButton.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return _sureButton;
}
#pragma mark ---- 画直线
- (void)drawline
{
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    //指定直线样式
//    CGContextSetLineCap(context, kCGLineCapSquare);
//    //直线宽度
//    CGContextSetLineWidth(context, 2.0);
//    //设置颜色
//    CGContextSetRGBStrokeColor(context,68.f, 186.f, 37.f, 1.0);
//   //开始绘制
//    CGContextBeginPath(context);
//    //移动画笔
//    CGContextMoveToPoint(context, 120, 100);
//    //下一点
//    CGContextAddLineToPoint(context,180, 100);
//    //绘制完成
//    CGContextStrokePath(context);
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(120, 50)];
    [path addLineToPoint:CGPointMake(180, 50)];
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.strokeColor = ZDGreenColor.CGColor;
    lineLayer.lineWidth = 1.0 ;
    lineLayer.path = path.CGPath;
    [_pushView.layer addSublayer:lineLayer];
    
    
}

#pragma mark ---- 确定事件

- (void)sureAction
{
    [self endEditing:YES];
    if (_tf1.text.length==0||(_tf2.text.length==0))
    {
        [self alertText:@"输入框不能为空"];
        return;
    }
    else if ([_tf2.text integerValue]<[_tf1.text integerValue])
    {
        [self alertText:@"请注意序号大小"];
        return;
    }
    else{
         _block ([_tf1.text intValue],[_tf2.text intValue]);
        [self out];
    }
}

#pragma mark ----警告
- (void)alertText :(NSString *)text
{
    maskLabel *label = [[maskLabel alloc]initWithTitle:text];
    [label labelAnimationWithViewlong:self];
}



// 动画
- (void)comeIn
{
    self.alpha = 0.0    ;
    _pushView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:0.45 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 1.0 ;
        _pushView.transform = CGAffineTransformMakeScale(1, 1);
    } completion:nil];
}

- (void)out
{
    [self endEditing:YES];
    [UIView animateWithDuration:.35 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)dealloc
{
    DDLogVerbose(@"没有泄露");
}


@end
