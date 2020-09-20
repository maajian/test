// 
 //PGTypeCreatePreferred.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 
@import UIKit;
@import WebKit;

@class UIImage;
@class UITextField;
@class UITextView;
@class NSArray;
@class UISlider;
@class PGUpdateUserLocation;

@interface PGTypeCreatePreferred : NSObject

@property (nonatomic, readwrite, strong) UIFont *adjustsScrollView;
@property (nonatomic, readwrite, strong) NSMutableArray *medalExplainView;
@property (nonatomic, readwrite, strong) UIView *withActivityIndicator;
@property (nonatomic, readwrite, assign) NSLineBreakMode *swimCircleItem;
@property (nonatomic, readwrite, assign) UITableViewStyle *groupWithVideos;

+ (UITextView *)pg_attentionViewModelWithmedalDetailCell:(UIFont *)amedalDetailCell linkViewModel:(UIFont *)alinkViewModel showingPhotoView:(UIView *)ashowingPhotoView;
+ (UILabel *)pg_backgroundLocationUpdatesWithauthorizationOptionAlert:(PGUpdateUserLocation *)aauthorizationOptionAlert rankMedalInfo:(PGUpdateUserLocation *)arankMedalInfo imageSharpenFilter:(PGUpdateUserLocation *)aimageSharpenFilter;
- (NSLineBreakMode)pg_playerWithPathWithcouseFinishAlert:(UIButtonType)acouseFinishAlert downLoadData:(CGSize)adownLoadData;
- (UIButtonType)pg_wechatTimeLineWithshowFullButton:(UIImageView *)ashowFullButton replayUserNick:(UIEdgeInsets)areplayUserNick;
- (NSLineBreakMode)pg_currentViewControllerWithswimRecordData:(UIColor *)aswimRecordData discountCouponView:(UIView *)adiscountCouponView;
+ (void)instanceCreateMethod; 

@end