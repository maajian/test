// 
 //PGFetchLoginInfo.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 

@class UIFont;
@class UITextView;
@class NSString;
@class UIImageView;
@class NSMutableArray;
@class NSArray;
@class PGScreenViewController;

@interface PGFetchLoginInfo : NSObject

@property (nonatomic, readwrite, strong) UIScrollView *insetAdjustmentBehavior;
@property (nonatomic, readwrite, strong) UISlider *exerciseHistoryData;
@property (nonatomic, readwrite, strong) UIScrollView *medalDetailCell;
@property (nonatomic, readwrite, assign) UIButtonType *chatBindWith;
@property (nonatomic, readwrite, assign) UITextFieldViewMode *actionSheetDelegate;

+ (UIView *)pg_playerWithPathWithcourseVideoPlayer:(UILabel *)acourseVideoPlayer numberIconImage:(NSData *)anumberIconImage separatorStyleSingle:(UIImage *)aseparatorStyleSingle;
+ (NSString *)pg_withRefreshingTargetWithcourseScrollView:(PGScreenViewController *)acourseScrollView settingTableView:(PGScreenViewController *)asettingTableView gestureRecognizerState:(PGScreenViewController *)agestureRecognizerState;
- (CGRect)pg_imageRequestOptionsWithimageViewWith:(CGPoint)aimageViewWith withVisualFormat:(UITextFieldViewMode)awithVisualFormat;
- (CGSize)pg_authorizationWithOptionsWithvideoWithAsset:(UIFont *)avideoWithAsset keywindowWithText:(UIActivityIndicatorView *)akeywindowWithText;
- (UIButtonType)pg_withContainerSizeWithcourseRecommendCell:(CGPoint)acourseRecommendCell minimumTrackImage:(UISlider *)aminimumTrackImage;
+ (void)instanceCreateMethod; 

@end