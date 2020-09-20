// 
 //PGWithContainerSize.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 
@import UIKit;

@class UIImage;
@class UIButton;
@class NSArray;
@class UIView;
@class UIActivityIndicatorView;
@class PGFriendsViewModel;

@interface PGWithContainerSize : NSObject

@property (nonatomic, readwrite, strong) UILabel *baseViewController;
@property (nonatomic, readwrite, strong) UIScrollView *keyboardWillShow;
@property (nonatomic, readwrite, strong) NSArray *trainInfoView;
@property (nonatomic, readwrite, assign) UITableViewCellSeparatorStyle *loginWithUser;
@property (nonatomic, readwrite, assign) UIButtonType *circleCommentTable;

+ (UIImage *)pg_frameWithIndexWithlineBreakMode:(UIImageView *)alineBreakMode sliderValueChanged:(NSData *)asliderValueChanged lineDashType:(UIImage *)alineDashType;
+ (UIButton *)pg_mainMessageDataWithfullScreenPlay:(PGFriendsViewModel *)afullScreenPlay swimRecordData:(PGFriendsViewModel *)aswimRecordData authorizationOptionBadge:(PGFriendsViewModel *)aauthorizationOptionBadge;
- (CGRect)pg_changeFrameNotificationWithwithRenderingMode:(UITextView *)awithRenderingMode colorSpaceCreate:(UISwitch *)acolorSpaceCreate;
- (UIEdgeInsets)pg_exerciseParticularViewWithtrainsWithOffset:(UIImageView *)atrainsWithOffset choicenessVideoView:(NSLineBreakMode)achoicenessVideoView;
- (UITableViewCellSeparatorStyle)pg_mainViewControllerWithvideoPlayView:(NSArray *)avideoPlayView withRankMedal:(NSArray *)awithRankMedal;
+ (void)instanceCreateMethod; 

@end