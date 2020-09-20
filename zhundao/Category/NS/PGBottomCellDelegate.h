// 
 //PGBottomCellDelegate.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 
@import UIKit;

@class UIView;
@class UIActivityIndicatorView;
@class PGViewFinishLoad;

@interface PGBottomCellDelegate : NSObject

@property (nonatomic, readwrite, strong) UITableView *withSwimParticular;
@property (nonatomic, readwrite, strong) NSMutableArray *dailyTrainData;
@property (nonatomic, readwrite, strong) NSData *imageOrientationDown;
@property (nonatomic, readwrite, assign) NSRange *answersTableView;
@property (nonatomic, readwrite, assign) UIButtonType *imageContainerView;

+ (UITextField *)pg_discoverTableViewWithrectContainsPoint:(UITextView *)arectContainsPoint swimmingCommonSense:(UIColor *)aswimmingCommonSense photoWithImage:(NSMutableArray *)aphotoWithImage;
+ (NSArray *)pg_withActionBlockWithfirstBackCamera:(PGViewFinishLoad *)afirstBackCamera socialUserInfo:(PGViewFinishLoad *)asocialUserInfo viewCellDelegate:(PGViewFinishLoad *)aviewCellDelegate;
- (UIEdgeInsets)pg_taskCenterViewWithcontextWithOptions:(UIImageView *)acontextWithOptions itemTextColor:(UIButton *)aitemTextColor;
- (NSTextAlignment)pg_originStatusBackgroundWithnetworkStatusReachablevia:(NSString *)anetworkStatusReachablevia textViewContent:(UIEdgeInsets)atextViewContent;
- (CGPoint)pg_articleOriginalModelWithcommentTweetSucc:(UIView *)acommentTweetSucc authorizationOptionAlert:(UITableViewCellSeparatorStyle)aauthorizationOptionAlert;
+ (void)instanceCreateMethod; 

@end