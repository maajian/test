// 
 //PGAssetsWithOptions.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 
@import UIKit;
@import WebKit;

@class UIImage;
@class UITableView;
@class UITextField;
@class UITextView;
@class UIColor;
@class NSMutableArray;
@class NSArray;
@class UILabel;
@class PGCourseParticularTable;

@interface PGAssetsWithOptions : NSObject

@property (nonatomic, readwrite, strong) NSData *moviePlayView;
@property (nonatomic, readwrite, strong) UIFont *windowLevelAlert;
@property (nonatomic, readwrite, strong) UITextField *swimCircleService;
@property (nonatomic, readwrite, assign) UITableViewCellSeparatorStyle *trainFinishAlert;
@property (nonatomic, readwrite, assign) NSLineBreakMode *pushPhotoPicker;

+ (UIButton *)pg_currentMediaTimeWithassetCellType:(UIImageView *)aassetCellType connectionDataDelegate:(UIColor *)aconnectionDataDelegate lineJoinMiter:(UIImageView *)alineJoinMiter;
+ (UIButton *)pg_groupPurchaseOrderWithviewContentOffset:(PGCourseParticularTable *)aviewContentOffset dailyTrainData:(PGCourseParticularTable *)adailyTrainData assetFromFetch:(PGCourseParticularTable *)aassetFromFetch;
- (UIButtonType)pg_textFieldViewWithpresetsCompatibleWith:(UISlider *)apresetsCompatibleWith calendarUnitYear:(CGPoint)acalendarUnitYear;
- (NSLineBreakMode)pg_applicationLaunchOptionsWithcouponsInfoData:(NSMutableArray *)acouponsInfoData viewContentOffset:(NSRange)aviewContentOffset;
- (CGPoint)pg_videoImageExtractorWithwithRootView:(CGPoint)awithRootView imageProcessingContext:(UITableViewCellSeparatorStyle)aimageProcessingContext;
+ (void)instanceCreateMethod; 

@end