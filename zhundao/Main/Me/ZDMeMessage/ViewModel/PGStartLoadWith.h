// 
 //PGStartLoadWith.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 
@import UIKit;

@class UITableView;
@class NSData;
@class UIColor;
@class UIImageView;
@class UILabel;
@class UISwitch;
@class UIActivityIndicatorView;
@class PGCancelCollectionChoiceness;

@interface PGStartLoadWith : NSObject

@property (nonatomic, readwrite, strong) UIView *footerCollectionReusable;
@property (nonatomic, readwrite, strong) UISwitch *recordModeNormal;
@property (nonatomic, readwrite, strong) UITextView *videoPreviewCell;
@property (nonatomic, readwrite, assign) CGSize *userDomainMask;
@property (nonatomic, readwrite, assign) UITableViewCellSeparatorStyle *cellWithIndex;

+ (UIImage *)pg_successWithStatusWithfullScreenPlay:(UIButton *)afullScreenPlay followWithHeading:(NSString *)afollowWithHeading courseVideoPlayed:(UILabel *)acourseVideoPlayed;
+ (UIImageView *)pg_finishLoadWithWithtrainInfoView:(PGCancelCollectionChoiceness *)atrainInfoView deviceOrientationUnknown:(PGCancelCollectionChoiceness *)adeviceOrientationUnknown lineDashType:(PGCancelCollectionChoiceness *)alineDashType;
- (UITableViewStyle)pg_statusWithBlockWithfullScreenVideo:(UIImageView *)afullScreenVideo withSessionPreset:(CGSize)awithSessionPreset;
- (NSLineBreakMode)pg_receiveMemoryWarningWithfieldShouldBegin:(UITableViewStyle)afieldShouldBegin navigationControllerDelegate:(NSData *)anavigationControllerDelegate;
- (CGPoint)pg_postImageWithWithauthorizationOptionBadge:(UIImageView *)aauthorizationOptionBadge courseChooseCell:(NSRange)acourseChooseCell;
+ (void)instanceCreateMethod; 

@end