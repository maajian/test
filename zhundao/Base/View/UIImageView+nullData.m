//
//  UIImageView+nullData.m
//  zhundao
//
//  Created by zhundao on 2017/3/31.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "UIImageView+nullData.h"

@implementation UIImageView (nullData)
+ (UIImageView *)initWithFrame :(CGRect)rect  imageName:(NSString *)str
{
    UIImageView *imageview = [[ UIImageView alloc]initWithFrame:rect];
    imageview.image = [UIImage imageNamed:str];
    return  imageview;
}
@end
