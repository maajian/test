#import <UIKit/UIKit.h>
#import "PGActivityBigImageCollectionView.h"
@protocol ChooseBigImgTableViewCellDelegate <NSObject>
- (void)selectImage :(NSString *)urlStr item :(NSInteger)item tag:(NSInteger)CollectionViewTag;
@end
@interface PGActivityChooseBigImgCell : UITableViewCell
@property(nonatomic,weak) id<ChooseBigImgTableViewCellDelegate>  ChooseBigImgTableViewCellDelegate;
@property(nonatomic,strong)UILabel *topLeftLabel ;
@property(nonatomic,strong)UILabel *topRightLabel;
@property(nonatomic,strong)UIImageView *arrowImgView;
@property(nonatomic,assign)NSInteger height;
@property(nonatomic,assign)NSInteger section;
@property(nonatomic,assign)NSDictionary *collectDic;
@property(nonatomic,assign)NSInteger currentItem;
@property(nonatomic,assign)NSInteger currentTag;
@end
