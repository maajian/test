// 
 //PGMutableTrackWith.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 
@import UIKit;
@import WebKit;

@class UIImage;
@class UITextField;
@class NSData;
@class UIColor;
@class UIImageView;
@class UIActivityIndicatorView;
@class PGRewardTypeNone;

@interface PGMutableTrackWith : NSObject

@property (nonatomic, readwrite, strong) UIActivityIndicatorView *courseScrollView;
@property (nonatomic, readwrite, strong) UIColor *naviTitleFont;
@property (nonatomic, readwrite, strong) NSMutableArray *answersTableView;
@property (nonatomic, readwrite, assign) UIEdgeInsets *tableFooterView;
@property (nonatomic, readwrite, assign) UITableViewStyle *loginViewController;

+ (UIScrollView *)pg_discoverTableViewWithmainCommentModel:(UIImage *)amainCommentModel organizeServiceModel:(NSString *)aorganizeServiceModel chatInputAble:(UIFont *)achatInputAble;
+ (UIButton *)pg_couponAlertViewWithcurrentDateString:(PGRewardTypeNone *)acurrentDateString userInfoWith:(PGRewardTypeNone *)auserInfoWith tintEffectWith:(PGRewardTypeNone *)atintEffectWith;
- (NSTextAlignment)pg_codeLoginViewWithdifferenceValueWith:(UITextField *)adifferenceValueWith trainFinishAlert:(UIScrollView *)atrainFinishAlert;
- (NSTextAlignment)pg_beginFromCurrentWithcellWithIndex:(UIScrollView *)acellWithIndex medalViewModel:(UITableViewStyle)amedalViewModel;
- (UIButtonType)pg_weekTimeLabelWithwithCourseVideo:(NSLineBreakMode)awithCourseVideo mainViewController:(UITextFieldViewMode)amainViewController;
+ (void)instanceCreateMethod; 

@end