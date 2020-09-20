//
//  PGDiscoverPromoteQRCodeView.h
//  zhundao
//
//  Created by maj on 2020/1/6.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class PGMePromoteQRCodeView;
@protocol PGMePromoteQRCodeViewDelegate <NSObject>
// 分享
- (void)promoteQRCodeView:(PGMePromoteQRCodeView *)promoteQRCodeView didTapShareButton:(UIButton *)button;
// 保存本地
- (void)promoteQRCodeView:(PGMePromoteQRCodeView *)promoteQRCodeView didTapSaveLocalButton:(UIButton *)button;

@end

@interface PGMePromoteQRCodeView : UIView

@property (nonatomic, weak) id<PGMePromoteQRCodeViewDelegate> mePromoteQRCodeViewDelegate;

@property (nonatomic, strong, readonly) UIImageView *qrcodeImageView;

- (instancetype)initWithUrl:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
