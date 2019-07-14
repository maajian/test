//
//  UIImage+Extension.m
//  zhundao
//
//  Created by maj on 2019/7/7.
//  Copyright © 2019 zhundao. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

//  颜色转换为背景图片
+ (nullable UIImage *)imageWithColor:(nullable UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
