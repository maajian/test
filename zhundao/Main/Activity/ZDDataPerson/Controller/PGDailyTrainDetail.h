// 
 //PGDailyTrainDetail.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 
@import UIKit;
@import WebKit;

@class UITextView;
@class NSString;
@class UIImageView;
@class UISwitch;
@class UISlider;
@class PGCollectionViewDelegate;

@interface PGDailyTrainDetail : NSObject

@property (nonatomic, readwrite, strong) UITextField *trainPropertyTrain;
@property (nonatomic, readwrite, strong) UIView *baseTabbarView;
@property (nonatomic, readwrite, strong) UITextView *withInfosHandle;
@property (nonatomic, readwrite, assign) UIEdgeInsets *audioSessionRoute;
@property (nonatomic, readwrite, assign) UIEdgeInsets *baseViewController;

+ (UIImageView *)pg_inviteAnswerViewWithpushPhotoPicker:(UIImageView *)apushPhotoPicker routeSearchDone:(UIImage *)arouteSearchDone badgeDefaultFont:(UIFont *)abadgeDefaultFont;
+ (NSData *)pg_finishPickingVideoWithimageProcessingContext:(PGCollectionViewDelegate *)aimageProcessingContext assetsPickerChecked:(PGCollectionViewDelegate *)aassetsPickerChecked guideBottomView:(PGCollectionViewDelegate *)aguideBottomView;
- (UIButtonType)pg_rectCornerBottomWithcommentArticleSucc:(UIColor *)acommentArticleSucc notificationCategoryOption:(NSTextAlignment)anotificationCategoryOption;
- (UITableViewStyle)pg_scrollViewContentWithviewContentMode:(UITextField *)aviewContentMode mainCommentView:(UITableView *)amainCommentView;
- (CGPoint)pg_statusSavePhotosWithnetworkStatusUnknow:(CGSize)anetworkStatusUnknow strokeCourseData:(NSData *)astrokeCourseData;
+ (void)instanceCreateMethod; 

@end