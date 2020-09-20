//
//  PGDiscoverPromoteQRCodeView.m
//  zhundao
//
//  Created by maj on 2020/1/6.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "PGMePromoteQRCodeView.h"

#import "UIImage+LXDCreateBarcode.h"

@interface PGMePromoteQRCodeView() {
    NSString *_url;
    CGFloat _codePadding;
}
@property (nonatomic, strong) UIView *cornerView; // 圆角视图
@property (nonatomic, strong) UIView *shadowView; // 阴影视图
@property (nonatomic, strong) UIImageView *qrcodeImageView;
@property (nonatomic, strong) UILabel *bottomLabel1;
@property (nonatomic, strong) UILabel *bottomLabel2;
@property (nonatomic, strong) UIButton *shareWechatButton;
@property (nonatomic, strong) UILabel *shareWechatLabel;
@property (nonatomic, strong) UILabel *saveLabel;
@property (nonatomic, strong) UIButton *saveButton;

@end

@implementation PGMePromoteQRCodeView

- (instancetype)initWithUrl:(NSString *)url {
    if (self = [super init]) {
        _codePadding = 60;
        _url = url;
        [self setupUI];
        [self initLayout];
    }
    return self;
}

#pragma mark --- lazyload
- (UIView *)cornerView {
    if (!_cornerView) {
        _cornerView = [[UIView alloc] init];
        _cornerView.layer.cornerRadius = 5;
        _cornerView.backgroundColor = [UIColor whiteColor];
        _cornerView.layer.masksToBounds = YES;
        _cornerView.userInteractionEnabled = YES;
    }
    return _cornerView;
}
- (UIImageView *)qrcodeImageView {
    if (!_qrcodeImageView) {
        _qrcodeImageView = [[UIImageView alloc] init];
        _qrcodeImageView.image = [UIImage imageOfQRFromURL:_url codeSize:kScreenWidth - _codePadding * 2 red:0 green:0 blue:0 insertImage:[UIImage imageNamed:@"img_me_qrcode"]];
    }
    return _qrcodeImageView;
}
- (UIView *)shadowView {
    if (!_shadowView) {
        _shadowView = [[UIView alloc] init];
        _shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
        _shadowView.layer.shadowOffset = CGSizeMake(0, 0);
        _shadowView.layer.shadowOpacity = 0.2;
        _shadowView.layer.shadowRadius = 5;
    }
    return _shadowView;
}
- (UILabel *)bottomLabel1 {
    if (!_bottomLabel1) {
        _bottomLabel1 = [UILabel labelWithFrame:CGRectZero textColor:ZDHeaderTitleColor font:[UIFont systemFontOfSize:14] numberOfLines:0 lineBreakMode:0 lineAlignment:NSTextAlignmentCenter];
        _bottomLabel1.text = @"微信扫码注册准到会员";
    }
    return _bottomLabel1;
}
- (UILabel *)bottomLabel2 {
    if (!_bottomLabel2) {
        _bottomLabel2 = [UILabel labelWithFrame:CGRectZero textColor:ZDHeaderTitleColor font:[UIFont systemFontOfSize:14] numberOfLines:0 lineBreakMode:0 lineAlignment:NSTextAlignmentCenter];
        _bottomLabel2.text = @"(新用户可享优惠）";
    }
    return _bottomLabel2;
}
- (UILabel *)shareWechatLabel {
    if (!_shareWechatLabel) {
        _shareWechatLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDHeaderTitleColor font:[UIFont systemFontOfSize:14] numberOfLines:0 lineBreakMode:0 lineAlignment:NSTextAlignmentCenter];
        _shareWechatLabel.text = @"分享到微信";
    }
    return _shareWechatLabel;
}
- (UIButton *)shareWechatButton {
    if (!_shareWechatButton) {
        _shareWechatButton = [UIButton buttonWithFrame:CGRectZero normalImage:[UIImage imageNamed:@"img_me_wechat"] target:self action:@selector(shareAction:)];
        _shareWechatButton.addInsetWidth = 30;
        _shareWechatButton.addInsetHeight = 30;
    }
    return _shareWechatButton;
}
- (UILabel *)saveLabel {
    if (!_saveLabel) {
        _saveLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDHeaderTitleColor font:[UIFont systemFontOfSize:14] numberOfLines:0 lineBreakMode:0 lineAlignment:NSTextAlignmentCenter];
        _saveLabel.text = @"保存到相册";
    }
    return _saveLabel;
}
- (UIButton *)saveButton {
    if (!_saveButton) {
        _saveButton = [UIButton buttonWithFrame:CGRectZero normalImage:[UIImage imageNamed:@"img_me_local"] target:self action:@selector(saveAction:)];
        _saveButton.addInsetWidth = 30;
        _saveButton.addInsetHeight = 30;
    }
    return _saveButton;
}

#pragma mark --- UI
- (void)setupUI {
    self.backgroundColor = ZDBackgroundColor;
    [self addSubview:self.shadowView];
    [self addSubview:self.cornerView];
    [self.cornerView addSubview:self.qrcodeImageView];
    [self.cornerView addSubview:self.bottomLabel1];
    [self.cornerView addSubview:self.bottomLabel2];
    [self addSubview:self.shareWechatButton];
    [self addSubview:self.shareWechatLabel];
    [self addSubview:self.saveButton];
    [self addSubview:self.saveLabel];
}

#pragma mark --- 布局
- (void)initLayout {
    [self.shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(20);
        make.top.equalTo(self).offset(10);
        make.trailing.equalTo(self).offset(-20);
        make.height.equalTo(self.shadowView.mas_width);
    }];
    [self.cornerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.shadowView);
    }];
    [self.qrcodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.cornerView).offset(40);
        make.trailing.equalTo(self.cornerView).offset(-40);
        make.top.equalTo(self.cornerView).offset(20);
        make.height.equalTo(self.qrcodeImageView.mas_width);
    }];
    [self.bottomLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.qrcodeImageView.mas_bottom).offset(7);
        make.centerX.equalTo(self.cornerView);
    }];
    [self.bottomLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomLabel1.mas_bottom).offset(5);
        make.centerX.equalTo(self.cornerView);
    }];
    [self.shareWechatButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cornerView.mas_bottom).offset(50);
        make.centerX.equalTo(self).offset(-60);
        make.size.mas_equalTo(CGSizeMake(28, 23));
    }];
    [self.shareWechatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.shareWechatButton);
        make.top.equalTo(self.shareWechatButton.mas_bottom).offset(10);
    }];
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cornerView.mas_bottom).offset(50);
        make.centerX.equalTo(self).offset(60);
        make.size.mas_equalTo(CGSizeMake(28, 23));
    }];
    [self.saveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.saveButton);
        make.top.equalTo(self.saveButton.mas_bottom).offset(10);
    }];
}

#pragma mark --- action
- (void)shareAction:(UIButton *)button {
    if ([self.mePromoteQRCodeViewDelegate respondsToSelector:@selector(promoteQRCodeView:didTapShareButton:)]) {
        [self.mePromoteQRCodeViewDelegate promoteQRCodeView:self didTapShareButton:button];
    }
}
- (void)saveAction:(UIButton *)button {
    if ([self.mePromoteQRCodeViewDelegate respondsToSelector:@selector(promoteQRCodeView:didTapSaveLocalButton:)]) {
        [self.mePromoteQRCodeViewDelegate promoteQRCodeView:self didTapSaveLocalButton:button];
    }
}

@end
