//
//  CAShapeLayer+BezierPathCorner.h
//  zhundao
//
//  Created by zhundao on 2017/4/10.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CAShapeLayer (BezierPathCorner)
+(CAShapeLayer *)initWithFrame :(CGRect )rect WithPath :(UIBezierPath *)Path WithFillColor :(UIColor *)FillColor WithStrokeColor :(UIColor *)StrokeColor ;
@end
