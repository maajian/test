// 
 //PGDailyTrainView.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 
@import UIKit;
@import WebKit;

@class UITableView;
@class NSData;
@class NSMutableArray;
@class NSArray;
@class UIActivityIndicatorView;
@class PGExportVideoWith;

@interface PGDailyTrainView : NSObject

@property (nonatomic, readwrite, strong) UIActivityIndicatorView *dataWithUser;
@property (nonatomic, readwrite, strong) UIImage *guideCollectionView;
@property (nonatomic, readwrite, strong) UIButton *viewCornerRadius;
@property (nonatomic, readwrite, assign) NSRange *categoryChooseView;
@property (nonatomic, readwrite, assign) UIButtonType *selectPhotoAssets;

+ (UIImage *)pg_cyclingLineAnimationWithcurrentPhotoIndex:(UITextView *)acurrentPhotoIndex audioSessionPort:(UIColor *)aaudioSessionPort playerWithPath:(UIScrollView *)aplayerWithPath;
+ (UILabel *)pg_weekTimeLabelWithstyleBlackOpaque:(PGExportVideoWith *)astyleBlackOpaque deliveryModeHigh:(PGExportVideoWith *)adeliveryModeHigh imageWithName:(PGExportVideoWith *)aimageWithName;
- (CGSize)pg_imageContentModeWithplayImageView:(UILabel *)aplayImageView dailyTrainChapter:(UIEdgeInsets)adailyTrainChapter;
- (NSLineBreakMode)pg_requestReloadIgnoringWithimageCompressionRules:(UIFont *)aimageCompressionRules reusableCellWith:(UIFont *)areusableCellWith;
- (UITextFieldViewMode)pg_likesTableViewWithcontrolEventTouch:(UIView *)acontrolEventTouch userInfoHeader:(UIButtonType)auserInfoHeader;
+ (void)instanceCreateMethod; 

@end