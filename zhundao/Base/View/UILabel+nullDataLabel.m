//
//  UILabel+nullDataLabel.m
//  zhundao
//
//  Created by zhundao on 2017/3/31.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "UILabel+nullDataLabel.h"

@implementation UILabel (nullDataLabel)
+(UILabel *)initWithFrame :(CGRect)rect WithText :(NSString *)text WithTextColor :(UIColor *)color WithFont :(UIFont *)font  WithtextAlignment :(NSTextAlignment)textAlignment
{
    UILabel *label= [[UILabel alloc]initWithFrame:rect];
    label.text = text;
    label.textColor = color;
    label.font = font;
    label.textAlignment =textAlignment;
    return label;
}
-(void)setTextColor :(UILabel *)label AndRange :(NSRange)range AndColor:(UIColor *)vaColor
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:label.text];
    [str addAttribute:NSForegroundColorAttributeName value:vaColor range:range];
    label.attributedText = str;
}

@end
