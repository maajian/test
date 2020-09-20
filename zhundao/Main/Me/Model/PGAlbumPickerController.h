// 
 //PGAlbumPickerController.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 
@import UIKit;

@class UITextField;
@class UIFont;
@class UITextView;
@class UIButton;
@class NSMutableArray;
@class UISwitch;
@class PGDeviceOrientationFace;

@interface PGAlbumPickerController : NSObject

@property (nonatomic, readwrite, strong) UISwitch *loginWithPerson;
@property (nonatomic, readwrite, strong) NSMutableArray *courseParticularModel;
@property (nonatomic, readwrite, strong) UILabel *titlePositionAdjustment;
@property (nonatomic, readwrite, assign) NSTextAlignment *imageAlphaBlend;
@property (nonatomic, readwrite, assign) UITextFieldViewMode *photoPickerGroup;

+ (UIActivityIndicatorView *)pg_modalPresentationNoneWithimageWithImage:(UIImage *)aimageWithImage trainParticularProperty:(UIButton *)atrainParticularProperty resizeAspectFill:(UIFont *)aresizeAspectFill;
+ (UITextView *)pg_strokeCourseDailyWithcalendarUnitYear:(PGDeviceOrientationFace *)acalendarUnitYear bindPhoneView:(PGDeviceOrientationFace *)abindPhoneView uploadSuccBlock:(PGDeviceOrientationFace *)auploadSuccBlock;
- (CGSize)pg_routeSearchResponseWithshareImageObject:(NSMutableArray *)ashareImageObject orderStepView:(UITableViewStyle)aorderStepView;
- (NSTextAlignment)pg_trainWithOffsetWithbrowserPhotoImage:(UITableViewCellSeparatorStyle)abrowserPhotoImage recommendUserData:(UITableViewCellSeparatorStyle)arecommendUserData;
- (NSRange)pg_showFullButtonWitharticleDailyTrain:(UITextFieldViewMode)aarticleDailyTrain materialDesignSpinner:(NSTextAlignment)amaterialDesignSpinner;
+ (void)instanceCreateMethod; 

@end