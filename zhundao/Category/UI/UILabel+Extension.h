//
//  UILabel+Extension.h
//  zhundao
//
//  Created by maj on 2019/7/6.
//  Copyright © 2019 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Extension)
+ (instancetype)zd_new;
+ (UILabel *)labelWithFrame:(CGRect)frame
                  textColor:(UIColor *)textColor
                       font:(UIFont *)font
              numberOfLines:(NSInteger)numberOfLines
              lineBreakMode:(NSLineBreakMode)mode
              lineAlignment:(NSTextAlignment)alignment;

+ (UILabel *)labelWithFrame:(CGRect)frame
                       text:(NSString *)text
                  textColor:(UIColor *)textColor
                   textfont:(UIFont *)textFont
              numberOfLines:(NSInteger)numberOfLines
              lineBreakMode:(NSLineBreakMode)mode
              lineAlignment:(NSTextAlignment)alignment
                  lineSpace:(CGFloat)lineSpace
                  sizeToFit:(BOOL)sizeToFit;

+ (UILabel *)labelWithFrame:(CGRect)frame
                       text:(NSString *)text
                  textColor:(UIColor *)textColor
                   textfont:(UIFont *)textFont
              numberOfLines:(NSInteger)numberOfLines
              lineBreakMode:(NSLineBreakMode)mode
              lineAlignment:(NSTextAlignment)alignment
                  sizeToFit:(BOOL)sizeToFit;

@end

NS_ASSUME_NONNULL_END
