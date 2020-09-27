#import "UIButton+Extension.h"
@implementation UIButton (Extension)
+ (instancetype)zd_button {
    return [UIButton buttonWithType:UIButtonTypeCustom];
}
+ (UIButton *)buttonWithFrame:(CGRect)frame
        normalBackgroundImage:(UIImage *)normalBackgroundImage
      disabledBackgroundImage:(UIImage *)disabledBackgroundImage
                       target:(id)target
                       action:(SEL)action {
    return [self buttonWithFrame:frame
           normalBackgroundImage:normalBackgroundImage
      highlightedBackgroundImage:nil
         selectedBackgroundImage:nil
         disabledBackgroundImage:disabledBackgroundImage
                          target:target
                          action:action];
}
+ (UIButton *)buttonWithFrame:(CGRect)frame
                  normalImage:(UIImage *)normalImage
                       target:(id)target
                       action:(SEL)action {
    return [self buttonWithFrame:frame
                     normalImage:normalImage
                highlightedImage:nil
                   selectedImage:nil
                          target:target
                          action:action];
}
+ (UIButton *)buttonWithFrame:(CGRect)frame
                  normalImage:(UIImage *)normalImage
                selectedImage:(UIImage *)selectedImage
                       target:(id)target
                       action:(SEL)action {
    return [self buttonWithFrame:frame
                     normalImage:normalImage
                highlightedImage:nil
                   selectedImage:selectedImage
                          target:target
                          action:action];
}
+ (UIButton *)buttonWithFrame:(CGRect)frame
                  normalImage:(UIImage *)normalImage
             highlightedImage:(UIImage *)highlightedImage
                       target:(id)target
                       action:(SEL)action {
    return [self buttonWithFrame:frame
                     normalImage:normalImage
                highlightedImage:highlightedImage
                   selectedImage:nil
                          target:target
                          action:action];
}
#pragma mark - 私有
+ (UIButton *)buttonWithFrame:(CGRect)frame
                  normalTitle:(NSString *)normalTitle
                  normalColor:(UIColor *)normalColor
              higlightedTitle:(NSString *)higlightedTitle
              higlightedColor:(UIColor *)higlightedColor
                selectedTitle:(NSString *)selectedTitle
                selectedColor:(UIColor *)selectedColor
                       target:(id)target
                       action:(SEL)action {
    return [self buttonWithFrame:frame
                     normalTitle:normalTitle
                     normalColor:normalColor
                 higlightedTitle:higlightedTitle
                 higlightedColor:higlightedColor
                   selectedTitle:selectedTitle
                   selectedColor:selectedColor
                     normalImage:nil
                highlightedImage:nil
                   selectedImage:nil
           normalBackgroundImage:nil
      highlightedBackgroundImage:nil
         selectedBackgroundImage:nil
         disabledBackgroundImage:nil
                          target:target
                          action:action];
}
+ (UIButton *)buttonWithFrame:(CGRect)frame
                  normalImage:(UIImage *)normalImage
             highlightedImage:(UIImage *)highlightedImage
                selectedImage:(UIImage *)selectedImage
                       target:(id)target
                       action:(SEL)action {
    return [self buttonWithFrame:frame
                     normalTitle:nil
                     normalColor:nil
                 higlightedTitle:nil
                 higlightedColor:nil
                   selectedTitle:nil
                   selectedColor:nil
                     normalImage:normalImage
                highlightedImage:highlightedImage
                   selectedImage:selectedImage
           normalBackgroundImage:nil
      highlightedBackgroundImage:nil
         selectedBackgroundImage:nil
         disabledBackgroundImage:nil
                          target:target
                          action:action];
}
+ (UIButton *) buttonWithFrame:(CGRect)frame
         normalBackgroundImage:(UIImage *)normalBackgroundImage
    highlightedBackgroundImage:(UIImage *)highlightedBackgroundImage
       selectedBackgroundImage:(UIImage *)selectedBackgroundImage
       disabledBackgroundImage:(UIImage *)disabledBackgroundImage
                        target:(id)target
                        action:(SEL)action {
    return [self buttonWithFrame:frame
                     normalTitle:nil
                     normalColor:nil
                 higlightedTitle:nil
                 higlightedColor:nil
                   selectedTitle:nil
                   selectedColor:nil
                     normalImage:nil
                highlightedImage:nil
                   selectedImage:nil
           normalBackgroundImage:normalBackgroundImage
      highlightedBackgroundImage:highlightedBackgroundImage
         selectedBackgroundImage:selectedBackgroundImage
         disabledBackgroundImage:disabledBackgroundImage
                          target:target
                          action:action];
}
+ (UIButton *) buttonWithFrame:(CGRect)frame
                   normalTitle:(NSString *)normalTitle
                   normalColor:(UIColor *)normalColor
               higlightedTitle:(NSString *)higlightedTitle
               higlightedColor:(UIColor *)higlightedColor
                 selectedTitle:(NSString *)selectedTitle
                 selectedColor:(UIColor *)selectedColor
                   normalImage:(UIImage *)normalImage
              highlightedImage:(UIImage *)highlightedImage
                 selectedImage:(UIImage *)selectedImage
         normalBackgroundImage:(UIImage *)normalBackgroundImage
    highlightedBackgroundImage:(UIImage *)highlightedBackgroundImage
       selectedBackgroundImage:(UIImage *)selectedBackgroundImage
       disabledBackgroundImage:(UIImage *)disabledBackgroundImage
                        target:(id)target
                        action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    if (normalTitle) {
        [btn setTitle:normalTitle forState:UIControlStateNormal];
    }
    if (normalColor) {
        [btn setTitleColor:normalColor forState:UIControlStateNormal];
    }
    if (higlightedTitle) {
        [btn setTitle:higlightedTitle forState:UIControlStateHighlighted];
    }
    if (higlightedColor) {
        [btn setTitleColor:higlightedColor forState:UIControlStateHighlighted];
    }
    if (selectedTitle) {
        [btn setTitle:selectedTitle forState:UIControlStateSelected];
    }
    if (selectedColor) {
        [btn setTitleColor:selectedColor forState:UIControlStateSelected];
    }
    if (normalTitle) {
        [btn setTitle:normalTitle forState:UIControlStateNormal];
    }
    if (normalImage) {
        [btn setImage:normalImage forState:UIControlStateNormal];
    }
    if (highlightedImage) {
        [btn setImage:highlightedImage forState:UIControlStateHighlighted];
    }
    if (selectedImage) {
        [btn setImage:selectedImage forState:UIControlStateSelected];
    }
    if (normalBackgroundImage) {
        [btn setBackgroundImage:normalBackgroundImage forState:UIControlStateNormal];
    }
    if (highlightedBackgroundImage) {
        [btn setBackgroundImage:highlightedBackgroundImage forState:UIControlStateHighlighted];
    }
    if (selectedBackgroundImage) {
        [btn setBackgroundImage:selectedBackgroundImage forState:UIControlStateSelected];
    }
    if (disabledBackgroundImage) {
        [btn setBackgroundImage:disabledBackgroundImage forState:UIControlStateDisabled];
    }
    if (target && action) {
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return btn;
}
-(void)setButtonContentCenter {
    [self setImageEdgeInsets:UIEdgeInsetsMake(-self.titleLabel.intrinsicContentSize.height, 0, 0, -self.titleLabel.intrinsicContentSize.width)];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(self.currentImage.size.height + 20, -self.currentImage.size.width, 0, 0)];
}
#pragma mark --- 点击范围扩大
- (CGFloat)addInsetWidth {
    return [objc_getAssociatedObject(self, @selector(addInsetWidth)) floatValue];
}
- (void)setAddInsetWidth:(CGFloat)addInsetWidth {
    objc_setAssociatedObject(self, @selector(addInsetWidth), [NSNumber numberWithFloat:addInsetWidth], OBJC_ASSOCIATION_RETAIN);
}
- (CGFloat)addInsetHeight {
    return [objc_getAssociatedObject(self, @selector(addInsetHeight)) floatValue];
}
- (void)setAddInsetHeight:(CGFloat)addInsetHeight {
    objc_setAssociatedObject(self, @selector(addInsetHeight), [NSNumber numberWithFloat:addInsetHeight], OBJC_ASSOCIATION_RETAIN);
}
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect bounds = self.bounds;
    if (self.addInsetWidth || self.addInsetHeight) {
        bounds = CGRectInset(bounds, -self.addInsetWidth, -self.addInsetHeight);
    }
    return CGRectContainsPoint(bounds, point);
}
- (void)setButtonWithButtonInsetType:(WYButtonInsetType)buttonInsetType space:(CGFloat)space {
    CGSize imageSize = self.imageView.size;
    CGSize titleSize = self.titleLabel.size;
    switch (buttonInsetType) {
        case WYButtonInsetTypeTitleTop: {
            self.imageEdgeInsets = UIEdgeInsetsMake(imageSize.height/2 , titleSize.width/2 , -imageSize.height/2, -titleSize.width/2);
            self.titleEdgeInsets = UIEdgeInsetsMake(-titleSize.height/2 - space, - imageSize.width/2, titleSize.height/2 + space,  imageSize.width/2);
        }
            break;
        case WYButtonInsetTypeTitleLeft: {
            self.imageEdgeInsets = UIEdgeInsetsMake(0, imageSize.width/2 + titleSize.width/2 + space/2 , 0, - space/2 - imageSize.width/2 - titleSize.width/2);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -space/2 - titleSize.width/2 - space/2, 0, titleSize.width/2 + space/2 + imageSize.width/2);
        }
            break;
        case WYButtonInsetTypeTitleRight: {
            self.imageEdgeInsets = UIEdgeInsetsMake(0, space/2, 0, -space/2);
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -space/2, 0, space/2);
        }
            break;
        case WYButtonInsetTypeTitleBottom: {
            self.imageEdgeInsets = UIEdgeInsetsMake(-titleSize.height/2 , titleSize.width/2, titleSize.height/2, -titleSize.width/2);
            NSLog(@"imageEdgeInsets = %@", NSStringFromUIEdgeInsets(self.imageEdgeInsets));
            self.titleEdgeInsets = UIEdgeInsetsMake(imageSize.height/2 + space , -imageSize.width/2, - imageSize.height/2 - space ,  imageSize.width/2);
        }
            break;
        default:
            break;
    }
}
@end
