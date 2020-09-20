// 
 //PGArticleOriginalData.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 
@import WebKit;

@class UIImage;
@class UIFont;
@class UIButton;
@class NSArray;
@class PGFailWithError;

@interface PGArticleOriginalData : NSObject

@property (nonatomic, readwrite, strong) NSArray *lineWithProgress;
@property (nonatomic, readwrite, strong) UILabel *choicenessViewController;
@property (nonatomic, readwrite, strong) UIImageView *currentPhotoIndex;
@property (nonatomic, readwrite, assign) NSLineBreakMode *thumbnailFromImage;
@property (nonatomic, readwrite, assign) NSRange *pressEmojiAction;

+ (UIColor *)pg_statusWithBlockWithcontentsUserReviews:(UITextView *)acontentsUserReviews audioSessionPort:(NSData *)aaudioSessionPort organizeListTable:(NSData *)aorganizeListTable;
+ (UIButton *)pg_tableViewDataWithdifferenceBetweenRect:(PGFailWithError *)adifferenceBetweenRect assetsUsingBlock:(PGFailWithError *)aassetsUsingBlock doneButtonClick:(PGFailWithError *)adoneButtonClick;
- (CGSize)pg_showControlViewWithselectPhotoNavigation:(UIFont *)aselectPhotoNavigation spinLockUnlock:(NSRange)aspinLockUnlock;
- (UIButtonType)pg_particularViewModelWithassetsPhotoWith:(UITableViewStyle)aassetsPhotoWith stateAlertView:(CGPoint)astateAlertView;
- (NSRange)pg_videoWithPathWithoperationWithBlock:(UIFont *)aoperationWithBlock shouldAutoClip:(UITextField *)ashouldAutoClip;
+ (void)instanceCreateMethod; 

@end