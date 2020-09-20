// 
 //PGNavigationControllerDelegate.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 

@class UITableView;
@class NSString;
@class UIView;
@class UILabel;
@class UISwitch;
@class UISlider;
@class PGWithTrainParticular;

@interface PGNavigationControllerDelegate : NSObject

@property (nonatomic, readwrite, strong) UISwitch *selectTypeUser;
@property (nonatomic, readwrite, strong) UITextField *imageSourceCopy;
@property (nonatomic, readwrite, strong) UIColor *backFromFront;
@property (nonatomic, readwrite, assign) UITableViewStyle *trainParticularHeader;
@property (nonatomic, readwrite, assign) CGSize *sheetWithData;

+ (UIButton *)pg_couponViewModelWithbytesUsingEncoding:(NSString *)abytesUsingEncoding currentPhotoIndex:(UITextView *)acurrentPhotoIndex followWithHeading:(UITableView *)afollowWithHeading;
+ (UIButton *)pg_receiveRemoteNotificationWithorderDetailCell:(PGWithTrainParticular *)aorderDetailCell taskCenterModel:(PGWithTrainParticular *)ataskCenterModel titleViewExample:(PGWithTrainParticular *)atitleViewExample;
- (UITableViewCellSeparatorStyle)pg_textAlignmentLeftWithplayerStatusFailed:(UITextField *)aplayerStatusFailed inputTextureUniform:(NSLineBreakMode)ainputTextureUniform;
- (UIButtonType)pg_strokeCourseViewWithtitleShowStatus:(NSArray *)atitleShowStatus locationWithGeocoder:(NSTextAlignment)alocationWithGeocoder;
- (UITableViewStyle)pg_imageManagerMaximumWithrectCornerBottom:(CGRect)arectCornerBottom videoImageExtractor:(CGPoint)avideoImageExtractor;
+ (void)instanceCreateMethod; 

@end