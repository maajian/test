//
//  MyLabel.m
//  zhundao
//
//  Created by zhundao on 2017/2/22.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "MyLabel.h"

@implementation MyLabel
+(UILabel *)initWithLabelFrame:(CGRect)frame Text : (NSString *)text textColor :(UIColor *)textColor font :(UIFont *)font textAlignment : (NSTextAlignment )textAlignment cornerRadius :(float)cornerRadius masksToBounds:(BOOL)masksToBounds

{
    return  [[self alloc]initWithLabelFrame:frame Text:text textColor:textColor font:font textAlignment:textAlignment cornerRadius:cornerRadius masksToBounds:masksToBounds];
}
 - (instancetype)initWithLabelFrame:(CGRect)frame Text : (NSString *)text textColor :(UIColor *)textColor font :(UIFont *)font textAlignment : (NSTextAlignment )textAlignment cornerRadius :(float)cornerRadius masksToBounds:(BOOL)masksToBounds
{
             self = [super init];
                 if (self) {
                     self.frame = frame;
                     self.text = text;
                     self.textAlignment = textAlignment;
                     self.textColor = textColor;
                     self.font = font;
                     self.layer.cornerRadius = cornerRadius;
                     self.layer.masksToBounds = masksToBounds;
                     [self setUp];
                 }
    return self;
}

- (UILabel *)initWithFrame :(CGRect)frame Text : (NSString *)text textColor :(UIColor *)textColor font :(UIFont *)font
{
    MyLabel *label = [[MyLabel alloc]init];
    label.font = font;
    label.frame = frame ;
    label.textColor = textColor;
    label.text = text;
    return label;
}
- (void)setUp
{
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress)]];
}
- (void)longPress
{
    [self becomeFirstResponder];
    UIMenuController *menu = [UIMenuController sharedMenuController];
    UIMenuItem *item1 = [[UIMenuItem alloc]initWithTitle:@"拷贝" action:@selector(myCopy:)];
    menu.menuItems =@[item1];
    [menu setTargetRect:self.bounds inView:self];
    [menu setMenuVisible:YES];
}
- (BOOL)canBecomeFirstResponder
{
    return YES;
}
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(myCopy:)) {
        return YES;
    }else{
        return  NO;
    }
}
- (void)myCopy:(UIMenuController *)menu
{
    //当没有文字的时候调用这个方法会崩溃
    if (!self.text) return;
    //复制文字到剪切板
    UIPasteboard * paste = [UIPasteboard generalPasteboard];
    paste.string = self.text;
    
}
@end
