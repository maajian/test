#import "UITextField+textCenter.h"
@implementation UITextField (textCenter)
- (void)initWithString :(NSString *)placeholder font :(UIFont *)font
{
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    style.minimumLineHeight =font.lineHeight - (font.lineHeight - [UIFont systemFontOfSize:13].lineHeight) / 2.0;
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder];
    [self setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:placeholder attributes:@{NSFontAttributeName :font,NSParagraphStyleAttributeName : style}]];
}
@end
