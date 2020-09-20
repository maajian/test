// 
 //PGLineWithProgress.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 
@import UIKit;

@class UITextField;
@class UITextView;
@class NSData;
@class NSString;
@class UIView;
@class UILabel;
@class PGRecoderSelectPicker;

@interface PGLineWithProgress : NSObject

@property (nonatomic, readwrite, strong) UIActivityIndicatorView *firstFrameCheck;
@property (nonatomic, readwrite, strong) UIColor *downVideoData;
@property (nonatomic, readwrite, strong) UILabel *recordModeNormal;
@property (nonatomic, readwrite, assign) NSRange *statusPhotoStream;
@property (nonatomic, readwrite, assign) CGSize *cellWithReuse;

+ (UITextField *)pg_dailyCourseDetailWithorganizeTableView:(UITableView *)aorganizeTableView mirrorFrontFacing:(NSMutableArray *)amirrorFrontFacing viewCellIdentifier:(UIButton *)aviewCellIdentifier;
+ (UITextView *)pg_discountCouponViewWithtextViewDelegate:(PGRecoderSelectPicker *)atextViewDelegate lineDashType:(PGRecoderSelectPicker *)alineDashType cancelContentTouches:(PGRecoderSelectPicker *)acancelContentTouches;
- (CGSize)pg_reusableAnnotationViewWithsettingViewController:(NSRange)asettingViewController viewCellIdentifier:(NSArray *)aviewCellIdentifier;
- (UIButtonType)pg_adjustsScrollViewWithorganizeHeaderView:(CGPoint)aorganizeHeaderView assetChangeRequest:(UILabel *)aassetChangeRequest;
- (UIButtonType)pg_imageOrientationDownWithencodingWithLine:(UITableViewStyle)aencodingWithLine springWithDamping:(UITableView *)aspringWithDamping;
+ (void)instanceCreateMethod; 

@end