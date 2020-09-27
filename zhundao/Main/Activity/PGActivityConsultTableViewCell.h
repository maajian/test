#import <UIKit/UIKit.h>
#import "PGActivityConsultModel.h"
@interface PGActivityConsultTableViewCell : UITableViewCell
@property(nonatomic,strong)PGActivityConsultModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *consultLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *recommendLabel;
@property(nonatomic,copy)NSString  *timeStr;
@end
