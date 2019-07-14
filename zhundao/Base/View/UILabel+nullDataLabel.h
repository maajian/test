//
//  UILabel+nullDataLabel.h
//  zhundao
//
//  Created by zhundao on 2017/3/31.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (nullDataLabel)


+(UILabel *)initWithFrame :(CGRect)rect WithText :(NSString *)text WithTextColor :(UIColor *)color WithFont :(UIFont *)font  WithtextAlignment :(NSTextAlignment)textAlignment;

-(void)setTextColor :(UILabel *)label AndRange :(NSRange)range AndColor:(UIColor *)vaColor;
@end
