#import <UIKit/UIKit.h>
#import "PGDiscoverCustomModel.h"
@interface PGDiscoverCustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *markLabel;
@property(nonatomic,strong)PGDiscoverCustomModel *model;
@end
