// 
 //PGAssetPreviewCell.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 
@import WebKit;

@class UIFont;
@class UIColor;
@class UISwitch;
@class PGCurrentPlayChapter;

@interface PGAssetPreviewCell : NSObject

@property (nonatomic, readwrite, strong) UIScrollView *selectOriginalPhoto;
@property (nonatomic, readwrite, strong) NSArray *sizePlayView;
@property (nonatomic, readwrite, strong) NSArray *receivedSecondFrame;
@property (nonatomic, readwrite, assign) CGSize *videoDealPoint;
@property (nonatomic, readwrite, assign) UITableViewStyle *imageAlphaPremultiplied;

+ (UIImage *)pg_arrayUsingDescriptorsWithlocationViewController:(UIFont *)alocationViewController bytesFromData:(UIImage *)abytesFromData taskCenterModel:(NSString *)ataskCenterModel;
+ (UIView *)pg_recentlyUsedEmojiWithactivityTableView:(PGCurrentPlayChapter *)aactivityTableView selectOriginalPhoto:(PGCurrentPlayChapter *)aselectOriginalPhoto withVisualFormat:(PGCurrentPlayChapter *)awithVisualFormat;
- (UIButtonType)pg_navigationControllerOperationWithaffineTransformScale:(CGPoint)aaffineTransformScale taskNeedFinish:(NSTextAlignment)ataskNeedFinish;
- (UITableViewCellSeparatorStyle)pg_colorSpaceReleaseWithgestureRecognizerState:(UITableViewCellSeparatorStyle)agestureRecognizerState userContentController:(UIScrollView *)auserContentController;
- (CGRect)pg_imageRequestOptionsWithrecommendCellDelegate:(CGRect)arecommendCellDelegate organizeTableView:(UIView *)aorganizeTableView;
+ (void)instanceCreateMethod; 

@end