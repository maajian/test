// 
 //PGCoachDetailView.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 
@import UIKit;

@class UITextView;
@class NSData;
@class UIColor;
@class NSString;
@class UIImageView;
@class UISwitch;
@class UIActivityIndicatorView;
@class UIScrollView;
@class UISlider;
@class PGHaveUserEnabel;

@interface PGCoachDetailView : NSObject

@property (nonatomic, readwrite, strong) UIScrollView *shaderFromString;
@property (nonatomic, readwrite, strong) UIImage *withServiceArea;
@property (nonatomic, readwrite, strong) UIActivityIndicatorView *itemPhotoClick;
@property (nonatomic, readwrite, assign) NSRange *saveVideoPath;
@property (nonatomic, readwrite, assign) NSLineBreakMode *orderDetailCell;

+ (NSArray *)finishPickingVideoWithassetImageGenerator:(UITextView *)aassetImageGenerator spinLockUnlock:(UIImage *)aspinLockUnlock originalPhotoWith:(UIColor *)aoriginalPhotoWith;
+ (UIScrollView *)courseVideoPlayerWithmainFirstLogin:(PGHaveUserEnabel *)amainFirstLogin loginWithUser:(PGHaveUserEnabel *)aloginWithUser infoWithStatus:(PGHaveUserEnabel *)ainfoWithStatus;
- (UITableViewStyle)spinLockLockWithviewCellIdentifier:(UIButtonType)aviewCellIdentifier courseDetailView:(UIColor *)acourseDetailView;
- (NSRange)allowWithControllerWithviewSettingBlock:(CGPoint)aviewSettingBlock authrizationStatusChange:(UIScrollView *)aauthrizationStatusChange;
- (CGSize)failLoadWithWithwithArticleOriginal:(NSTextAlignment)awithArticleOriginal titleShowStatus:(NSLineBreakMode)atitleShowStatus;
+ (void)instanceCreateMethod; 

@end
