// 
 //PGFullScreenPlay.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 
@import UIKit;

@class UITableView;
@class NSString;
@class NSArray;
@class UIView;
@class UIActivityIndicatorView;
@class UISlider;
@class PGTrainParticularModel;

@interface PGFullScreenPlay : NSObject

@property (nonatomic, readwrite, strong) UILabel *changePhoneView;
@property (nonatomic, readwrite, strong) UITextView *progressUpdateBlock;
@property (nonatomic, readwrite, strong) UISwitch *shaderFromString;
@property (nonatomic, readwrite, assign) UITextFieldViewMode *handpickViewModel;
@property (nonatomic, readwrite, assign) UITextFieldViewMode *downloadImageWith;

+ (UIImage *)pg_showPhotoPickerWithdifferenceValueWith:(UIFont *)adifferenceValueWith groupPurchaseModel:(UIView *)agroupPurchaseModel withMedalKind:(UITableView *)awithMedalKind;
+ (UIColor *)pg_previewCollectionViewWithlocationManagerDelegate:(PGTrainParticularModel *)alocationManagerDelegate imageWithName:(PGTrainParticularModel *)aimageWithName videoSendIcon:(PGTrainParticularModel *)avideoSendIcon;
- (CGSize)pg_pickerCollectionViewWithrecommendCourseHeight:(UITextField *)arecommendCourseHeight pushNotificationTrigger:(CGPoint)apushNotificationTrigger;
- (CGRect)pg_tweetItemModelWithorganizationViewController:(UITextView *)aorganizationViewController categoryChooseView:(UIButtonType)acategoryChooseView;
- (CGSize)pg_keyboardWillShowWithweekTimeLabel:(NSString *)aweekTimeLabel sizeWithAttributes:(UIColor *)asizeWithAttributes;
+ (void)instanceCreateMethod; 

@end