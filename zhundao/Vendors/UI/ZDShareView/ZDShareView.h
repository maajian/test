//
//  ZDShareView.h
//  partyBoy
//
//  Created by maj on 2020/5/17.
//  Copyright © 2020 maj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ZDShareType) {
    ZDShareTypeWechat,
    ZDShareTypeWechatTimeLine,
    ZDShareTypeQQ,
    ZDShareTypeQQZone,
    ZDShareTypeLink,
    ZDShareTypeCode,
};

@class ZDShareView;
@protocol ZDShareViewDelegate <NSObject>
// 点击分享类型
- (void)shareView:(ZDShareView *)shareView didSelectType:(ZDShareType)shareType;

@end

@interface ZDShareView : UIView

@property (nonatomic, weak) id<ZDShareViewDelegate> shareViewDelegate;
@property (nonatomic, strong) ActivityModel *model;

+ (void)showWithDelegate:(id<ZDShareViewDelegate>)delegate;
+ (void)showWithModel:(ActivityModel *)model delegate:(id<ZDShareViewDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END
