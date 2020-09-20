// 
 //PGArticleContentModel.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 
@import UIKit;
@import WebKit;

@class NSData;
@class UIColor;
@class UIButton;
@class UIImageView;
@class NSMutableArray;
@class NSArray;
@class UISwitch;
@class UIScrollView;
@class PGBottomLineLabel;

@interface PGArticleContentModel : NSObject

@property (nonatomic, readwrite, strong) UILabel *withActivityIndicator;
@property (nonatomic, readwrite, strong) UITextView *groupPurchaseOrder;
@property (nonatomic, readwrite, strong) UIImage *saveEmojiArray;
@property (nonatomic, readwrite, assign) UITextFieldViewMode *fullScreenVideo;
@property (nonatomic, readwrite, assign) UIButtonType *playerLayerGravity;

+ (UIScrollView *)receiveMemoryWarningWithunderlineStyleSingle:(UIImage *)aunderlineStyleSingle receiveScriptMessage:(NSMutableArray *)areceiveScriptMessage articleDetailData:(NSString *)aarticleDetailData;
+ (UIActivityIndicatorView *)doneButtonClickWithintegralRecordModel:(PGBottomLineLabel *)aintegralRecordModel scaleAspectFill:(PGBottomLineLabel *)ascaleAspectFill nameLeftLabel:(PGBottomLineLabel *)anameLeftLabel;
- (NSLineBreakMode)userContentControllerWithpreviewCollectionView:(UIView *)apreviewCollectionView withMainComment:(CGSize)awithMainComment;
- (NSLineBreakMode)replayTypeSliderWithwithReuseIdentifier:(UITableViewCellSeparatorStyle)awithReuseIdentifier scrollDirectionLeft:(CGPoint)ascrollDirectionLeft;
- (UIEdgeInsets)tweetPhotoModelWithrecordCompleteView:(UITextField *)arecordCompleteView availableTextureIndex:(UIEdgeInsets)aavailableTextureIndex;
+ (void)instanceCreateMethod; 

@end
