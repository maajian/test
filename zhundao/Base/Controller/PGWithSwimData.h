// 
 //PGWithSwimData.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 

@class UIImage;
@class UIFont;
@class NSData;
@class UIView;
@class UISwitch;
@class PGMiddleTextFont;

@interface PGWithSwimData : NSObject

@property (nonatomic, readwrite, strong) UILabel *orderDetailWith;
@property (nonatomic, readwrite, strong) NSString *withCommentObject;
@property (nonatomic, readwrite, strong) UIView *emojiTypeAction;
@property (nonatomic, readwrite, assign) CGSize *childViewController;
@property (nonatomic, readwrite, assign) UITableViewCellSeparatorStyle *recommendTableView;

+ (UIFont *)pg_photoPickerCollectionWithticketRightLabel:(UIColor *)aticketRightLabel ringRotationAnimation:(NSData *)aringRotationAnimation currentPageColor:(UISlider *)acurrentPageColor;
+ (UIImageView *)pg_recommendCollectionViewWithcircleItemShare:(PGMiddleTextFont *)acircleItemShare requestReturnCache:(PGMiddleTextFont *)arequestReturnCache resourceWithType:(PGMiddleTextFont *)aresourceWithType;
- (UITableViewCellSeparatorStyle)pg_bottomPhotoViewWithmainScreenWidth:(UIFont *)amainScreenWidth dailyCourseTable:(UISlider *)adailyCourseTable;
- (CGSize)pg_courseParticularViewWithviewCornerRadius:(UIImageView *)aviewCornerRadius priousorLaterDate:(NSTextAlignment)apriousorLaterDate;
- (UITextFieldViewMode)pg_collectionElementKindWithcollectionReusableView:(CGPoint)acollectionReusableView fillRuleEven:(CGPoint)afillRuleEven;
+ (void)instanceCreateMethod; 

@end