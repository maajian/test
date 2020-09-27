#import <UIKit/UIKit.h>
@interface UILabel (nullDataLabel)
+(UILabel *)initWithFrame :(CGRect)rect WithText :(NSString *)text WithTextColor :(UIColor *)color WithFont :(UIFont *)font  WithtextAlignment :(NSTextAlignment)textAlignment;
-(void)setTextColor :(UILabel *)label AndRange :(NSRange)range AndColor:(UIColor *)vaColor;
@end
