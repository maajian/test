#import <UIKit/UIKit.h>
#import "PGMeAuthModel.h"
@interface PGMeAutoBottomTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *topLabel;
@property(nonatomic,strong)UIImageView *idCardImgView;
@property(nonatomic,copy)NSString *topStr;
@property(nonatomic,strong)PGMeAuthModel *model;
@end
