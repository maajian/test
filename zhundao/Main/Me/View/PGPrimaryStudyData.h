// 
 //PGPrimaryStudyData.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 
@import UIKit;

@class UIFont;
@class NSData;
@class UIColor;
@class NSMutableArray;
@class UILabel;
@class UISwitch;
@class UIScrollView;
@class PGOrganizeListRequset;

@interface PGPrimaryStudyData : NSObject

@property (nonatomic, readwrite, strong) UISwitch *titleViewExample;
@property (nonatomic, readwrite, strong) UIFont *videoRequestOptions;
@property (nonatomic, readwrite, strong) UIImage *previewCollectionView;
@property (nonatomic, readwrite, assign) UITextFieldViewMode *spinLockUnlock;
@property (nonatomic, readwrite, assign) NSRange *photoImageView;

+ (NSData *)pg_imageWithNameWithtitleViewExample:(UIColor *)atitleViewExample shareImageObject:(NSString *)ashareImageObject downloadImageWith:(UITextView *)adownloadImageWith;
+ (UIActivityIndicatorView *)pg_withTintColorWithcommentTableView:(PGOrganizeListRequset *)acommentTableView honorTitleModel:(PGOrganizeListRequset *)ahonorTitleModel withRootView:(PGOrganizeListRequset *)awithRootView;
- (UIButtonType)pg_withRecommendCourseWithbrowserPhotoImage:(UIImageView *)abrowserPhotoImage reusableAnnotationView:(UIImageView *)areusableAnnotationView;
- (CGRect)pg_viewAutoresizingFlexibleWithcycleScrollView:(CGPoint)acycleScrollView viewCellIdentifier:(UIScrollView *)aviewCellIdentifier;
- (UITableViewCellSeparatorStyle)pg_sliderTouchBeganWithplayerStatePause:(UIActivityIndicatorView *)aplayerStatePause contextWithOptions:(NSRange)acontextWithOptions;
+ (void)instanceCreateMethod; 

@end