// 
 //PGInputButtonTitle.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 
@import UIKit;
@import WebKit;

@class UITextView;
@class NSString;
@class UIButton;
@class UIImageView;
@class NSMutableArray;
@class NSArray;
@class UIView;
@class UILabel;
@class PGScreenViewController;

@interface PGInputButtonTitle : NSObject

@property (nonatomic, readwrite, strong) UIColor *audioSessionRoute;
@property (nonatomic, readwrite, strong) UITableView *registerViewController;
@property (nonatomic, readwrite, strong) UIImageView *objectWithTitle;
@property (nonatomic, readwrite, assign) CGPoint *circleScreenView;
@property (nonatomic, readwrite, assign) NSRange *typeLivePhoto;

+ (UIButton *)pg_imagePickerConfigWithsecondeMallView:(UIImage *)asecondeMallView stringUsingEncoding:(UITextField *)astringUsingEncoding titleShowStatus:(UITableView *)atitleShowStatus;
+ (UITextField *)pg_articleDailyTrainWithuploadVideoBlock:(PGScreenViewController *)auploadVideoBlock fromVideoView:(PGScreenViewController *)afromVideoView circleItemPhoto:(PGScreenViewController *)acircleItemPhoto;
- (NSTextAlignment)pg_scrollViewKeyboardWithselectTypeUser:(UILabel *)aselectTypeUser assetPropertyDuration:(NSRange)aassetPropertyDuration;
- (UITableViewStyle)pg_sectionHeaderHeightWithcouponAlertView:(UISlider *)acouponAlertView sendCommentView:(UIActivityIndicatorView *)asendCommentView;
- (CGPoint)pg_badgeAnimTypeWithindicatorViewColor:(NSLineBreakMode)aindicatorViewColor baseTableView:(CGSize)abaseTableView;
+ (void)instanceCreateMethod; 

@end