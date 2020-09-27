#import <UIKit/UIKit.h>
#import "PGMeContactModel.h"
@interface PGMeContactTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property(nonatomic,strong)PGMeContactModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@end
