// 
 //PGResizeAspectFill.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 
@import UIKit;

@class UIFont;
@class UITextView;
@class NSMutableArray;
@class UISwitch;
@class UIActivityIndicatorView;
@class UISlider;
@class PGCollectionViewLayout;

@interface PGResizeAspectFill : NSObject

@property (nonatomic, readwrite, strong) UIActivityIndicatorView *videoPlayHeight;
@property (nonatomic, readwrite, strong) NSString *weekTimeLabel;
@property (nonatomic, readwrite, strong) UITextView *selectPhotoNavigation;
@property (nonatomic, readwrite, assign) UITableViewStyle *readingAllowFragments;
@property (nonatomic, readwrite, assign) NSTextAlignment *progressTypeNone;

+ (UITableView *)pg_cameraAutoSaveWithuserInfoMedal:(UIImageView *)auserInfoMedal mutableCompositionTrack:(UIActivityIndicatorView *)amutableCompositionTrack textViewContent:(NSMutableArray *)atextViewContent;
+ (UIImage *)pg_finishSavingWithWitherrorWithStatus:(PGCollectionViewLayout *)aerrorWithStatus medalDetailModel:(PGCollectionViewLayout *)amedalDetailModel mainScreenWidth:(PGCollectionViewLayout *)amainScreenWidth;
- (UITableViewStyle)pg_socialMessageObjectWithloginWithUser:(UISwitch *)aloginWithUser countTableView:(NSRange)acountTableView;
- (NSLineBreakMode)pg_organizeCollectionViewWithencodingWithLine:(UIButton *)aencodingWithLine centerButtonClick:(CGPoint)acenterButtonClick;
- (CGRect)pg_userInterfaceIdiomWithrefreshHeaderLayer:(UIEdgeInsets)arefreshHeaderLayer viewCornerRadius:(NSRange)aviewCornerRadius;
+ (void)instanceCreateMethod; 

@end