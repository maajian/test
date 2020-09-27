#import "UITextView+BaseCreate.h"
@implementation UITextView (BaseCreate)
+(instancetype)initWithFrame :(CGRect )rect WithText :(NSString *)text WithTextColor :(UIColor *)color WithFont :(UIFont *)font WithTextAlignment :(NSTextAlignment)textAlignment withisCanedit :(BOOL )isCanEdit
{
    UITextView *textview = [[UITextView alloc]initWithFrame:rect];
    textview.text = text;
    textview.textAlignment = textAlignment;
    textview.textColor = color;
    textview.font = font;
    textview.editable = isCanEdit;
    return  textview;
}
@end
