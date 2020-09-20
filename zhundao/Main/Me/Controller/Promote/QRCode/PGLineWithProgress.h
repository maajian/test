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

+ (UITextField *)dailyCourseDetailWithorganizeTableView:(UITableView *)aorganizeTableView mirrorFrontFacing:(NSMutableArray *)amirrorFrontFacing viewCellIdentifier:(UIButton *)aviewCellIdentifier;
+ (UITextView *)discountCouponViewWithtextViewDelegate:(PGRecoderSelectPicker *)atextViewDelegate lineDashType:(PGRecoderSelectPicker *)alineDashType cancelContentTouches:(PGRecoderSelectPicker *)acancelContentTouches;
- (CGSize)reusableAnnotationViewWithsettingViewController:(NSRange)asettingViewController viewCellIdentifier:(NSArray *)aviewCellIdentifier;
- (UIButtonType)adjustsScrollViewWithorganizeHeaderView:(CGPoint)aorganizeHeaderView assetChangeRequest:(UILabel *)aassetChangeRequest;
- (UIButtonType)imageOrientationDownWithencodingWithLine:(UITableViewStyle)aencodingWithLine springWithDamping:(UITableView *)aspringWithDamping;
+ (void)instanceCreateMethod; 

@end
