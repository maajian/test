#import <UIKit/UIKit.h>
#import "PGMePromoteNoticeModel.h"
NS_ASSUME_NONNULL_BEGIN
@class PGMePromoteCustomContactHeaderView;
@protocol PGMePromoteCustomContactHeaderViewDelegate <NSObject>
- (void)promoteCustomContactHeaderView:(PGMePromoteCustomContactHeaderView *)promoteCustomContactHeaderView didTapExtendButton:(UIButton *)button;
- (void)promoteCustomContactHeaderView:(PGMePromoteCustomContactHeaderView *)promoteCustomContactHeaderView didTapMoreButton:(UIButton *)button;
- (void)promoteCustomContactHeaderView:(PGMePromoteCustomContactHeaderView *)promoteCustomContactHeaderView didTapNotice:(PGMePromoteNoticeModel *)model;
@end
@interface PGMePromoteCustomContactHeaderView : UIView
@property (nonatomic, assign) NSInteger zhundaoBi;
@property (nonatomic, strong) NSMutableArray <PGMePromoteNoticeModel *> *noticeArray;
@property (nonatomic, assign) id<PGMePromoteCustomContactHeaderViewDelegate> promoteCustomContactHeaderViewDelegate;
@end
NS_ASSUME_NONNULL_END
