// 
 //PGReceiveVideoData.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 

@class UIFont;
@class NSData;
@class UIButton;
@class UIScrollView;
@class UISlider;
@class PGLoginWithPhone;

@interface PGReceiveVideoData : NSObject

@property (nonatomic, readwrite, strong) UIImage *uploadVideoBlock;
@property (nonatomic, readwrite, strong) UILabel *tweetItemModel;
@property (nonatomic, readwrite, strong) NSMutableArray *recordListWith;
@property (nonatomic, readwrite, assign) NSRange *alertWithController;
@property (nonatomic, readwrite, assign) UIEdgeInsets *settingViewController;

+ (UIActivityIndicatorView *)pg_withVideosDataWithassetResourceType:(NSMutableArray *)aassetResourceType contextStrokePath:(NSMutableArray *)acontextStrokePath withLongLong:(UITextView *)awithLongLong;
+ (UIButton *)pg_recordMovieBottomWithlikesTableView:(PGLoginWithPhone *)alikesTableView viewAnimatedColors:(PGLoginWithPhone *)aviewAnimatedColors firstBackCamera:(PGLoginWithPhone *)afirstBackCamera;
- (UITableViewCellSeparatorStyle)pg_registerViewControllerWithcancelCollectionCourse:(UIFont *)acancelCollectionCourse reusablePhotoView:(NSData *)areusablePhotoView;
- (UITextFieldViewMode)pg_playerStatusFailedWithassetCameraCell:(UITableViewStyle)aassetCameraCell blockCropMode:(UISwitch *)ablockCropMode;
- (NSRange)pg_rankMedalHeaderWithfinishPickingVideo:(UISwitch *)afinishPickingVideo textViewDelegate:(UISwitch *)atextViewDelegate;
+ (void)instanceCreateMethod; 

@end