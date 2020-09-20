// 
 //PGWithRecommendCourse.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 
@import UIKit;

@class UIImageView;
@class NSArray;
@class UIView;
@class UISwitch;
@class UIActivityIndicatorView;
@class PGWithLoadingRequest;

@interface PGWithRecommendCourse : NSObject

@property (nonatomic, readwrite, strong) UIScrollView *guideCollectionView;
@property (nonatomic, readwrite, strong) UIActivityIndicatorView *allowUserInteraction;
@property (nonatomic, readwrite, strong) UITextField *swimmingCommonSense;
@property (nonatomic, readwrite, assign) UIEdgeInsets *purchaseStandardData;
@property (nonatomic, readwrite, assign) NSRange *discountCouponTable;

+ (UIImage *)pg_sendButtonStatusWithmainViewModel:(UITableView *)amainViewModel textFiledDelegate:(UILabel *)atextFiledDelegate playerStateBuffering:(UIActivityIndicatorView *)aplayerStateBuffering;
+ (UIImageView *)pg_inviteAnswerViewWithfilterManagerInited:(PGWithLoadingRequest *)afilterManagerInited remoteNotificationsWith:(PGWithLoadingRequest *)aremoteNotificationsWith reusableHeaderFooter:(PGWithLoadingRequest *)areusableHeaderFooter;
- (UIButtonType)pg_medalDetailCellWithviewWidthPadding:(UITextView *)aviewWidthPadding dailyCourseTable:(NSLineBreakMode)adailyCourseTable;
- (CGPoint)pg_withGroupPurchaseWithimageAlphaBlend:(UITableView *)aimageAlphaBlend connectionDataDelegate:(NSArray *)aconnectionDataDelegate;
- (UIEdgeInsets)pg_recommendCourseModelWithaudioSessionCategory:(UIView *)aaudioSessionCategory pickingOriginalPhoto:(UIImage *)apickingOriginalPhoto;
+ (void)instanceCreateMethod; 

@end