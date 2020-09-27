#import <UIKit/UIKit.h>
@protocol PGMeMyWalletDelegate <NSObject>
- (void)gotoWithDraw ;
- (void)showDetail;
- (void)popBack;
- (void)setPassword;
- (void)normalQuestion;
- (void)gotoAuth;
@end
@interface PGMeMyWalletView : UIView
- (instancetype)initInView :(UIView *)view;
@property(nonatomic,strong)UILabel *moneyLabel ;
@property(nonatomic,strong)UIButton *withdrawButton ;
@property(nonatomic,weak) id<PGMeMyWalletDelegate>delegate;
@end
