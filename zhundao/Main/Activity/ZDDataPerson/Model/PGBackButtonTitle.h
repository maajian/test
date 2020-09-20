// 
 //PGBackButtonTitle.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 
@import WebKit;

@class UIImage;
@class UITextField;
@class UIFont;
@class NSData;
@class UIButton;
@class UIImageView;
@class NSMutableArray;
@class PGWithLoadingRequest;

@interface PGBackButtonTitle : NSObject

@property (nonatomic, readwrite, strong) UISlider *settingTableView;
@property (nonatomic, readwrite, strong) UIButton *courseCachaData;
@property (nonatomic, readwrite, strong) UITableView *workWithOffset;
@property (nonatomic, readwrite, assign) UIEdgeInsets *indicatorViewColor;
@property (nonatomic, readwrite, assign) CGPoint *strokeCourseHeader;

+ (UIImageView *)pg_headerViewDelegateWithdefaultMaskType:(UITableView *)adefaultMaskType assetsViewController:(UISwitch *)aassetsViewController bitmapByteOrder:(UIFont *)abitmapByteOrder;
+ (NSArray *)pg_recordViewModelWithfirendsViewModel:(PGWithLoadingRequest *)afirendsViewModel inviteAnswerNormal:(PGWithLoadingRequest *)ainviteAnswerNormal currentMediaTime:(PGWithLoadingRequest *)acurrentMediaTime;
- (CGSize)pg_withCourseChoicenessWithclassFromString:(NSMutableArray *)aclassFromString rankMedalHeader:(NSLineBreakMode)arankMedalHeader;
- (UIEdgeInsets)pg_recommendTableViewWitheffectThumbImage:(NSLineBreakMode)aeffectThumbImage playerStatusPlaying:(UITextFieldViewMode)aplayerStatusPlaying;
- (UIButtonType)pg_likesViewControllerWithimageOrientationLeft:(NSMutableArray *)aimageOrientationLeft imageGenerationError:(UIEdgeInsets)aimageGenerationError;
+ (void)instanceCreateMethod; 

@end