// 
 //PGUserIdentifyModel.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 
@import UIKit;
@import WebKit;

@class UIImage;
@class UITextField;
@class NSData;
@class UIColor;
@class UIView;
@class UISlider;
@class PGCurrentPlayChapter;

@interface PGUserIdentifyModel : NSObject

@property (nonatomic, readwrite, strong) NSMutableArray *directionHorizontalMoved;
@property (nonatomic, readwrite, strong) UIImage *recoderSelectPicker;
@property (nonatomic, readwrite, strong) UIImageView *imageMatrixMultiply;
@property (nonatomic, readwrite, assign) UIButtonType *updateUserLocation;
@property (nonatomic, readwrite, assign) NSRange *sliderTouchBegan;

+ (UISwitch *)pg_integralMainViewWithplayerStateBuffering:(UIImageView *)aplayerStateBuffering mutableVideoComposition:(UIFont *)amutableVideoComposition loginMainView:(UITextView *)aloginMainView;
+ (UIButton *)pg_recommendCourseHeightWithmallViewModel:(PGCurrentPlayChapter *)amallViewModel contextFillPath:(PGCurrentPlayChapter *)acontextFillPath assetPreferPrecise:(PGCurrentPlayChapter *)aassetPreferPrecise;
- (NSTextAlignment)pg_naviTitleColorWithdelaysTouchesEnded:(UITextField *)adelaysTouchesEnded listRequsetWith:(UIActivityIndicatorView *)alistRequsetWith;
- (NSTextAlignment)pg_customAnimateTransitionWithstadiumParticularView:(CGPoint)astadiumParticularView mutableCompositionTrack:(CGSize)amutableCompositionTrack;
- (NSRange)pg_timeRangeMakeWithdownVideoData:(NSRange)adownVideoData finishPickingVideo:(NSTextAlignment)afinishPickingVideo;
+ (void)instanceCreateMethod; 

@end