#import "PGWithLoadingRequest.h"
#import "PGSearchBar.h"
@interface PGSearchBar () <UITextFieldDelegate>
@property (nonatomic, assign) CGFloat placeholderWidth;
@end
static CGFloat const searchIconW = 20.0;
static CGFloat const iconSpacing = 10.0;
static CGFloat const placeHolderFont = 15.0;
@implementation PGSearchBar
- (void)layoutSubviews {
 [super layoutSubviews];
 UIImage *backImage = [UIImage imageWithColor:[UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1]];
 [self setBackgroundImage:backImage];
 for (UIView *view in [self.subviews lastObject].subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            UITextField *field = (UITextField *)view;
            field.frame = CGRectMake(15.0, 7.5, self.frame.size.width-30.0, self.frame.size.height-15.0);
            [field setBackgroundColor:[UIColor whiteColor]];
            field.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
            field.borderStyle = UITextBorderStyleNone;
            field.layer.cornerRadius = 2.0f;
            field.layer.masksToBounds = YES;
            if (@available(iOS 11.0, *)) {
                [self setPositionAdjustment:UIOffsetMake((field.frame.size.width-self.placeholderWidth)/2, 0) forSearchBarIcon:UISearchBarIconSearch];
            }
        }
     }
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(searchBarShouldBeginEditing:)]) {
     [self.delegate searchBarShouldBeginEditing:self];
    }
    if (@available(iOS 11.0, *)) {
        [self setPositionAdjustment:UIOffsetZero forSearchBarIcon:UISearchBarIconSearch];
    }
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(searchBarShouldEndEditing:)]) {
        [self.delegate searchBarShouldEndEditing:self];
     }
    if (@available(iOS 11.0, *)) {
         [self setPositionAdjustment:UIOffsetMake((textField.frame.size.width-self.placeholderWidth)/2, 0) forSearchBarIcon:UISearchBarIconSearch];
     }
    return YES;
}
- (CGFloat)placeholderWidth {
    if (!_placeholderWidth) {
        CGSize size = [self.placeholder boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:placeHolderFont]} context:nil].size;
      _placeholderWidth = size.width + iconSpacing + searchIconW;
     }
    return _placeholderWidth;
}
@end
