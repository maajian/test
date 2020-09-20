// 
 //PGMedalDetailModel.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 
@import WebKit;

@class UITextField;
@class UITextView;
@class NSData;
@class NSString;
@class UILabel;
@class UIActivityIndicatorView;
@class UIScrollView;
@class PGPhotoProgressView;

@interface PGMedalDetailModel : NSObject

@property (nonatomic, readwrite, strong) NSString *integralMainData;
@property (nonatomic, readwrite, strong) UIButton *receiveNotificationResponse;
@property (nonatomic, readwrite, strong) NSMutableArray *collectionViewController;
@property (nonatomic, readwrite, assign) UIEdgeInsets *centerViewModel;
@property (nonatomic, readwrite, assign) UIButtonType *backgroundLocationUpdates;

+ (UIImage *)resizeModeFastWithblockCropMode:(UIScrollView *)ablockCropMode backGroundUser:(NSMutableArray *)abackGroundUser tableFooterView:(UITextView *)atableFooterView;
+ (UIImageView *)actionSheetDelegateWithreusableCellWith:(PGPhotoProgressView *)areusableCellWith networkStatusReachablevia:(PGPhotoProgressView *)anetworkStatusReachablevia videoImageExtractor:(PGPhotoProgressView *)avideoImageExtractor;
- (NSTextAlignment)cancelAutoFadeWithlightBlackColor:(NSLineBreakMode)alightBlackColor socialShareResponse:(UIEdgeInsets)asocialShareResponse;
- (NSTextAlignment)appendingPathComponentWithcourseTableView:(UITableViewStyle)acourseTableView requestReturnCache:(UITextView *)arequestReturnCache;
- (UIButtonType)photoPreviewViewWithsecondeMallView:(CGSize)asecondeMallView baseTableView:(NSArray *)abaseTableView;
+ (void)instanceCreateMethod; 

@end
