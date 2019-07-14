//
//  myTextField.m
//  zhundao
//
//  Created by zhundao on 2017/4/11.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "myTextField.h"

@implementation myTextField
+(UITextField *)initWithFrame :(CGRect)rect placeholder :(NSString *)placeholder font :(UIFont *)font TextAlignment :(NSTextAlignment)TextAlignment textColor :(UIColor *)color
{
    return [[[self class]alloc]initWithFrame:rect placeholder:placeholder font:font TextAlignment:TextAlignment textColor:color];
}
- (instancetype)initWithFrame :(CGRect)rect placeholder :(NSString *)placeholder font :(UIFont *)font TextAlignment :(NSTextAlignment)TextAlignment textColor :(UIColor *)color
{
    if (self = [super init]) {
        self.frame = rect;
        self.placeholder = placeholder;
        self.font = font;
        self.textAlignment = TextAlignment;
        self.textColor =color;
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
