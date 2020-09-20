// 
 //PGVideoWithScroll.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 
@import UIKit;

@class UIColor;
@class NSString;
@class UIView;
@class UILabel;
@class UIScrollView;
@class PGOutsideImageView;

@interface PGVideoWithScroll : NSObject

@property (nonatomic, readwrite, strong) UITextField *imagePickerConfig;
@property (nonatomic, readwrite, strong) UIColor *trainInfoView;
@property (nonatomic, readwrite, strong) NSArray *alertActionStyle;
@property (nonatomic, readwrite, assign) NSLineBreakMode *assetChangeRequest;
@property (nonatomic, readwrite, assign) CGPoint *matchTableView;

+ (UIColor *)pg_fullScreenPlayWithrouteChangeListener:(UIButton *)arouteChangeListener selectPhotoBlock:(NSArray *)aselectPhotoBlock authorizationWithCompletion:(UITextView *)aauthorizationWithCompletion;
+ (NSMutableArray *)pg_cardViewDelegateWithtaskCenterCell:(PGOutsideImageView *)ataskCenterCell loginWithPerson:(PGOutsideImageView *)aloginWithPerson errorWithStatus:(PGOutsideImageView *)aerrorWithStatus;
- (NSTextAlignment)pg_pickerViewShowWithphotosDelegateWith:(UISlider *)aphotosDelegateWith colorSpaceCreate:(UITableView *)acolorSpaceCreate;
- (NSLineBreakMode)pg_locationViewModelWithimageSharpenFilter:(UITextField *)aimageSharpenFilter reusableSupplementaryView:(UIActivityIndicatorView *)areusableSupplementaryView;
- (UITableViewCellSeparatorStyle)pg_titleLabelSelectededWithcouponsAlertView:(NSRange)acouponsAlertView videoRequestTask:(UIButtonType)avideoRequestTask;
+ (void)instanceCreateMethod; 

@end