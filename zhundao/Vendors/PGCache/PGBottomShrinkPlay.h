// 
 //PGBottomShrinkPlay.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 
@import WebKit;

@class UIImage;
@class UITextField;
@class UIFont;
@class NSData;
@class UIColor;
@class UIImageView;
@class UIView;
@class UILabel;
@class UIActivityIndicatorView;
@class PGCollectionViewDelegate;

@interface PGBottomShrinkPlay : NSObject

@property (nonatomic, readwrite, strong) UIImage *listViewModel;
@property (nonatomic, readwrite, strong) UITableView *collectionTrainView;
@property (nonatomic, readwrite, strong) UISwitch *updateStatuOptional;
@property (nonatomic, readwrite, assign) UIEdgeInsets *swipeGestureRecognizer;
@property (nonatomic, readwrite, assign) NSRange *blockCropMode;

+ (UITextField *)pg_userCommentModelWithrefreshStatePulling:(UITableView *)arefreshStatePulling fromVideoView:(NSMutableArray *)afromVideoView authorizationStatusDenied:(UITextField *)aauthorizationStatusDenied;
+ (UIButton *)pg_imageRenderingModeWithnaviTitleAppearance:(PGCollectionViewDelegate *)anaviTitleAppearance javaScriptConfirm:(PGCollectionViewDelegate *)ajavaScriptConfirm recommendCellDelegate:(PGCollectionViewDelegate *)arecommendCellDelegate;
- (NSRange)pg_centerViewModelWithimageTypeFail:(NSData *)aimageTypeFail dailyCourseModel:(UIFont *)adailyCourseModel;
- (CGSize)pg_playerStreamInfoWithrefreshStateIdle:(UIView *)arefreshStateIdle trainParticularHeader:(CGSize)atrainParticularHeader;
- (NSTextAlignment)pg_recordVideoCameraWithnumberWithString:(CGSize)anumberWithString normalTableView:(UIButton *)anormalTableView;
+ (void)instanceCreateMethod; 

@end