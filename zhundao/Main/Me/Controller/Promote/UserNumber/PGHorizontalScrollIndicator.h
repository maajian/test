// 
 //PGHorizontalScrollIndicator.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 
@import UIKit;
@import WebKit;

@class UIImageView;
@class NSArray;
@class UIScrollView;
@class PGImageViewFrame;

@interface PGHorizontalScrollIndicator : NSObject

@property (nonatomic, readwrite, strong) UITextView *childViewController;
@property (nonatomic, readwrite, strong) UIView *articleContentModel;
@property (nonatomic, readwrite, strong) NSString *valueImageRect;
@property (nonatomic, readwrite, assign) CGSize *tableViewCell;
@property (nonatomic, readwrite, assign) UITableViewCellSeparatorStyle *pageContolStyle;

+ (NSString *)pg_completeViewDelegateWithassetTypeVideo:(UITextField *)aassetTypeVideo gradeUserModel:(NSData *)agradeUserModel albumSyncedAlbum:(UIFont *)aalbumSyncedAlbum;
+ (UIView *)pg_operationWithBlockWithcollectionViewData:(PGImageViewFrame *)acollectionViewData edgeInsetsZero:(PGImageViewFrame *)aedgeInsetsZero collectionTrainView:(PGImageViewFrame *)acollectionTrainView;
- (NSRange)pg_textAttributedStringWithcircleItemPhoto:(UIImageView *)acircleItemPhoto classFromString:(UIImageView *)aclassFromString;
- (CGPoint)pg_pathCloseSubpathWithindicatorTintColor:(NSTextAlignment)aindicatorTintColor pageScrollView:(UITextView *)apageScrollView;
- (UIEdgeInsets)pg_mainCommentTableWithupdateUserLocation:(UIEdgeInsets)aupdateUserLocation customPropertyMapper:(UIColor *)acustomPropertyMapper;
+ (void)instanceCreateMethod; 

@end