#import <UIKit/UIKit.h>
@protocol imageSelectDelegate <NSObject>
- (void)selectIndex :(NSString *)urlStr item :(NSInteger)item tag:(NSInteger)CollectionViewTag;
@end
@interface PGActivityBigImageCollectionView : UICollectionView
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout;
@property(nonatomic,weak) id<imageSelectDelegate> imageSelectDelegate;
@property(nonatomic,copy)NSArray *dataArray;
@property(nonatomic,copy,readwrite)NSString *headerTitle;
@property(nonatomic,assign)NSInteger currentItem;
@property(nonatomic,assign)NSInteger currentTag;
@end
