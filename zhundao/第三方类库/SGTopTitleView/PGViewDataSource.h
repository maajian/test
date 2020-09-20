// 
 //PGViewDataSource.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 
@import UIKit;

@class UITextField;
@class NSString;
@class UIImageView;
@class NSMutableArray;
@class UILabel;
@class UISwitch;
@class PGSocialMessageObject;

@interface PGViewDataSource : NSObject

@property (nonatomic, readwrite, strong) UISwitch *playWhileCell;
@property (nonatomic, readwrite, strong) NSMutableArray *finishPickingVideo;
@property (nonatomic, readwrite, strong) NSString *playerStateFailed;
@property (nonatomic, readwrite, assign) UITableViewStyle *collectionReusableView;
@property (nonatomic, readwrite, assign) CGRect *maskViewFlag;

+ (UIFont *)pg_collectionDataWithWithlinkWithTarget:(UITableView *)alinkWithTarget indicatorViewColor:(UIColor *)aindicatorViewColor choicenessViewController:(UIFont *)achoicenessViewController;
+ (UITableView *)pg_unclampedDelayTimeWithpageTintColor:(PGSocialMessageObject *)apageTintColor blendModeClear:(PGSocialMessageObject *)ablendModeClear couponAlertView:(PGSocialMessageObject *)acouponAlertView;
- (UITableViewStyle)pg_couponViewModelWithkeyboardTypeNumber:(UITableView *)akeyboardTypeNumber trainFinishAlert:(NSData *)atrainFinishAlert;
- (NSTextAlignment)pg_circleItemShareWithweekdayCalendarUnit:(UITableViewCellSeparatorStyle)aweekdayCalendarUnit defaultMaskType:(NSTextAlignment)adefaultMaskType;
- (UIButtonType)pg_photoPickerViewWithchooseCellDelegate:(UITextField *)achooseCellDelegate videBeginPlay:(UIImageView *)avideBeginPlay;
+ (void)instanceCreateMethod; 

@end