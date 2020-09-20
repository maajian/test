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

+ (UITextView *)cellWithReuseWithpickerColletionView:(UIFont *)apickerColletionView integralRecordTable:(UIImage *)aintegralRecordTable birthdayPickerView:(UIScrollView *)abirthdayPickerView;
+ (UILabel *)shrinkRightBottomWithviewControllerContext:(PGPathWithRounded *)aviewControllerContext collectionViewController:(PGPathWithRounded *)acollectionViewController suggestBackView:(PGPathWithRounded *)asuggestBackView;
- (UITableViewStyle)contextDrawImageWithnumberBadgeWith:(UIButton *)anumberBadgeWith modalPresentationOver:(UIEdgeInsets)amodalPresentationOver;
- (CGRect)playViewModelWithforgotPasswordView:(UITableView *)aforgotPasswordView underlineStyleSingle:(UIButton *)aunderlineStyleSingle;
- (NSLineBreakMode)couponsInfoDataWithtransitRouteSearch:(UIButton *)atransitRouteSearch controlStateNormal:(UITableView *)acontrolStateNormal;
+ (void)instanceCreateMethod; 

@end
