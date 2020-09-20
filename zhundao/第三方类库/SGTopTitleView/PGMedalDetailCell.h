// 
 //PGMedalDetailCell.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 

@class UIImage;
@class UIFont;
@class NSData;
@class UIButton;
@class UIImageView;
@class UIView;
@class PGViewImageFinish;

@interface PGMedalDetailCell : NSObject

@property (nonatomic, readwrite, strong) UITextView *integralRecordTable;
@property (nonatomic, readwrite, strong) UIColor *ticketRightLabel;
@property (nonatomic, readwrite, strong) UIButton *userTrackingMode;
@property (nonatomic, readwrite, assign) NSLineBreakMode *loginViewController;
@property (nonatomic, readwrite, assign) UITableViewStyle *headerViewDelegate;

+ (UIImage *)pg_retinaFilePathWithassetResourceLoader:(UISlider *)aassetResourceLoader refreshStateRefreshing:(UIFont *)arefreshStateRefreshing saveVideoPath:(UIImage *)asaveVideoPath;
+ (NSData *)pg_imageSourceThumbnailWithrecordMovieView:(PGViewImageFinish *)arecordMovieView columnistChildView:(PGViewImageFinish *)acolumnistChildView fileTypeQuick:(PGViewImageFinish *)afileTypeQuick;
- (UITableViewStyle)pg_customControlViewWithrecommendDiscountTable:(UIButton *)arecommendDiscountTable medalDetailView:(UITableViewCellSeparatorStyle)amedalDetailView;
- (NSLineBreakMode)pg_arrayUsingSelectorWithbaseLoginView:(UITextField *)abaseLoginView swimCircleView:(UIView *)aswimCircleView;
- (NSTextAlignment)pg_retinaFilePathWithtweetCommentModel:(NSRange)atweetCommentModel sendTweetSucc:(UIImage *)asendTweetSucc;
+ (void)instanceCreateMethod; 

@end