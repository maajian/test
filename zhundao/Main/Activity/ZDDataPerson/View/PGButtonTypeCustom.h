// 
 //PGButtonTypeCustom.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 
@import UIKit;

@class UIFont;
@class NSData;
@class UIColor;
@class UILabel;
@class UISlider;
@class PGSelectPickerAssets;

@interface PGButtonTypeCustom : NSObject

@property (nonatomic, readwrite, strong) UIActivityIndicatorView *bottomShrinkPlay;
@property (nonatomic, readwrite, strong) UISlider *baseLoginView;
@property (nonatomic, readwrite, strong) UIScrollView *pickerClickTick;
@property (nonatomic, readwrite, assign) CGRect *withSessionPreset;
@property (nonatomic, readwrite, assign) UITextFieldViewMode *shouldAutoClip;

+ (UIButton *)pg_exerciseHistoryDataWithassetsGroupProperty:(UIFont *)aassetsGroupProperty itemsSupplementBack:(UITextField *)aitemsSupplementBack keyboardWillHide:(NSString *)akeyboardWillHide;
+ (UILabel *)pg_medalDetailFlowWithimageViewWith:(PGSelectPickerAssets *)aimageViewWith photosBytesWith:(PGSelectPickerAssets *)aphotosBytesWith firendsViewModel:(PGSelectPickerAssets *)afirendsViewModel;
- (UIButtonType)pg_nameLeftLabelWithtweetItemData:(NSLineBreakMode)atweetItemData viewWillHidden:(NSRange)aviewWillHidden;
- (CGSize)pg_videoViewModelWithimageRotationSwaps:(UITableViewCellSeparatorStyle)aimageRotationSwaps assetPropertyDuration:(UITextFieldViewMode)aassetPropertyDuration;
- (CGSize)pg_viewContentSizeWithtypeUserCenter:(NSRange)atypeUserCenter pickingOriginalPhoto:(CGRect)apickingOriginalPhoto;
+ (void)instanceCreateMethod; 

@end