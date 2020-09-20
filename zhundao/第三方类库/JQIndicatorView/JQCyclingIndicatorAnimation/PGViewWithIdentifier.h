// 
 //PGViewWithIdentifier.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 

@class UIImage;
@class UIFont;
@class NSData;
@class UIButton;
@class NSMutableArray;
@class UIActivityIndicatorView;
@class PGRecommendUserTable;

@interface PGViewWithIdentifier : NSObject

@property (nonatomic, readwrite, strong) UIImageView *answerViewModel;
@property (nonatomic, readwrite, strong) UITextField *differenceBetweenRect;
@property (nonatomic, readwrite, strong) UIColor *noticeTypeReady;
@property (nonatomic, readwrite, assign) NSRange *locationWithGeocoder;
@property (nonatomic, readwrite, assign) CGRect *withSelectedAssets;

+ (UIScrollView *)pg_playChapterIndexWithdeviceOrientationPortrait:(NSString *)adeviceOrientationPortrait authorizationOptionSound:(UITableView *)aauthorizationOptionSound styleLightContent:(UIActivityIndicatorView *)astyleLightContent;
+ (UIActivityIndicatorView *)pg_circleItemPhotoWithintegralStoreView:(PGRecommendUserTable *)aintegralStoreView underlineStyleAttribute:(PGRecommendUserTable *)aunderlineStyleAttribute integralRecordData:(PGRecommendUserTable *)aintegralRecordData;
- (UIEdgeInsets)pg_keyboardTypeNumberWithvideoPreviewCell:(NSRange)avideoPreviewCell cyclingLineAnimation:(UITextView *)acyclingLineAnimation;
- (UIEdgeInsets)pg_viewContentModeWithticketRightLabel:(UITextFieldViewMode)aticketRightLabel centerButtonClick:(UIEdgeInsets)acenterButtonClick;
- (CGPoint)pg_sessionTaskStateWithbrowserPhotoView:(CGSize)abrowserPhotoView medalExplainView:(UIEdgeInsets)amedalExplainView;
+ (void)instanceCreateMethod; 

@end