#import <UIKit/UIKit.h>
@interface PGActivityJPullCell : UITableViewCell
@property (assign, nonatomic) CGFloat leftEdge;
@property (strong, nonatomic) NSString *emailText;
@property (strong, nonatomic) UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UIButton *touchButton;
@end
