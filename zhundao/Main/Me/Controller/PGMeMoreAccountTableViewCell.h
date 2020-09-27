#import <UIKit/UIKit.h>
#import "PGMeMoreAccountModel.h"
@interface PGMeMoreAccountTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) PGMeMoreAccountModel *model;
@end
