#import <UIKit/UIKit.h>
#import "ActivityModel.h"
NS_ASSUME_NONNULL_BEGIN
@class PGActivityCell;
@protocol PGActivityCellDelegate <NSObject>
- (void)activityCell:(PGActivityCell *)activityCell didTapListButton:(UIButton *)button;
- (void)activityCell:(PGActivityCell *)activityCell didTapShareButton:(UIButton *)button;
- (void)activityCell:(PGActivityCell *)activityCell didTapSignButton:(UIButton *)button;
- (void)activityCell:(PGActivityCell *)activityCell didTapMoreButton:(UIButton *)button;
@end
@interface PGActivityCell : UITableViewCell
@property (nonatomic, weak) id<PGActivityCellDelegate> activityCellDelegate;
@property (nonatomic, strong) ActivityModel *model;
@end
NS_ASSUME_NONNULL_END
