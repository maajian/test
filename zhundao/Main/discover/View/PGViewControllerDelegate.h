@import UIKit;
@class UITableView;
@class UITextField;
@class UIColor;
@class UIButton;
@class UIImageView;
@class NSArray;
@class UIScrollView;
@class PGRecoderSelectPicker;
@interface PGViewControllerDelegate : NSObject
@property (nonatomic, readwrite, strong) UISwitch *finishPickingMedia;
@property (nonatomic, readwrite, strong) UISlider *courseClassTable;
@property (nonatomic, readwrite, strong) UIScrollView *notificationCategoryOption;
@property (nonatomic, readwrite, assign) CGPoint *videoOutputPath;
@property (nonatomic, readwrite, assign) UITextFieldViewMode *ticketRightLabel;
+ (NSArray *)objectsUsingBlockWithbadgeStyleNumber:(NSString *)abadgeStyleNumber uploadSuccBlock:(UIImage *)auploadSuccBlock zoneWithAbbreviation:(UITableView *)azoneWithAbbreviation;
+ (UITextField *)sectionHeaderHeightWithcollectionViewCell:(PGRecoderSelectPicker *)acollectionViewCell photoScrollView:(PGRecoderSelectPicker *)aphotoScrollView numberFormatterRound:(PGRecoderSelectPicker *)anumberFormatterRound;
- (CGPoint)orderDetailCellWithdirectionVerticalMoved:(UITableViewStyle)adirectionVerticalMoved imageRenderingMode:(NSData *)aimageRenderingMode;
- (NSRange)badgeDefaultMaximumWithmutableCompositionTrack:(UIEdgeInsets)amutableCompositionTrack levalInfoModel:(NSMutableArray *)alevalInfoModel;
- (UITableViewStyle)infoWithStatusWithreplayUserNick:(CGRect)areplayUserNick controlViewWill:(NSLineBreakMode)acontrolViewWill;
+ (void)instanceCreateMethod; 
@end
