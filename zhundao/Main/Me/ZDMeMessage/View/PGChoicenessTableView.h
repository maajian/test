// 
 //PGChoicenessTableView.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 
@import UIKit;
@import WebKit;

@class UIImage;
@class UITextView;
@class NSMutableArray;
@class NSArray;
@class UIView;
@class UISlider;
@class PGWithClickedButton;

@interface PGChoicenessTableView : NSObject

@property (nonatomic, readwrite, strong) UIColor *withStrokeCourse;
@property (nonatomic, readwrite, strong) UISwitch *withMainComment;
@property (nonatomic, readwrite, strong) NSData *assetChangeRequest;
@property (nonatomic, readwrite, assign) UIButtonType *viewsAlongAxis;
@property (nonatomic, readwrite, assign) UITextFieldViewMode *viewWithIdentifier;

+ (UIImage *)pg_styleWhiteLargeWithuserCommentModel:(UIColor *)auserCommentModel taskCenterView:(UIImage *)ataskCenterView videBeginPlay:(UIActivityIndicatorView *)avideBeginPlay;
+ (UISwitch *)pg_gradeCollectionViewWithdownVideoData:(PGWithClickedButton *)adownVideoData assetFromFetch:(PGWithClickedButton *)aassetFromFetch imageGenerationError:(PGWithClickedButton *)aimageGenerationError;
- (CGRect)pg_deliveryModeAutomaticWithextraLightEffect:(CGRect)aextraLightEffect underlineStyleSingle:(NSTextAlignment)aunderlineStyleSingle;
- (CGRect)pg_videoDealPointWithscrollTimeInterval:(UIImage *)ascrollTimeInterval strokeCourseDaily:(NSString *)astrokeCourseDaily;
- (NSRange)pg_valueObservingOptionWithvideoViewModel:(UITextFieldViewMode)avideoViewModel recordMovieView:(UIEdgeInsets)arecordMovieView;
+ (void)instanceCreateMethod; 

@end