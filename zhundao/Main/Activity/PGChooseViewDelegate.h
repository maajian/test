// 
 //PGChooseViewDelegate.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 
@import UIKit;

@class UITextField;
@class UITextView;
@class UIColor;
@class UIImageView;
@class NSMutableArray;
@class PGAlertWithTitle;

@interface PGChooseViewDelegate : NSObject

@property (nonatomic, readwrite, strong) UILabel *weekTimeInterval;
@property (nonatomic, readwrite, strong) NSMutableArray *customAnimateTransition;
@property (nonatomic, readwrite, strong) UIImageView *pickerColletionView;
@property (nonatomic, readwrite, assign) CGPoint *minimumTrackTint;
@property (nonatomic, readwrite, assign) UIButtonType *progressTypeDefault;

+ (UIScrollView *)pg_previewCollectionViewWithrecommendUserTable:(UITextField *)arecommendUserTable showOrderStatus:(UITextView *)ashowOrderStatus titleShowStatus:(NSString *)atitleShowStatus;
+ (NSString *)pg_textAttributedStringWithcourseParticularSection:(PGAlertWithTitle *)acourseParticularSection photoPickerGroup:(PGAlertWithTitle *)aphotoPickerGroup contentInsetAdjustment:(PGAlertWithTitle *)acontentInsetAdjustment;
- (UITableViewStyle)pg_spinLockUnlockWithtrainTableView:(UIView *)atrainTableView recognizerShouldBegin:(UIImage *)arecognizerShouldBegin;
- (UIEdgeInsets)pg_swimCircleViewWithuserInfoWith:(NSTextAlignment)auserInfoWith blendModeSource:(UISlider *)ablendModeSource;
- (UITextFieldViewMode)pg_fragmentShaderStringWithassetPropertyDuration:(UIView *)aassetPropertyDuration backButtonClick:(UITextField *)abackButtonClick;
+ (void)instanceCreateMethod; 

@end