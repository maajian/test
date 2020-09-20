// 
 //PGPlayTestView.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 
@import UIKit;

@class UITextView;
@class NSMutableArray;
@class UIView;
@class UIActivityIndicatorView;
@class UISlider;
@class PGArticleCommentView;

@interface PGPlayTestView : NSObject

@property (nonatomic, readwrite, strong) UIImageView *changeReasonCategory;
@property (nonatomic, readwrite, strong) UIButton *integralMainData;
@property (nonatomic, readwrite, strong) UIView *commonToolVedio;
@property (nonatomic, readwrite, assign) UIEdgeInsets *deliveryModeAutomatic;
@property (nonatomic, readwrite, assign) UITableViewCellSeparatorStyle *thumbCollectionView;

+ (UISlider *)pg_collectionOriginalModelWithtitleTextAttributes:(UIColor *)atitleTextAttributes tableViewData:(UIButton *)atableViewData rectCornerBottom:(UITextView *)arectCornerBottom;
+ (UIImage *)pg_rootViewControllerWithassetFromImage:(PGArticleCommentView *)aassetFromImage commonViewModel:(PGArticleCommentView *)acommonViewModel trainsWithOffset:(PGArticleCommentView *)atrainsWithOffset;
- (NSTextAlignment)pg_weekTimeLabelWithtweetPhotoModel:(UITextView *)atweetPhotoModel contentInsetAdjustment:(UITableViewCellSeparatorStyle)acontentInsetAdjustment;
- (NSRange)pg_titleViewExampleWithcollectionViewController:(NSLineBreakMode)acollectionViewController withFragmentShader:(UITableViewStyle)awithFragmentShader;
- (UIButtonType)pg_badgeDefaultFontWithtitleEdgeInsets:(NSRange)atitleEdgeInsets keyboardWillChange:(UIEdgeInsets)akeyboardWillChange;
+ (void)instanceCreateMethod; 

@end