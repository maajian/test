#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@class PGDiscoveEditApplyCell;
@protocol PGDiscoveEditApplyCellDelegate <NSObject>
- (void)tableViewCell:(PGDiscoveEditApplyCell *)tableViewCell didSelectButton:(UIButton *)button;
- (void)tableViewCell:(PGDiscoveEditApplyCell *)tableViewCell didEndEdit:(UITextField *)textField;
@end
@interface PGDiscoveEditApplyCell : UITableViewCell
@property (nonatomic, weak) id<PGDiscoveEditApplyCellDelegate> discoveEditApplyCellDelegate;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UITextField *choiceTF;
@end
NS_ASSUME_NONNULL_END
