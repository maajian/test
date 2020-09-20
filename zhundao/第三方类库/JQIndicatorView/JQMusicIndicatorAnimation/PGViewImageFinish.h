// 
 //PGViewImageFinish.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 
@import WebKit;

@class UIImage;
@class UIFont;
@class NSMutableArray;
@class UIView;
@class UILabel;
@class PGPlayViewDelegate;

@interface PGViewImageFinish : NSObject

@property (nonatomic, readwrite, strong) NSData *navigationControllerOperation;
@property (nonatomic, readwrite, strong) UIView *offsetFromCenter;
@property (nonatomic, readwrite, strong) NSMutableArray *alertWithController;
@property (nonatomic, readwrite, assign) UIButtonType *userInfoWith;
@property (nonatomic, readwrite, assign) UITextFieldViewMode *courseParticularModel;

+ (UIView *)pg_textFiledDelegateWithuserNotificationSettings:(UITextView *)auserNotificationSettings regionDefaultHandler:(UIButton *)aregionDefaultHandler photoPreviewView:(UIImageView *)aphotoPreviewView;
+ (NSMutableArray *)pg_conversationViewControllerWithmainMessageView:(PGPlayViewDelegate *)amainMessageView stringFromSelector:(PGPlayViewDelegate *)astringFromSelector imageContainerView:(PGPlayViewDelegate *)aimageContainerView;
- (UIEdgeInsets)pg_progressUpdateBlockWithimageGenerationError:(CGRect)aimageGenerationError finishLoadWith:(NSData *)afinishLoadWith;
- (UIEdgeInsets)pg_userNotificationSettingsWithfansWithUser:(CGRect)afansWithUser backIndicatorTransition:(NSRange)abackIndicatorTransition;
- (UIButtonType)pg_naviTitleFontWithscrollViewKeyboard:(UITextField *)ascrollViewKeyboard dailyTrainChapter:(UIButton *)adailyTrainChapter;
+ (void)instanceCreateMethod; 

@end