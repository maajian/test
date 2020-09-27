#import "PGBaseVC.h"
@protocol ChooseBigImgDelegate<NSObject>
- (void)ChooseImgStr:(NSString *)urlStr isPost :(BOOL)isPostImg indexPath :(NSIndexPath *)indexPath;
@end
@interface PGActivityChooseBigImgVC : PGBaseVC
@property(nonatomic,copy)NSArray *imageArray;
@property(nonatomic,strong)NSString *selectUrl;
@property(nonatomic,assign)NSInteger currentItem;
@property(nonatomic,assign)NSInteger collectIndex;
@property(nonatomic,weak) id <ChooseBigImgDelegate>  ChooseBigImgDelegate;
@end
