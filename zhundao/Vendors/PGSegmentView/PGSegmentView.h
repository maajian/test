#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@class PGSegmentView;
@protocol PGSegmentViewDelegate <NSObject>
- (void)segmentView:(nullable PGSegmentView *)segmentView didSelectIndex:(NSInteger)index;
@end
@interface PGSegmentView : UIView
@property (nonatomic, weak) id<PGSegmentViewDelegate> segmentViewDelegate;
- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArray;
@property (nonatomic, strong) UIFont *textFont; 
@property (nonatomic, assign) CGFloat lineWidth; 
@property (nonatomic, assign) NSInteger currentIndex; 
@property (nonatomic, assign) BOOL showBottomLine; 
@end
NS_ASSUME_NONNULL_END
