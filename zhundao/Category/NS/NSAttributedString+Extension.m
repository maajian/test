//
//  NSAttributedString+Extension.m
//  zhundao
//
//  Created by maj on 2020/12/7.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "NSAttributedString+Extension.h"

@implementation NSAttributedString (Extension)

+ (instancetype)defaultAttributedStringWithString:(NSString *)string
                                        fontColor:(UIColor *)fontColor
                                             font:(UIFont *)font {
    return [self attributedStringWithString:string
                                  fontColor:fontColor
                                       font:font
                                lineSpacing:4
                                kernSpacing:0.3
                              lineBreakMode:NSLineBreakByWordWrapping
                                  alignment:NSTextAlignmentLeft];
}
+ (instancetype)defaultAttributedStringWithString:(NSString *)string
                                        fontColor:(UIColor *)fontColor
                                             font:(UIFont *)font
                                        alignment:(NSTextAlignment)alignment {
    return [self attributedStringWithString:string
                                  fontColor:fontColor
                                       font:font
                                lineSpacing:4
                                kernSpacing:0.3
                              lineBreakMode:NSLineBreakByWordWrapping
                                  alignment:alignment];
}
+ (instancetype)attributedStringWithString:(NSString *)string
                                 fontColor:(UIColor *)fontColor
                                      font:(UIFont *)font
                               lineSpacing:(CGFloat)lineSpacing
                               kernSpacing:(CGFloat)kernSpacing
                             lineBreakMode:(NSLineBreakMode)lineBreakMode
                                 alignment:(NSTextAlignment)alignment {
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange range = NSMakeRange(0, str.length);
    if (fontColor) {
        [str addAttribute:NSForegroundColorAttributeName value:fontColor range:range];
    }
    if (font) {
        [str addAttribute:NSFontAttributeName value:font range:range];
    }
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = lineBreakMode;
    style.lineSpacing = lineSpacing;
    style.alignment = alignment;
    [str addAttribute:NSParagraphStyleAttributeName value:style range:range];
    [str addAttribute:NSKernAttributeName value:@(kernSpacing) range:range];
    return str;
}

@end
