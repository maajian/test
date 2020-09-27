#import <UIKit/UIKit.h>
#import "PGActivityConsultModel.h"
@interface PGActivityOneConsultTableViewCell : UITableViewCell
@property(nonatomic,strong)PGActivityConsultModel *model;
@property(nonatomic,strong) UIImageView *imgView ;
@property(nonatomic,strong)UILabel *nameLabel ;
@property(nonatomic,strong)UILabel * phoneLabel;
@property(nonatomic,strong)UILabel * questionLabel ;
@property(nonatomic,strong)UILabel * anwserLabel;
@property(nonatomic,strong) UILabel  *timeLabel;
@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,strong)UISwitch *mySwitch;
@property(nonatomic,strong) UILabel  *remLabel;
@property(nonatomic,assign)float height;
@property(nonatomic,strong)NSString *timeStr ;
@end
