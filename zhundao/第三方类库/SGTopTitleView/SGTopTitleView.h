#import <UIKit/UIKit.h>
@class SGTopTitleView;
@protocol SGTopTitleViewDelegate <NSObject>
- (void)titleViewDidSelectTitleAtIndex:(NSInteger)index;
@end
@interface SGTopTitleView : UIScrollView
@property (nonatomic, strong) NSArray *staticTitleArr;
@property (nonatomic, strong) NSArray *scrollTitleArr;
@property (nonatomic, strong) NSMutableArray *allTitleLabel;
@property (nonatomic, weak) id<SGTopTitleViewDelegate> delegate_SG;
+ (instancetype)topTitleViewWithFrame:(CGRect)frame;
#pragma mark - - - 给外界ScrollView提供的方法以及自身方法实现
- (void)staticTitleLabelSelecteded:(UILabel *)label;
- (void)scrollTitleLabelSelecteded:(UILabel *)label;
- (void)scrollTitleLabelSelectededCenter:(UILabel *)centerLabel;
@end
