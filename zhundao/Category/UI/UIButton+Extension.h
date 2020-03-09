//
//  UIButton+Extension.h
//  zhundao
//
//  Created by maj on 2019/6/2.
//  Copyright © 2019 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSInteger, WYButtonInsetType) {
    WYButtonInsetTypeTitleTop = 0,
    WYButtonInsetTypeTitleBottom,
    WYButtonInsetTypeTitleLeft,
    WYButtonInsetTypeTitleRight,
};

@interface UIButton (Extension)
// 增加响应范围的边距宽
@property (nonatomic, assign) CGFloat addInsetWidth;
@property (nonatomic, assign) CGFloat addInsetHeight;

+ (instancetype)zd_button;

//
///**
// *  背景图片：正常
// */
//+ (UIButton *)buttonWithFrame:(CGRect)frame
//        normalBackgroundImage:(UIImage *)normalBackgroundImage
//                       target:(id)target
//                       action:(SEL)action;
/**
 *  图片：正常
 */
+ (UIButton *)buttonWithFrame:(CGRect)frame
                  normalImage:(UIImage *)normalImage
                       target:(id)target
                       action:(SEL)action;

/**
 *  图片：正常＋选中
 */
+ (UIButton *)buttonWithFrame:(CGRect)frame
                  normalImage:(UIImage *)normalImage
                selectedImage:(UIImage *)selectedImage
                       target:(id)target
                       action:(SEL)action;

/**
 *  图片：正常＋高亮
 */
+ (UIButton *)buttonWithFrame:(CGRect)frame
                  normalImage:(UIImage *)normalImage
             highlightedImage:(UIImage *)highlightedImage
                       target:(id)target
                       action:(SEL)action;

/**
 *  button : 仅文字r
 */
+ (UIButton *)buttonWithFrame:(CGRect)frame
                  normalTitle:(NSString *)normalTitle
                  normalColor:(UIColor *)normalColor
              higlightedTitle:(NSString *)higlightedTitle
              higlightedColor:(UIColor *)higlightedColor
                selectedTitle:(NSString *)selectedTitle
                selectedColor:(UIColor *)selectedColor
                       target:(id)target
                       action:(SEL)action;

/**
 *  button : 仅前景图片
 */
+ (UIButton *)buttonWithFrame:(CGRect)frame
                  normalImage:(UIImage *)normalImage
             highlightedImage:(UIImage *)highlightedImage
                selectedImage:(UIImage *)selectedImage
                       target:(id)target
                       action:(SEL)action;
/**
 *  button : 仅背景图片
 */
+ (UIButton *)buttonWithFrame:(CGRect)frame
        normalBackgroundImage:(UIImage *)normalBackgroundImage
      disabledBackgroundImage:(UIImage *)disabledBackgroundImage
                       target:(id)target
                       action:(SEL)action;

// 设置按钮和图片垂直居中
-(void)setButtonContentCenter;
- (void)setButtonWithButtonInsetType:(WYButtonInsetType)buttonInsetType space:(CGFloat)space;

@end

NS_ASSUME_NONNULL_END
