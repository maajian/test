#import <UIKit/UIKit.h>
@interface PGActivityJPullEmailTF : UITextField
@property (assign, nonatomic) CGFloat mLeftMargin;
@property (assign, nonatomic) CGRect mailListframe;
@property (assign, nonatomic) CGFloat mailListHeight;
@property (assign, nonatomic) CGFloat mailCellHeight;
@property (nonatomic, strong) UIColor *mailCellColor;
@property (nonatomic, strong) UIColor *mailBgColor;
@property (nonatomic, strong) UIFont *mailFont;
@property (nonatomic, strong) UIColor *MailFontColor;
@property (nonatomic, strong) NSArray *mailsuffixData;
@property (nonatomic, strong) NSArray *separatorInsets;
- (void)hideEmailPrompt;
- (instancetype)initWithFrame:(CGRect)frame InView:(UIView *)view;
@end
