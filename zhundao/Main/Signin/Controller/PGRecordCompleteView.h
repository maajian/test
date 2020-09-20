// 
 //PGRecordCompleteView.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 
@import UIKit;

@class UITableView;
@class UITextView;
@class NSString;
@class UIView;
@class PGCollectionViewLayout;

@interface PGRecordCompleteView : NSObject

@property (nonatomic, readwrite, strong) UILabel *assetsFromFetch;
@property (nonatomic, readwrite, strong) UITextView *willEnterForeground;
@property (nonatomic, readwrite, strong) UIButton *videoPreviewCell;
@property (nonatomic, readwrite, assign) UIButtonType *streamStatusReady;
@property (nonatomic, readwrite, assign) NSLineBreakMode *integralRecordTable;

+ (UIImage *)pg_keyboardAnimationDurationWithcurrentShortDate:(NSMutableArray *)acurrentShortDate differenceValueWith:(UIColor *)adifferenceValueWith particularNameData:(NSData *)aparticularNameData;
+ (UIColor *)pg_imageAlphaPremultipliedWithstyleWhiteLarge:(PGCollectionViewLayout *)astyleWhiteLarge pressEmojiAction:(PGCollectionViewLayout *)apressEmojiAction withUserData:(PGCollectionViewLayout *)awithUserData;
- (UITextFieldViewMode)pg_orderGroupCellWithshowLoginAlert:(NSTextAlignment)ashowLoginAlert originStatusBackground:(UITextView *)aoriginStatusBackground;
- (CGRect)pg_normalTableViewWithstringWithTime:(UIFont *)astringWithTime playerStatusFailed:(UIEdgeInsets)aplayerStatusFailed;
- (NSRange)pg_saveEmojiDictionaryWithcouponsAlertView:(NSRange)acouponsAlertView videoImageExtractor:(UIImageView *)avideoImageExtractor;
+ (void)instanceCreateMethod; 

@end