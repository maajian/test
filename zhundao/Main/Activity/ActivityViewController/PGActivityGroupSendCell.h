#import <UIKit/UIKit.h>
@class PGActivityGroupSendCell;
@protocol GroupSendTableViewCellDelegate <NSObject>
- (void)tableViewCell:(PGActivityGroupSendCell *)tableViewCell didSelectTextView:(UITextView *)textView;
@end
typedef void(^groupSendBlock) (NSInteger needCount,NSString *textStr);
@interface PGActivityGroupSendCell : UITableViewCell
@property(nonatomic,copy)groupSendBlock groupSendBlock;
@property(nonatomic,strong)UILabel *leftLabel1;
@property(nonatomic,strong)UILabel *rightLabel;
@property(nonatomic,strong)UITextView *TextView;
@property(nonatomic,strong)UILabel *wordLabel;
@property(nonatomic,strong)UILabel *detailLabel;
@property(nonatomic,strong)UILabel *groupSign;
@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,assign)NSInteger personCount;
@property(nonatomic,assign)NSInteger messageCount;
@property(nonatomic,copy)NSString *signStr;
@property(nonatomic,strong)NSString *textStr;
@property(nonatomic,assign)NSInteger labelCount;
@property (nonatomic, weak) id<GroupSendTableViewCellDelegate> groupSendTableViewCellDelegate;
@end
