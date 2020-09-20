// 
 //PGPickerViewData.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 
@import UIKit;

@class UIImage;
@class UITextField;
@class UIImageView;
@class UIView;
@class UILabel;
@class UIScrollView;
@class UISlider;
@class PGIntervalSinceDate;

@interface PGPickerViewData : NSObject

@property (nonatomic, readwrite, strong) UIImageView *shouldAutoClip;
@property (nonatomic, readwrite, strong) UIActivityIndicatorView *imageContentMode;
@property (nonatomic, readwrite, strong) NSArray *textAlignmentLeft;
@property (nonatomic, readwrite, assign) NSLineBreakMode *receiveLocalNotification;
@property (nonatomic, readwrite, assign) UITableViewCellSeparatorStyle *becomeActiveNotification;

+ (NSData *)pg_timesFromSliderWithstatusWithBlock:(UIView *)astatusWithBlock coachDetailWith:(NSString *)acoachDetailWith imageWithLeft:(UIColor *)aimageWithLeft;
+ (UITextView *)pg_scrollViewContentWithwithCourseSecond:(PGIntervalSinceDate *)awithCourseSecond rectWithSize:(PGIntervalSinceDate *)arectWithSize assetPreviewCell:(PGIntervalSinceDate *)aassetPreviewCell;
- (NSTextAlignment)pg_recommendUserTableWithtimerWithTime:(CGRect)atimerWithTime changePreviousRoute:(NSArray *)achangePreviousRoute;
- (NSTextAlignment)pg_showShowSheetWithrankMedalInfo:(UITableViewCellSeparatorStyle)arankMedalInfo courseParticularSection:(NSString *)acourseParticularSection;
- (UITableViewCellSeparatorStyle)pg_courseParticularViewWithcustomControlView:(NSTextAlignment)acustomControlView dataReadingMapped:(UIButtonType)adataReadingMapped;
+ (void)instanceCreateMethod; 

@end