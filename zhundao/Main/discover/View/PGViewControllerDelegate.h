// 
 //PGViewControllerDelegate.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 
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

+ (NSArray *)pg_objectsUsingBlockWithbadgeStyleNumber:(NSString *)abadgeStyleNumber uploadSuccBlock:(UIImage *)auploadSuccBlock zoneWithAbbreviation:(UITableView *)azoneWithAbbreviation;
+ (UITextField *)pg_sectionHeaderHeightWithcollectionViewCell:(PGRecoderSelectPicker *)acollectionViewCell photoScrollView:(PGRecoderSelectPicker *)aphotoScrollView numberFormatterRound:(PGRecoderSelectPicker *)anumberFormatterRound;
- (CGPoint)pg_orderDetailCellWithdirectionVerticalMoved:(UITableViewStyle)adirectionVerticalMoved imageRenderingMode:(NSData *)aimageRenderingMode;
- (NSRange)pg_badgeDefaultMaximumWithmutableCompositionTrack:(UIEdgeInsets)amutableCompositionTrack levalInfoModel:(NSMutableArray *)alevalInfoModel;
- (UITableViewStyle)pg_infoWithStatusWithreplayUserNick:(CGRect)areplayUserNick controlViewWill:(NSLineBreakMode)acontrolViewWill;
+ (void)instanceCreateMethod; 

@end