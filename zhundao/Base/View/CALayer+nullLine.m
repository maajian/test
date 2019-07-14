//
//  CALayer+nullLine.m
//  zhundao
//
//  Created by zhundao on 2017/5/3.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "CALayer+nullLine.h"

@implementation CALayer (nullLine)
- (void)setBorderColorFromUIColor:(UIColor *)color
{
    self.borderColor = color.CGColor;
}
@end
