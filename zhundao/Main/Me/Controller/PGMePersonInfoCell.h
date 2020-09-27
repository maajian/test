#import <UIKit/UIKit.h>
#import "PGMePersonInfoModel.h"
@interface PGMePersonInfoCell : UITableViewCell
@property(nonatomic,strong)UILabel *leftLabel;
@property(nonatomic,strong)UILabel *rightLabel;
@property(nonatomic,assign)NSInteger cellTag;
@property(nonatomic,strong)PGMePersonInfoModel *model;
@property(nonatomic,copy)NSArray *leftArray;
@end
