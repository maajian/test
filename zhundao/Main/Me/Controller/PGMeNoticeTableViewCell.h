#import <UIKit/UIKit.h>
#import "PGMeNoticeModel.h"
@interface PGMeNoticeTableViewCell : UITableViewCell
@property(nonatomic,strong)PGMeNoticeModel *model ;
@property(nonatomic,strong)UILabel  *topLabel ;
@property(nonatomic,strong)UILabel *bottomLabel ;
@property(nonatomic,copy)NSString *timeText;
@end
