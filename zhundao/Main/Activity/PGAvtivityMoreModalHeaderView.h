#import <UIKit/UIKit.h>
@class PGAvtivityMoreModalHeaderView;
typedef NS_ENUM(NSInteger, chartType) {
    chartTypeApply,
    chartTypeBrowse,
    chartTypeIncome
};
@protocol PGAvtivityMoreModalHeaderViewDelegate <NSObject>
- (void)header:(PGAvtivityMoreModalHeaderView *)headerView didTapDetailView:(UIView *)detailView;
- (void)header:(PGAvtivityMoreModalHeaderView *)headerView didTapChartView:(chartType)type ;
@end
NS_ASSUME_NONNULL_BEGIN
@interface PGAvtivityMoreModalHeaderView : UICollectionReusableView
@property (nonatomic, strong) ActivityModel *model;
@property (nonatomic, copy) NSString *endTime;
@property (nonatomic, weak) id<PGAvtivityMoreModalHeaderViewDelegate> headerViewDelegate;
@end
NS_ASSUME_NONNULL_END
