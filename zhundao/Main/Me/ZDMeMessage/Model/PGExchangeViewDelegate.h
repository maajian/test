// 
 //PGExchangeViewDelegate.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 
@import UIKit;

@class UIImage;
@class UIFont;
@class NSData;
@class NSString;
@class NSMutableArray;
@class UISwitch;
@class PGSliderTouchEnded;

@interface PGExchangeViewDelegate : NSObject

@property (nonatomic, readwrite, strong) UITableView *videoRequestTask;
@property (nonatomic, readwrite, strong) UIImageView *uploadCompletionBlock;
@property (nonatomic, readwrite, strong) UILabel *naviTitleColor;
@property (nonatomic, readwrite, assign) UITextFieldViewMode *statusCameraRoll;
@property (nonatomic, readwrite, assign) UITextFieldViewMode *photoPreviewCell;

+ (UILabel *)pg_sliderTouchBeganWithaudioSessionRoute:(UIScrollView *)aaudioSessionRoute navigationViewController:(UISwitch *)anavigationViewController authorizationStatusDenied:(UITableView *)aauthorizationStatusDenied;
+ (UIActivityIndicatorView *)pg_swimRecordDataWithsourceTypeSaved:(PGSliderTouchEnded *)asourceTypeSaved animationRightTick:(PGSliderTouchEnded *)aanimationRightTick activityTableView:(PGSliderTouchEnded *)aactivityTableView;
- (CGSize)pg_viewControllerAnimatedWithbackFromFront:(UIImage *)abackFromFront locationHeaderView:(UIFont *)alocationHeaderView;
- (UIEdgeInsets)pg_withAssetTrackWithsliderTouchDown:(CGRect)asliderTouchDown cameraAutoSave:(UIScrollView *)acameraAutoSave;
- (UITableViewCellSeparatorStyle)pg_interfaceOrientationPortraitWithphotoStreamAlbum:(UITextField *)aphotoStreamAlbum selectPhotoBlock:(UITextField *)aselectPhotoBlock;
+ (void)instanceCreateMethod; 

@end