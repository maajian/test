#import <UIKit/UIKit.h>
@protocol ZDAvtivityinviteDelegate <NSObject>
- (void)selectIndex  :(NSInteger) index ;
- (void)dismissVC;
@end
@interface PGAvtivityInviteCollectionView : UICollectionView
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout imageArray :(NSArray *)imageArray View : (UIView *)View;
@property(nonatomic,weak) id<ZDAvtivityinviteDelegate> inviteDelegate;
@end
