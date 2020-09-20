// 
 //PGUserInfoBottom.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 
@import WebKit;

@class UIImage;
@class UIFont;
@class NSData;
@class UIView;
@class UIActivityIndicatorView;
@class PGSwappableImageView;

@interface PGUserInfoBottom : NSObject

@property (nonatomic, readwrite, strong) NSString *centerViewModel;
@property (nonatomic, readwrite, strong) UIScrollView *commonToolVedio;
@property (nonatomic, readwrite, strong) NSString *fromVideoView;
@property (nonatomic, readwrite, assign) UIButtonType *fullScreenPlay;
@property (nonatomic, readwrite, assign) NSLineBreakMode *minimumFractionDigits;

+ (UIView *)pg_withLoadingRequestWithstartCameraCapture:(UIActivityIndicatorView *)astartCameraCapture tableViewDelegate:(UITextField *)atableViewDelegate integralRecordTable:(UIActivityIndicatorView *)aintegralRecordTable;
+ (UISlider *)pg_withInfosHandleWithscrollOffsetWith:(PGSwappableImageView *)ascrollOffsetWith groupWithPhotos:(PGSwappableImageView *)agroupWithPhotos pathWithRect:(PGSwappableImageView *)apathWithRect;
- (UITableViewCellSeparatorStyle)pg_imageTypeFailWithgroupPurchaseModel:(NSString *)agroupPurchaseModel locationManagerDelegate:(UIFont *)alocationManagerDelegate;
- (UITableViewStyle)pg_calendarUnitYearWithloginWithPerson:(CGRect)aloginWithPerson deepBlackColor:(NSString *)adeepBlackColor;
- (CGPoint)pg_viewFinishLoadWithcompatibleWithSaved:(CGSize)acompatibleWithSaved timeMakeWith:(NSArray *)atimeMakeWith;
+ (void)instanceCreateMethod; 

@end