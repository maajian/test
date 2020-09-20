// 
 //PGSendCommentView.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 
@import WebKit;

@class UIImage;
@class UITextView;
@class NSData;
@class UIImageView;
@class UILabel;
@class UISlider;
@class PGPathWithRounded;

@interface PGSendCommentView : NSObject

@property (nonatomic, readwrite, strong) UILabel *articleOriginalHeader;
@property (nonatomic, readwrite, strong) UIImageView *playerStatePlaying;
@property (nonatomic, readwrite, strong) UIView *titleWithStatus;
@property (nonatomic, readwrite, assign) NSLineBreakMode *orientationLandscapeConstraint;
@property (nonatomic, readwrite, assign) CGRect *circleItemPhoto;

+ (UITextView *)pg_cellWithReuseWithpickerColletionView:(UIFont *)apickerColletionView integralRecordTable:(UIImage *)aintegralRecordTable birthdayPickerView:(UIScrollView *)abirthdayPickerView;
+ (UILabel *)pg_shrinkRightBottomWithviewControllerContext:(PGPathWithRounded *)aviewControllerContext collectionViewController:(PGPathWithRounded *)acollectionViewController suggestBackView:(PGPathWithRounded *)asuggestBackView;
- (UITableViewStyle)pg_contextDrawImageWithnumberBadgeWith:(UIButton *)anumberBadgeWith modalPresentationOver:(UIEdgeInsets)amodalPresentationOver;
- (CGRect)pg_playViewModelWithforgotPasswordView:(UITableView *)aforgotPasswordView underlineStyleSingle:(UIButton *)aunderlineStyleSingle;
- (NSLineBreakMode)pg_couponsInfoDataWithtransitRouteSearch:(UIButton *)atransitRouteSearch controlStateNormal:(UITableView *)acontrolStateNormal;
+ (void)instanceCreateMethod; 

@end