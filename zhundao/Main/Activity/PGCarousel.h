#import <UIKit/UIKit.h>
@interface PGCarousel : UICollectionView
- (instancetype)initWithFrame:(CGRect)frame
         collectionViewLayout:  (UICollectionViewLayout *)layout
                   imageArray:(NSArray *)imageArray
                        View : (UIView *)View;
@property(nonatomic,assign)BOOL isAutoScroll;
@property(nonatomic,strong)UIColor *pageTintColor;
@property(nonatomic,strong)UIColor *currentPageColor;
@property(nonatomic,assign)BOOL hiddenPageCtr;
@property(nonatomic,assign)NSTimeInterval duration;
@end
