#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, WYButtonInsetType) {
    WYButtonInsetTypeTitleTop = 0,
    WYButtonInsetTypeTitleBottom,
    WYButtonInsetTypeTitleLeft,
    WYButtonInsetTypeTitleRight,
};
@interface UIButton (Extension)
@property (nonatomic, assign) CGFloat addInsetWidth;
@property (nonatomic, assign) CGFloat addInsetHeight;
+ (instancetype)zd_button;
+ (UIButton *)buttonWithFrame:(CGRect)frame
                  normalImage:(UIImage *)normalImage
                       target:(id)target
                       action:(SEL)action;
+ (UIButton *)buttonWithFrame:(CGRect)frame
                  normalImage:(UIImage *)normalImage
                selectedImage:(UIImage *)selectedImage
                       target:(id)target
                       action:(SEL)action;
+ (UIButton *)buttonWithFrame:(CGRect)frame
                  normalImage:(UIImage *)normalImage
             highlightedImage:(UIImage *)highlightedImage
                       target:(id)target
                       action:(SEL)action;
+ (UIButton *)buttonWithFrame:(CGRect)frame
                  normalTitle:(NSString *)normalTitle
                  normalColor:(UIColor *)normalColor
              higlightedTitle:(NSString *)higlightedTitle
              higlightedColor:(UIColor *)higlightedColor
                selectedTitle:(NSString *)selectedTitle
                selectedColor:(UIColor *)selectedColor
                       target:(id)target
                       action:(SEL)action;
+ (UIButton *)buttonWithFrame:(CGRect)frame
                  normalImage:(UIImage *)normalImage
             highlightedImage:(UIImage *)highlightedImage
                selectedImage:(UIImage *)selectedImage
                       target:(id)target
                       action:(SEL)action;
+ (UIButton *)buttonWithFrame:(CGRect)frame
        normalBackgroundImage:(UIImage *)normalBackgroundImage
      disabledBackgroundImage:(UIImage *)disabledBackgroundImage
                       target:(id)target
                       action:(SEL)action;
-(void)setButtonContentCenter;
- (void)setButtonWithButtonInsetType:(WYButtonInsetType)buttonInsetType space:(CGFloat)space;
@end
NS_ASSUME_NONNULL_END
