//
//  CAShapeLayer+BezierPathCorner.m
//  zhundao
//
//  Created by zhundao on 2017/4/10.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "CAShapeLayer+BezierPathCorner.h"

@implementation CAShapeLayer (BezierPathCorner)
+(CAShapeLayer *)initWithFrame :(CGRect )rect WithPath :(UIBezierPath *)Path WithFillColor :(UIColor *)FillColor WithStrokeColor :(UIColor *)StrokeColor
{
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = Path.CGPath;
    layer.fillColor = FillColor.CGColor;
    layer.strokeColor = StrokeColor.CGColor;
    layer.lineWidth = 1.0f;
    layer.frame = rect;
    return layer;
}
@end
