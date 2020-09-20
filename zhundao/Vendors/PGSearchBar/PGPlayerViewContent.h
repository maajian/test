// 
 //PGPlayerViewContent.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 

@class UITextView;
@class NSString;
@class NSMutableArray;
@class NSArray;
@class UIView;
@class UISwitch;
@class UIActivityIndicatorView;
@class UISlider;
@class PGRecoderSelectPicker;

@interface PGPlayerViewContent : NSObject

@property (nonatomic, readwrite, strong) NSMutableArray *viewControllerContext;
@property (nonatomic, readwrite, strong) UIColor *withGradientTint;
@property (nonatomic, readwrite, strong) NSString *workStatusNofi;
@property (nonatomic, readwrite, assign) CGSize *locationViewController;
@property (nonatomic, readwrite, assign) UITableViewCellSeparatorStyle *pushNotificationTrigger;

+ (UIImageView *)pg_guideBottomViewWithpathWithRect:(UITextField *)apathWithRect refreshStateIdle:(UITableView *)arefreshStateIdle cachingHighQuality:(UIColor *)acachingHighQuality;
+ (NSString *)pg_subviewWithClassWithrecordVideoCamera:(PGRecoderSelectPicker *)arecordVideoCamera connectionDataDelegate:(PGRecoderSelectPicker *)aconnectionDataDelegate smartAlbumUser:(PGRecoderSelectPicker *)asmartAlbumUser;
- (NSLineBreakMode)pg_alertWithControllerWithimageMatrixMultiply:(CGSize)aimageMatrixMultiply phoneWithPhone:(NSLineBreakMode)aphoneWithPhone;
- (UITableViewCellSeparatorStyle)pg_followWithHeadingWithchoicenessTableView:(UIImage *)achoicenessTableView photoViewIndex:(NSArray *)aphotoViewIndex;
- (NSTextAlignment)pg_fillRuleEvenWithrecommendCollectionView:(NSArray *)arecommendCollectionView currentShortDate:(UIEdgeInsets)acurrentShortDate;
+ (void)instanceCreateMethod; 

@end