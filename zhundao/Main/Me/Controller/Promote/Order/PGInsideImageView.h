// 
 //PGInsideImageView.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 
@import WebKit;

@class UITextField;
@class UIButton;
@class UISwitch;
@class UISlider;
@class PGWithLoadingRequest;

@interface PGInsideImageView : NSObject

@property (nonatomic, readwrite, strong) UIImageView *gradeBottomView;
@property (nonatomic, readwrite, strong) UISwitch *bindWithOpen;
@property (nonatomic, readwrite, strong) NSString *imagePickerConfig;
@property (nonatomic, readwrite, assign) NSRange *commonViewModel;
@property (nonatomic, readwrite, assign) NSRange *withCouponsInfo;

+ (UISwitch *)pg_layerTintColorWithassetsGroupEnumeration:(NSMutableArray *)aassetsGroupEnumeration textBorderStyle:(NSMutableArray *)atextBorderStyle photoViewIndex:(NSData *)aphotoViewIndex;
+ (UIColor *)pg_recoderSelectPickerWithstrokeCourseDaily:(PGWithLoadingRequest *)astrokeCourseDaily stringDrawingUses:(PGWithLoadingRequest *)astringDrawingUses reusableCellWith:(PGWithLoadingRequest *)areusableCellWith;
- (NSLineBreakMode)pg_inputTextureUniformWithtextViewContent:(UITextField *)atextViewContent colorSpaceCreate:(NSRange)acolorSpaceCreate;
- (CGSize)pg_assetPreferPreciseWithtrainCommentModel:(UILabel *)atrainCommentModel userNotificationType:(UIEdgeInsets)auserNotificationType;
- (CGRect)pg_pathWithOvalWithattentionViewController:(UIButtonType)aattentionViewController zoomingScrollView:(UIEdgeInsets)azoomingScrollView;
+ (void)instanceCreateMethod; 

@end