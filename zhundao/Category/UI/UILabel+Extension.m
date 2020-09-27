#import "UILabel+Extension.h"
@implementation UILabel (Extension)
+ (instancetype)zd_new {
    UILabel *label = [UILabel new];
    label.numberOfLines = 0;
    return label;
}
+ (UILabel *)labelWithFrame:(CGRect)frame
                  textColor:(UIColor *)textColor
                       font:(UIFont *)font
              numberOfLines:(NSInteger)numberOfLines
              lineBreakMode:(NSLineBreakMode)mode
              lineAlignment:(NSTextAlignment)alignment {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    if (textColor) {
        label.textColor = textColor;
    }
    if (font) {
        label.font = font;
    }
    label.numberOfLines = numberOfLines;
    label.lineBreakMode = mode;
    label.textAlignment = alignment;
    return label;
}
+ (UILabel *)labelWithFrame:(CGRect)frame
                       text:(NSString *)text
                  textColor:(UIColor *)textColor
                   textfont:(UIFont *)textFont
              numberOfLines:(NSInteger)numberOfLines
              lineBreakMode:(NSLineBreakMode)mode
              lineAlignment:(NSTextAlignment)alignment
                  sizeToFit:(BOOL)sizeToFit {
    return [self labelWithFrame:frame
                           text:text
                      textColor:textColor
                       textfont:textFont
                  numberOfLines:numberOfLines
                  lineBreakMode:mode
                  lineAlignment:alignment
                      lineSpace:4
                      sizeToFit:sizeToFit];
}
+ (UILabel *)labelWithFrame:(CGRect)frame
                       text:(NSString *)text
                  textColor:(UIColor *)textColor
                   textfont:(UIFont *)textFont
              numberOfLines:(NSInteger)numberOfLines
              lineBreakMode:(NSLineBreakMode)mode
              lineAlignment:(NSTextAlignment)alignment
                  lineSpace:(CGFloat)lineSpace
                  sizeToFit:(BOOL)sizeToFit {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.textColor = textColor;
    label.font = textFont;
    label.numberOfLines = numberOfLines;
    label.lineBreakMode = mode;
    label.textAlignment = alignment;
    if (text) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:lineSpace];
        [paragraphStyle setLineBreakMode:mode];
        [paragraphStyle setAlignment:alignment];
        NSMutableAttributedString *attriDes = [[NSMutableAttributedString alloc] initWithString:label.text];
        [attriDes addAttributes:@{ NSForegroundColorAttributeName: textColor,
                                   NSFontAttributeName: textFont,
                                   NSParagraphStyleAttributeName: paragraphStyle }
                          range:NSMakeRange(0, label.text.length)];
        [label setAttributedText:attriDes];
    }
    if (sizeToFit) {
        [label sizeToFit];
    }
    return label;
}
@end
