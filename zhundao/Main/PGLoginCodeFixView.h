#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@class PGLoginCodeFixView;
@protocol PGLoginCodeFixViewDelegate <NSObject>
- (void)PGLoginCodeFixView:(PGLoginCodeFixView *)loginCodeFixView didTapCloseButton:(UIButton *)button;
- (void)PGLoginCodeFixView:(PGLoginCodeFixView *)loginCodeFixView didTapNextButton:(UIButton *)button;
@end
@interface PGLoginCodeFixView : UIView
@property (nonatomic, weak) id<PGLoginCodeFixViewDelegate> loginCodeFixViewDelegate;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *phoneStr;
@end
NS_ASSUME_NONNULL_END
