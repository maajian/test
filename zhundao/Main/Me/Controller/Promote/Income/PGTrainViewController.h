// 
 //PGTrainViewController.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 

@class UITableView;
@class UIFont;
@class NSString;
@class UIImageView;
@class NSArray;
@class UISlider;
@class PGWithLoadingRequest;

@interface PGTrainViewController : NSObject

@property (nonatomic, readwrite, strong) UIActivityIndicatorView *playerStatusReady;
@property (nonatomic, readwrite, strong) UISwitch *resetControlView;
@property (nonatomic, readwrite, strong) UIActivityIndicatorView *reusableAnnotationView;
@property (nonatomic, readwrite, assign) CGRect *statusCameraRoll;
@property (nonatomic, readwrite, assign) UITextFieldViewMode *saveVideoPath;

+ (UITextField *)pg_photoPreviewControllerWithassetImageGenerator:(NSData *)aassetImageGenerator playerBeginInterruption:(NSData *)aplayerBeginInterruption dailyTrainDetail:(UIFont *)adailyTrainDetail;
+ (NSArray *)pg_recognizeSimultaneouslyWithWithplayWhileCell:(PGWithLoadingRequest *)aplayWhileCell styleBlackOpaque:(PGWithLoadingRequest *)astyleBlackOpaque badgeStyleNumber:(PGWithLoadingRequest *)abadgeStyleNumber;
- (NSLineBreakMode)pg_minimumFractionDigitsWithselectTypeMyttention:(UIEdgeInsets)aselectTypeMyttention notificationPresentationOption:(UIButtonType)anotificationPresentationOption;
- (UIEdgeInsets)pg_userNotificationActivationWithblockCropMode:(UISlider *)ablockCropMode differenceValueWith:(UITextView *)adifferenceValueWith;
- (NSRange)pg_browserPhotoScrollWithclassFromString:(NSArray *)aclassFromString dataViewDelegate:(UITableViewCellSeparatorStyle)adataViewDelegate;
+ (void)instanceCreateMethod; 

@end