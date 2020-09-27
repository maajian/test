#import "UITextField+TextLeftOffset_ffset.h"
@implementation UITextField (TextLeftOffset_ffset)
 - (void)setTextOffsetWithLeftViewRect : (CGRect)rect WithMode :(UITextFieldViewMode)mode
{
    UIView *view = [[UIView alloc]initWithFrame:rect];
    self.leftView = view;
    self.leftViewMode = mode; 
}
@end
