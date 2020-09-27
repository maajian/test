#import <UIKit/UIKit.h>
#import "PGDiscoverCustomApplyModel.h"
NS_ASSUME_NONNULL_BEGIN
@class PGDiscoveEditApplyHeaderView;
@protocol PGDiscoveEditApplyHeaderViewDelegate <NSObject>
- (void)headerView:(PGDiscoveEditApplyHeaderView *)headerView didChangeType:(UILabel *)typeLabel;
@end
@interface PGDiscoveEditApplyHeaderView : UIView
@property (nonatomic, strong, readonly) UITextField *titleTF;
@property (nonatomic, strong, readonly) UISwitch *mustSwitch;
@property (nonatomic, strong, readonly) UILabel *typeLabel;
@property (nonatomic, strong, readonly) UITextField *tipInputTF;
@property (nonatomic, strong) PGDiscoverCustomApplyModel *model;
@property (nonatomic, weak) id<PGDiscoveEditApplyHeaderViewDelegate> discoveEditApplyHeaderViewDelegate;
@end
NS_ASSUME_NONNULL_END
