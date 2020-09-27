#import <UIKit/UIKit.h>
@interface MyButton : UIButton
+(UIButton *)initWithButtonFrame:(CGRect)frame title
                              :(NSString *)title
                        textcolor:(UIColor *)textColor
                        Target:(id)target
                        action:(SEL)action
               BackgroundColor:(UIColor *)BackgroundColor
                  cornerRadius:(CGFloat)cornerRadius
                 masksToBounds:(BOOL)masksToBounds
                     ;
@end
