//
//  UIColor+Extension.h
//  zhundao
//
//  Created by maj on 2019/5/26.
//  Copyright © 2019 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Extension)

+ (UIColor *)colorFromHexCode:(NSString *)hexString;

+ (UIColor *)ZDBlueNormalColor;
+ (UIColor *)ZDBluePressColor;
+ (UIColor *)ZDBlueDisableColor;

+ (UIColor *)ZDRedNormalColor;
+ (UIColor *)ZDRedPressColor;
+ (UIColor *)ZDRedDisableColor;

+ (UIColor *)ZDGreenNormalColor;
+ (UIColor *)ZDGreenPressColor;
+ (UIColor *)ZDGreenDisableColor;

@end

NS_ASSUME_NONNULL_END
