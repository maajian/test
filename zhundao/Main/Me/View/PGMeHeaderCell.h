#import <UIKit/UIKit.h>
#import "PGMeModel.h"
NS_ASSUME_NONNULL_BEGIN
@class PGMeHeaderCell;
@protocol PGMeHeaderCellDelegate <NSObject>
- (void)headerCell:(PGMeHeaderCell *)headerCell didTapVIPLabel:(UILabel *)label;
@end
@interface PGMeHeaderCell : UITableViewCell
@property (nonatomic, strong) PGMeModel *model;
@property (nonatomic, weak) id<PGMeHeaderCellDelegate> meHeaderCellDelegate;
@end
NS_ASSUME_NONNULL_END
