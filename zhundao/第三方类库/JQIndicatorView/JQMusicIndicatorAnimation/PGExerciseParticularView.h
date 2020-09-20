// 
 //PGExerciseParticularView.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 
@import WebKit;

@class UIImage;
@class UIColor;
@class NSString;
@class UIButton;
@class UIImageView;
@class UISlider;
@class PGBottomCellDelegate;

@interface PGExerciseParticularView : NSObject

@property (nonatomic, readwrite, strong) UIImageView *infoHeaderHeight;
@property (nonatomic, readwrite, strong) UITableView *customAnimateTransition;
@property (nonatomic, readwrite, strong) UIActivityIndicatorView *integralRecordTable;
@property (nonatomic, readwrite, assign) UITableViewCellSeparatorStyle *trainParticularData;
@property (nonatomic, readwrite, assign) UIEdgeInsets *assetsGroupProperty;

+ (UITextField *)pg_applicationLaunchOptionsWithcouponViewModel:(UIColor *)acouponViewModel discoverTableView:(UIButton *)adiscoverTableView headerFooterView:(NSString *)aheaderFooterView;
+ (UILabel *)pg_videoImageExtractorWithphotosBytesWith:(PGBottomCellDelegate *)aphotosBytesWith reachabilityStatusChange:(PGBottomCellDelegate *)areachabilityStatusChange cancelLoadingRequest:(PGBottomCellDelegate *)acancelLoadingRequest;
- (CGSize)pg_indicatorViewStyleWithupdateStatuMandatory:(UIEdgeInsets)aupdateStatuMandatory textureWithVertices:(NSArray *)atextureWithVertices;
- (UITableViewStyle)pg_childViewModelWithimageSourceCopy:(CGPoint)aimageSourceCopy collectionReusableView:(UIImageView *)acollectionReusableView;
- (CGSize)pg_viewArrowLengthWithwithMediaType:(UITextView *)awithMediaType routeSearchDone:(CGSize)arouteSearchDone;
+ (void)instanceCreateMethod; 

@end