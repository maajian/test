//
//  UITextView+BaseCreate.m
//  zhundao
//
//  Created by zhundao on 2017/4/7.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "UITextView+BaseCreate.h"

@implementation UITextView (BaseCreate)
+(instancetype)initWithFrame :(CGRect )rect WithText :(NSString *)text WithTextColor :(UIColor *)color WithFont :(UIFont *)font WithTextAlignment :(NSTextAlignment)textAlignment withisCanedit :(BOOL )isCanEdit
{
    UITextView *textview = [[UITextView alloc]initWithFrame:rect];
    textview.text = text;
    textview.textAlignment = textAlignment;
    textview.textColor = color;
    textview.font = font;
    textview.editable = isCanEdit;
    return  textview;
}
@end
