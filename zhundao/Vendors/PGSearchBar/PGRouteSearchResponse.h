// 
 //PGRouteSearchResponse.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 
@import UIKit;

@class UIImage;
@class UITableView;
@class NSString;
@class UIView;
@class UILabel;
@class PGCurrentPlayChapter;

@interface PGRouteSearchResponse : NSObject

@property (nonatomic, readwrite, strong) UILabel *contentInsetAdjustment;
@property (nonatomic, readwrite, strong) UIImage *progressTypeCycling;
@property (nonatomic, readwrite, strong) UIFont *mainMessageView;
@property (nonatomic, readwrite, assign) NSTextAlignment *delaysTouchesBegan;
@property (nonatomic, readwrite, assign) UIButtonType *minimumFractionDigits;

+ (UITextView *)pg_sizeWithAssetWithapplicationOpenSettings:(NSMutableArray *)aapplicationOpenSettings addingPercentEscapes:(NSMutableArray *)aaddingPercentEscapes viewHeightPadding:(UIImage *)aviewHeightPadding;
+ (UIButton *)pg_characterLineLengthWithlargeTextFont:(PGCurrentPlayChapter *)alargeTextFont edgeInsetsZero:(PGCurrentPlayChapter *)aedgeInsetsZero objectsUsingBlock:(PGCurrentPlayChapter *)aobjectsUsingBlock;
- (NSLineBreakMode)pg_rectContainsPointWithjavaScriptText:(NSMutableArray *)ajavaScriptText mainActivityModel:(NSMutableArray *)amainActivityModel;
- (NSTextAlignment)pg_couseFinishAlertWithallowWithController:(UITableViewCellSeparatorStyle)aallowWithController effectColorAlpha:(UIImageView *)aeffectColorAlpha;
- (NSLineBreakMode)pg_succViewControllerWithtypeCreatePreferred:(UIButtonType)atypeCreatePreferred withCityName:(UITextField *)awithCityName;
+ (void)instanceCreateMethod; 

@end