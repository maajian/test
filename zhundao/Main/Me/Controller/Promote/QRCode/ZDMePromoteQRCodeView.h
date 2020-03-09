//
//  ZDDiscoverPromoteQRCodeView.h
//  zhundao
//
//  Created by maj on 2020/1/6.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZDMePromoteQRCodeView;
@protocol ZDMePromoteQRCodeViewDelegate <NSObject>
// 分享
- (void)promoteQRCodeView:(ZDMePromoteQRCodeView *)promoteQRCodeView didTapShareButton:(UIButton *)button;
// 保存本地
- (void)promoteQRCodeView:(ZDMePromoteQRCodeView *)promoteQRCodeView didTapSaveLocalButton:(UIButton *)button;

@end

@interface ZDMePromoteQRCodeView : UIView

@property (nonatomic, weak) id<ZDMePromoteQRCodeViewDelegate> mePromoteQRCodeViewDelegate;

@property (nonatomic, strong, readonly) UIImageView *qrcodeImageView;

- (instancetype)initWithUrl:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
