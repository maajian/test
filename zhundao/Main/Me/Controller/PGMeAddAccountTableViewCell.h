#import <UIKit/UIKit.h>
@interface PGMeAddAccountTableViewCell : UITableViewCell
@property(nonatomic,strong)UITextField *textf;
@property(nonatomic,strong)UILabel *bottomLeftLabel;
@property(nonatomic,strong)UILabel *rightLabel;
@property(nonatomic,strong)UILabel *topLeftLabel;
@property(nonatomic,assign)NSInteger row;
@property(nonatomic,copy)NSString *currentType;
@property(nonatomic,copy)NSString *name;
@end
