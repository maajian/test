// 
 //PGSenseViewModel.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 
@import WebKit;

@class UIImage;
@class NSData;
@class NSMutableArray;
@class UIView;
@class UISlider;
@class PGSelectPhotoBrowser;

@interface PGSenseViewModel : NSObject

@property (nonatomic, readwrite, strong) UIImageView *dailyTrainHeader;
@property (nonatomic, readwrite, strong) UITableView *autoClipImage;
@property (nonatomic, readwrite, strong) UIImage *pickerColletionView;
@property (nonatomic, readwrite, assign) NSLineBreakMode *captureSessionPreset;
@property (nonatomic, readwrite, assign) UITextFieldViewMode *courseVideoPlayed;

+ (NSString *)pg_alowGroupPurchaseWithcollectionWithOffset:(UIView *)acollectionWithOffset buttonClickBlock:(UITableView *)abuttonClickBlock readingAllowFragments:(UIImageView *)areadingAllowFragments;
+ (UIImage *)pg_showPhotoPickerWithintegralRecordTable:(PGSelectPhotoBrowser *)aintegralRecordTable fetchLoginInfo:(PGSelectPhotoBrowser *)afetchLoginInfo strokeCourseSecond:(PGSelectPhotoBrowser *)astrokeCourseSecond;
- (UITextFieldViewMode)pg_couseFinishAlertWithimageFromType:(UIView *)aimageFromType pointerFunctionsOptions:(UILabel *)apointerFunctionsOptions;
- (CGSize)pg_taskCenterTableWithswimingCommonSense:(UIEdgeInsets)aswimingCommonSense lineBreakMode:(UITableViewCellSeparatorStyle)alineBreakMode;
- (UITableViewStyle)pg_cachingImageManagerWithrectContainsPoint:(CGSize)arectContainsPoint activityTableView:(NSRange)aactivityTableView;
+ (void)instanceCreateMethod; 

@end