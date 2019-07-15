
//
//  UIBarButtonItem+Extension.m
//  zhundao
//
//  Created by maj on 2019/5/25.
//  Copyright © 2019 zhundao. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

#pragma mark --- 图片
/**
 *  返回
 */
+ (UIBarButtonItem *)backImageItemWithTarget:(id)target action:(SEL)action {
    return [UIBarButtonItem imageBarButtonItemWithNormalImage:@"nav_back"
                                                renderingMode:UIImageRenderingModeAlwaysTemplate highlightedImageName:@"nav_back"
                                             seletedImageName:nil
                                                       Target:target
                                                       action:action
                                             equalToImageSize:NO];
}
/**
 *  添加
 */
+ (UIBarButtonItem *)addWhiteImageItemWithTarget:(id)target action:(SEL)action {
    return [UIBarButtonItem imageBarButtonItemWithNormalImage:@"com_add"
                                                renderingMode:UIImageRenderingModeAlwaysTemplate highlightedImageName:@"com_add"
                                             seletedImageName:nil
                                                       Target:target
                                                       action:action
                                             equalToImageSize:NO];
}
+ (UIBarButtonItem *)activityAddItemWithTarget:(id)target action:(SEL)action {
    return [UIBarButtonItem imageBarButtonItemWithNormalImage:@"com_add"
                                                renderingMode:UIImageRenderingModeAlwaysTemplate highlightedImageName:@"com_add"
                                             seletedImageName:nil
                                                       Target:target
                                                       action:action
                                             equalToImageSize:NO];
}
+ (UIBarButtonItem *)scanItemWithTarget:(id)target action:(SEL)action {
    return [UIBarButtonItem imageBarButtonItemWithNormalImage:@"sign_scan"
                                                renderingMode:UIImageRenderingModeAlwaysTemplate
                                         highlightedImageName:nil
                                             seletedImageName:nil
                                                       Target:target
                                                       action:action
                                             equalToImageSize:NO];
}


#pragma mark --- 文本
/**
 *  保存
 */
+ (UIBarButtonItem *)saveTextItemWithTarget:(id)target action:(SEL)action {
    return [UIBarButtonItem textBarButtonItemWithText:@"保存"
                                               color:zhundaoGreenColor
                                               Target:target
                                               action:action];
}

#pragma mark - 全能方法

/**
 *  导航条按钮：图片
 *
 *  @param normalImageName      正常图片
 *  @param highlightedImageName 高亮图片
 *  @param target               目标
 *  @param action               行为
 *  @param equalToImageSize     是否和图片一样大，NO－（20，20）
 *
 */
+ (UIBarButtonItem *)imageBarButtonItemWithNormalImage:(NSString *)normalImageName renderingMode:(UIImageRenderingMode)mode
                                  highlightedImageName:(NSString *)highlightedImageName
                                      seletedImageName:(nullable NSString *)selectedImageName
                                                Target:(id)target
                                                action:(SEL)action
                                      equalToImageSize:(BOOL)equalToImageSize {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *normalImage = [UIImage imageNamed:normalImageName];
    btn.frame = normalImage && equalToImageSize && normalImage.size.width > 32 ? CGRectMake(0, 0, normalImage.size.width, normalImage.size.height) :CGRectMake(0, 0, 32, 44);
    btn.accessibilityIdentifier = normalImageName;
    if (normalImageName) [btn setImage:[[UIImage imageNamed:normalImageName] imageWithRenderingMode:mode] forState:UIControlStateNormal];
    if (highlightedImageName) [btn setImage:[UIImage imageNamed:highlightedImageName] forState:UIControlStateHighlighted];
    if (selectedImageName) [btn setImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
    if (target && action) [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
}

/**
 *  导航条按钮：文本
 *
 *  @param text   按钮文本
 *  @param target 目标
 *  @param action 行为
 *
 */
+ (UIBarButtonItem *)textBarButtonItemWithText:(NSString *)text
                                         color:(UIColor *)color
                                        Target:(id)target
                                        action:(SEL)action {
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:text
                                                            style:UIBarButtonItemStylePlain
                                                           target:target
                                                           action:action];
    NSDictionary *normalDic = @{ NSForegroundColorAttributeName: color,
                                 NSFontAttributeName: [UIFont systemFontOfSize:17] };
    [bar setTitleTextAttributes:normalDic forState:UIControlStateNormal];
    return bar;
}

@end
