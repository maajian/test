#import <UIKit/UIKit.h>
#import "PGMePromoteNoticeModel.h"
NS_ASSUME_NONNULL_BEGIN
@class PGMePromoteCustomContactNoticeView;
@protocol PGMePromoteCustomContactNoticeViewDelegate <NSObject>
- (void)promoteCustomContactNoticeView:(PGMePromoteCustomContactNoticeView *)promoteCustomContactNoticeView didTapMoreButton:(UIButton *)button;
- (void)promoteCustomContactNoticeView:(PGMePromoteCustomContactNoticeView *)promoteCustomContactNoticeView didTapNotice:(PGMePromoteNoticeModel *)model;
@end
@interface PGMePromoteCustomContactNoticeView : UIView
@property (nonatomic, weak) id<PGMePromoteCustomContactNoticeViewDelegate> promoteCustomContactNoticeViewDelegate;
@property (nonatomic, strong) NSMutableArray <PGMePromoteNoticeModel *> *noticeArray;
@end
NS_ASSUME_NONNULL_END
