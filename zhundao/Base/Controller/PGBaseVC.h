#import <UIKit/UIKit.h>
@interface PGBaseVC : UIViewController
@property(nonatomic,strong)UILabel *nulllabel;
@property(nonatomic,strong)UIImageView *nullimageview;
- (void)backAction:(UIButton *)button;
- (UIImageView *)showNullImage;
- (UILabel *)showNullLabelWithText :(NSString *)text WithTextColor :(UIColor *)color;
- (void)shownull :(NSArray *)nullArray WithText :(NSString *)text WithTextColor :(UIColor *)Color;
@end
