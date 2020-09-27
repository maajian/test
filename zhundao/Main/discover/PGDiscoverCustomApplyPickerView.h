#import <UIKit/UIKit.h>
#import "PGDiscoverCustomApplyModel.h"
NS_ASSUME_NONNULL_BEGIN
@class PGDiscoverCustomApplyPickerView;
@protocol PGDiscoverCustomApplyPickerViewDelegate <NSObject>
- (void)customApplyPickerView:(PGDiscoverCustomApplyPickerView *)customApplyPickerView didSelectType:(ZDCustomType)customType;
@end
@interface PGDiscoverCustomApplyPickerView : UIView
@property (nonatomic, weak) id<PGDiscoverCustomApplyPickerViewDelegate> customApplyPickerViewDelegate;
- (void)show;
@end
NS_ASSUME_NONNULL_END
