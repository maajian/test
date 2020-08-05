//
//  ZDMePromoteBottomView.m
//  zhundao
//
//  Created by maj on 2020/1/17.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "ZDMePromoteBottomView.h"

@interface ZDMePromoteBottomView()

@property (nonatomic, strong) UIButton *mainButton;

@property (nonatomic, strong) UIButton *shareButton;

@end

@implementation ZDMePromoteBottomView

- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
        [self initLayout];
    }
    return self;
}

#pragma mark --- lazyload
- (UIButton *)mainButton {
    if (!_mainButton) {
        _mainButton = [UIButton buttonWithFrame:CGRectZero normalImage:[UIImage imageNamed:@"img_me_promote_main_normal"] highlightedImage:[UIImage imageNamed:@"img_me_promote_main_select"] selectedImage:[UIImage imageNamed:@"img_me_promote_main_select"] target:self action:@selector(mainAction:)];
        [_mainButton setTitle:@"首页" forState:UIControlStateNormal];
        [_mainButton setTitleColor:ZDMainColor forState:UIControlStateHighlighted];
        [_mainButton setTitleColor:ZDMainColor forState:UIControlStateSelected];
        [_mainButton setTitleColor:ZDHeaderTitleColor forState:UIControlStateNormal];
        _mainButton.titleLabel.font = ZDSystemFont(10);
    }
    return _mainButton;
}
- (UIButton *)shareButton {
    if (!_shareButton) {
        _shareButton = [UIButton buttonWithFrame:CGRectZero normalImage:[UIImage imageNamed:@"img_me_promote_share_normal"] highlightedImage:[UIImage imageNamed:@"img_me_promote_share_select"] selectedImage:[UIImage imageNamed:@"img_me_promote_share_select"] target:self action:@selector(shareButton:)];
        [_shareButton setTitle:@"分享" forState:UIControlStateNormal];
        [_shareButton setTitleColor:ZDMainColor forState:UIControlStateHighlighted];
        [_shareButton setTitleColor:ZDMainColor forState:UIControlStateSelected];
        [_shareButton setTitleColor:ZDHeaderTitleColor forState:UIControlStateNormal];
        _shareButton.titleLabel.font = ZDSystemFont(10);
    }
    return _shareButton;
}

#pragma mark --- UI
- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowOpacity = 0.2;
    self.layer.shadowRadius = 5;
    [self addSubview:self.mainButton];
    [self addSubview:self.shareButton];
}

#pragma mark --- 布局
- (void)initLayout {
    [self.mainButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.equalTo(self);
        make.bottom.equalTo(self).offset(ZD_SAFE_BOTTOM_LAYOUT);
        make.width.mas_equalTo(ZD_ScreenWidth / 2);
    }];
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.mainButton.mas_trailing);
        make.top.trailing.equalTo(self);
        make.bottom.equalTo(self.mainButton);
    }];
}

#pragma mark --- setter
- (void)setCurrentIndex:(NSInteger)currentIndex {
    _currentIndex = currentIndex;
    if (currentIndex == 0) {
        [self mainAction:_mainButton];
    } else {
        [self shareButton:_shareButton];
    }
}

#pragma mark --- action
- (void)mainAction:(UIButton *)button {
    _mainButton.selected = YES;
    _shareButton.selected = NO;
    if ([self.promoteBottomViewDelegate respondsToSelector:@selector(promoteBottomView:didSelectMainButton:)]) {
        [self.promoteBottomViewDelegate promoteBottomView:self didSelectMainButton:button];
    }
}
- (void)shareButton:(UIButton *)button {
    _mainButton.selected = NO;
    _shareButton.selected = YES;
    if ([self.promoteBottomViewDelegate respondsToSelector:@selector(promoteBottomView:didSelectShareButton:)]) {
        [self.promoteBottomViewDelegate promoteBottomView:self didSelectShareButton:button];
    }
}
- (void)refreshLayout {
    [self layoutIfNeeded];
    [self.mainButton setButtonWithButtonInsetType:(WYButtonInsetTypeTitleBottom) space:3];
    [self.shareButton setButtonWithButtonInsetType:(WYButtonInsetTypeTitleBottom) space:3];
}

@end
