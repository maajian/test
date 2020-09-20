// 
 //PGFirendsViewModel.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 
@import WebKit;

@class UIImage;
@class UITextView;
@class UIButton;
@class PGMovieTestView;

@interface PGFirendsViewModel : NSObject

@property (nonatomic, readwrite, strong) NSArray *keyboardAnimationDuration;
@property (nonatomic, readwrite, strong) UIImageView *playViewModel;
@property (nonatomic, readwrite, strong) UITextView *pushPhotoPicker;
@property (nonatomic, readwrite, assign) UITableViewCellSeparatorStyle *photoPrevireView;
@property (nonatomic, readwrite, assign) UITextFieldViewMode *statusCameraRoll;

+ (NSData *)pg_playerStatusFailedWithhidesWhenStopped:(UISwitch *)ahidesWhenStopped sliderTouchDown:(UIFont *)asliderTouchDown swimRecordData:(UIActivityIndicatorView *)aswimRecordData;
+ (UIColor *)pg_groupTableViewWithnameLeftLabel:(PGMovieTestView *)anameLeftLabel fromVideoFile:(PGMovieTestView *)afromVideoFile paragraphStyleAttribute:(PGMovieTestView *)aparagraphStyleAttribute;
- (CGRect)pg_vertexAttribPointerWithrouteChangeListener:(UITableViewStyle)arouteChangeListener showFullButton:(CGPoint)ashowFullButton;
- (NSLineBreakMode)pg_selectPhotoAssetsWithaudioPlayerDelegate:(NSRange)aaudioPlayerDelegate lightBlackColor:(UITextView *)alightBlackColor;
- (UITableViewCellSeparatorStyle)pg_swimFriendsViewWithchooseStadiumTable:(UIButtonType)achooseStadiumTable photoPrevireView:(NSTextAlignment)aphotoPrevireView;
+ (void)instanceCreateMethod; 

@end