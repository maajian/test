#import <UIKit/UIKit.h>
#import "PGActivityListModel.h"
@interface PGActivityListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *listCount;
@property (weak, nonatomic) IBOutlet UILabel *successLabel;
@property(nonatomic,strong)PGActivityListModel *model;
@end
