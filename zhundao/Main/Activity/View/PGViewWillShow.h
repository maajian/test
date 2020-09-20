// 
 //PGViewWillShow.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 

@class UITableView;
@class UITextField;
@class UIFont;
@class UITextView;
@class NSData;
@class UIColor;
@class NSString;
@class UIButton;
@class UIImageView;
@class NSMutableArray;
@class UIView;
@class UISwitch;
@class UIScrollView;
@class PGStartLoadWith;

@interface PGViewWillShow : NSObject

@property (nonatomic, readwrite, strong) UISlider *saveEmojiDictionary;
@property (nonatomic, readwrite, strong) UIActivityIndicatorView *currentPageColor;
@property (nonatomic, readwrite, strong) UITextField *networkReachabilityManager;
@property (nonatomic, readwrite, assign) UITableViewStyle *hidesWhenStopped;
@property (nonatomic, readwrite, assign) CGSize *buttonSettingBlock;

+ (UITextField *)pg_applicationStateActiveWithwithLocaleIdentifier:(NSString *)awithLocaleIdentifier medalKindModel:(UIColor *)amedalKindModel deviceSettingsType:(NSMutableArray *)adeviceSettingsType;
+ (UITextField *)pg_medalExplainViewWithframeWithIndex:(PGStartLoadWith *)aframeWithIndex recordVideoQuality:(PGStartLoadWith *)arecordVideoQuality fansWithUser:(PGStartLoadWith *)afansWithUser;
- (NSRange)pg_sliderFillColorWithoriginalPhotoWith:(UIColor *)aoriginalPhotoWith activityTableView:(NSTextAlignment)aactivityTableView;
- (CGPoint)pg_gradeBottomViewWithanimatedImageFrames:(UIImage *)aanimatedImageFrames withFragmentShader:(UIImage *)awithFragmentShader;
- (UITextFieldViewMode)pg_interfaceOrientationMaskWithblockWithResult:(UITextFieldViewMode)ablockWithResult videoWithScroll:(UILabel *)avideoWithScroll;
+ (void)instanceCreateMethod; 

@end