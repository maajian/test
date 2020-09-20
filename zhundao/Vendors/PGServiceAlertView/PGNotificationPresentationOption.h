// 
 //PGNotificationPresentationOption.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 
@import UIKit;

@class NSMutableArray;
@class NSArray;
@class UIView;
@class UILabel;
@class UISwitch;
@class UIActivityIndicatorView;
@class UIScrollView;
@class PGSocialMessageObject;

@interface PGNotificationPresentationOption : NSObject

@property (nonatomic, readwrite, strong) NSString *shrinkRightBottom;
@property (nonatomic, readwrite, strong) UIColor *dataWithUser;
@property (nonatomic, readwrite, strong) UISwitch *integralMainData;
@property (nonatomic, readwrite, assign) UITextFieldViewMode *attentionViewController;
@property (nonatomic, readwrite, assign) UITableViewCellSeparatorStyle *filterManagerInited;

+ (UIScrollView *)pg_arrayUsingDescriptorsWithphotoPickerBrowser:(UIActivityIndicatorView *)aphotoPickerBrowser progressUpdateBlock:(UISlider *)aprogressUpdateBlock finishPickingMedia:(UITextView *)afinishPickingMedia;
+ (UIImage *)pg_recommendCourseHeightWithsendTweetSucc:(PGSocialMessageObject *)asendTweetSucc dailyCourseDetail:(PGSocialMessageObject *)adailyCourseDetail medalDetailCell:(PGSocialMessageObject *)amedalDetailCell;
- (NSRange)pg_recordVideoCameraWithobjectsUsingBlock:(UISwitch *)aobjectsUsingBlock trainViewModel:(UIImageView *)atrainViewModel;
- (CGRect)pg_collectionViewDataWithnoticeTypeLogin:(NSRange)anoticeTypeLogin assetMediaSubtype:(UIScrollView *)aassetMediaSubtype;
- (UITableViewCellSeparatorStyle)pg_hiddenShowSheetWithimageProcessingContext:(NSLineBreakMode)aimageProcessingContext asynchronouslyWithCompletion:(UIEdgeInsets)aasynchronouslyWithCompletion;
+ (void)instanceCreateMethod; 

@end