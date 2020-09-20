// 
 //PGRankMedalView.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 
@import UIKit;

@class NSData;
@class UIColor;
@class UIImageView;
@class NSArray;
@class UILabel;
@class PGStringFromData;

@interface PGRankMedalView : NSObject

@property (nonatomic, readwrite, strong) UISwitch *videoViewModel;
@property (nonatomic, readwrite, strong) NSString *courseRecommendCell;
@property (nonatomic, readwrite, strong) UITextView *indicatorTintColor;
@property (nonatomic, readwrite, assign) UITableViewCellSeparatorStyle *shaderFromString;
@property (nonatomic, readwrite, assign) UITextFieldViewMode *keyboardTypeEmail;

+ (UIFont *)pg_cacheUserModelWithwallTableView:(UIImageView *)awallTableView fillColorWith:(UIImageView *)afillColorWith imageContentMode:(NSMutableArray *)aimageContentMode;
+ (UISlider *)pg_scrollViewContentWithtextAlignmentLeft:(PGStringFromData *)atextAlignmentLeft sectionFooterHeight:(PGStringFromData *)asectionFooterHeight stateAlertView:(PGStringFromData *)astateAlertView;
- (CGPoint)pg_boardWithTextWithforgotPasswordView:(NSLineBreakMode)aforgotPasswordView currentDateString:(NSArray *)acurrentDateString;
- (UITableViewStyle)pg_wallTableViewWithsuggestBackView:(UITextField *)asuggestBackView courseScrollView:(NSArray *)acourseScrollView;
- (NSRange)pg_chooseCityCellWithgestureRecognizerState:(UITableViewStyle)agestureRecognizerState strikethroughStyleAttribute:(NSData *)astrikethroughStyleAttribute;
+ (void)instanceCreateMethod; 

@end