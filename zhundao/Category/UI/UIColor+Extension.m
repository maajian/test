//
//  UIColor+Extension.m
//  zhundao
//
//  Created by maj on 2019/5/26.
//  Copyright © 2019 zhundao. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)

+ (UIColor *)colorFromHexCode:(NSString *)hexString {
    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if ([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)], [cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)], [cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)], [cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if ([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    float red = ((baseValue >> 24) & 0xFF) / 255.0f;
    float green = ((baseValue >> 16) & 0xFF) / 255.0f;
    float blue = ((baseValue >> 8) & 0xFF) / 255.0f;
    float alpha = ((baseValue >> 0) & 0xFF) / 255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *)ZDBlueNormalColor {
    return [UIColor colorFromHexCode:@"576b96"];
}
+ (UIColor *)ZDBluePressColor {
    return [[UIColor colorFromHexCode:@"576b96"] colorWithAlphaComponent:0.2];
}
+ (UIColor *)ZDBlueDisableColor {
    return [[UIColor colorFromHexCode:@"576b96"] colorWithAlphaComponent:0.1];
}

+ (UIColor *)ZDRedNormalColor {
    return [UIColor colorFromHexCode:@"e64340"];
}
+ (UIColor *)ZDRedPressColor {
    return [[UIColor colorFromHexCode:@"e64340"] colorWithAlphaComponent:0.2];
}
+ (UIColor *)ZDRedDisableColor {
    return [[UIColor colorFromHexCode:@"e64340"] colorWithAlphaComponent:0.1];
}

+ (UIColor *)ZDGreenNormalColor {
    return [UIColor colorFromHexCode:@"09bb07"];
}
+ (UIColor *)ZDGreenPressColor {
    return [[UIColor colorFromHexCode:@"09bb07"] colorWithAlphaComponent:0.2];
}
+ (UIColor *)ZDGreenDisableColor {
    return [[UIColor colorFromHexCode:@"09bb07"] colorWithAlphaComponent:0.1];
}

@end
