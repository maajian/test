#import <UIKit/UIKit.h>
#import "PGDiscoverFaceModel.h"
@interface PGDiscoverFaceDetailCell : UITableViewCell
@property(nonatomic,strong)PGDiscoverFaceModel *model;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *rightLabel;
@property(nonatomic,strong)UIButton *signButton;
@end
