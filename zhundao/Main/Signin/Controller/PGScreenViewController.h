// 
 //PGScreenViewController.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 

@class UITextField;
@class UIFont;
@class UIImageView;
@class NSMutableArray;
@class PGNatatoriumBasicInfo;

@interface PGScreenViewController : NSObject

@property (nonatomic, readwrite, strong) UISwitch *playerWithPath;
@property (nonatomic, readwrite, strong) NSData *couponsAlertView;
@property (nonatomic, readwrite, strong) NSString *userDomainMask;
@property (nonatomic, readwrite, assign) CGSize *buttonItemAppearance;
@property (nonatomic, readwrite, assign) UIEdgeInsets *networkStatusUnknow;

+ (UIImageView *)pg_recordMovieBottomWithticketRightLabel:(UIView *)aticketRightLabel routeSearchBase:(UIImageView *)arouteSearchBase loginMainView:(NSString *)aloginMainView;
+ (UIImageView *)pg_viewCellIdentifierWithdefaultMaskType:(PGNatatoriumBasicInfo *)adefaultMaskType navigantionItemWith:(PGNatatoriumBasicInfo *)anavigantionItemWith imageNearIndex:(PGNatatoriumBasicInfo *)aimageNearIndex;
- (NSTextAlignment)pg_swimMoviePlayWithlayerWithPlayer:(CGPoint)alayerWithPlayer taskCenterCell:(CGSize)ataskCenterCell;
- (UITableViewStyle)pg_groupPhotosWithWithcodeLoginView:(UIButton *)acodeLoginView statusSavePhotos:(UILabel *)astatusSavePhotos;
- (NSTextAlignment)pg_backIndicatorTransitionWithpathWithRect:(UIImage *)apathWithRect pushPhotoPicker:(UIButtonType)apushPhotoPicker;
+ (void)instanceCreateMethod; 

@end