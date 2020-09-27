#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@protocol PGDiscoveEditApplyFooterViewDelegate <NSObject>
- (void)footerView:(UIView *)footerView didAddButton:(UIButton *)button;
@end
@interface PGDiscoveEditApplyFooterView : UIView
@property (nonatomic, weak) id<PGDiscoveEditApplyFooterViewDelegate> discoveEditApplyFooterViewDelegate;
@property (nonatomic, assign) BOOL isNeedChoice;
@property (nonatomic, assign) BOOL isNew;
@end
NS_ASSUME_NONNULL_END
