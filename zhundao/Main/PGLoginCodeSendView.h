#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@class PGLoginCodeSendView;
@protocol PGLoginCodeSendViewDelegate <NSObject>
- (void)PGLoginCodeSendView:(PGLoginCodeSendView *)loginCodeSendView didTapCloseButton:(UIButton *)button;
- (void)PGLoginCodeSendView:(PGLoginCodeSendView *)loginCodeSendView didTapNextButton:(UIButton *)button;
@end
@interface PGLoginCodeSendView : UIView
@property (nonatomic, strong, readonly) UITextField   *phoneTF;
@property (nonatomic, weak) id<PGLoginCodeSendViewDelegate> loginCodeSendViewDelegate;
@end
NS_ASSUME_NONNULL_END
