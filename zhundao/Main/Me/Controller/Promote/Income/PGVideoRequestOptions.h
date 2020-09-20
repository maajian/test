// 
 //PGVideoRequestOptions.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 

@class UITableView;
@class UITextField;
@class NSString;
@class UIScrollView;
@class UISlider;
@class PGInsideImageView;

@interface PGVideoRequestOptions : NSObject

@property (nonatomic, readwrite, strong) UILabel *showingPhotoView;
@property (nonatomic, readwrite, strong) UIColor *discountCouponTable;
@property (nonatomic, readwrite, strong) UIImageView *emojiTypeAction;
@property (nonatomic, readwrite, assign) CGRect *deviceOrientationChange;
@property (nonatomic, readwrite, assign) NSTextAlignment *whenInteractionEnds;

+ (UISwitch *)pg_rectEdgeNoneWithuserInfoHeader:(UIImage *)auserInfoHeader itemTextFont:(NSMutableArray *)aitemTextFont sectionHeaderHeight:(NSString *)asectionHeaderHeight;
+ (UIActivityIndicatorView *)pg_cancelContentTouchesWithsourceTypeCamera:(PGInsideImageView *)asourceTypeCamera videoProcessingQueue:(PGInsideImageView *)avideoProcessingQueue activityListWith:(PGInsideImageView *)aactivityListWith;
- (UITableViewStyle)pg_hiddenScreenViewWithstatusSavePhotos:(UISlider *)astatusSavePhotos trainPropertyTrain:(UITextFieldViewMode)atrainPropertyTrain;
- (CGRect)pg_pausesLocationUpdatesWithsessionDataTask:(UITableView *)asessionDataTask imageSourceContains:(UITextField *)aimageSourceContains;
- (NSRange)pg_streamStatusConnectingWithactionWithIdentifier:(UITableViewCellSeparatorStyle)aactionWithIdentifier controlEventEditing:(NSMutableArray *)acontrolEventEditing;
+ (void)instanceCreateMethod; 

@end