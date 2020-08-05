//
//  ZDLoginCodeSendView.m
//  jingjing
//
//  Created by maj on 2020/8/3.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "ZDLoginCodeSendView.h"

@interface ZDLoginCodeSendView()
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UILabel  *titleLabel;
@property (nonatomic, strong) UILabel  *countryLabel;
@property (nonatomic, strong) UIImageView  *countryArrowImg;
@property (nonatomic, strong) UITextField   *phoneTF;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *nextButton;

@end

@implementation ZDLoginCodeSendView

- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
        [self initLayout];
    }
    return self;
}

#pragma mark --- UI
- (void)setupUI {
    _closeButton = [UIButton buttonWithFrame:CGRectZero normalImage:[UIImage imageNamed:@"nav_close"] target:self action:@selector(closeAction:)];
    [self addSubview:_closeButton];
    
    _titleLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDBlackColor font:ZDSystemFont(28) numberOfLines:0 lineBreakMode:0 lineAlignment:0];
    _titleLabel.text = @"欢迎登录金塔统计";
    [self addSubview:_titleLabel];
    
    _countryLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDBlackColor font:ZDSystemFont(14) numberOfLines:0 lineBreakMode:0 lineAlignment:0];
    _countryLabel.text = @"+86";
    [self addSubview:_countryLabel];
    
    _countryArrowImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"public_image_arrow_right"]];
    [self addSubview:_countryArrowImg];
    
    _phoneTF = [[UITextField alloc] init];
    _phoneTF.textColor = ZDBlackColor;
    _phoneTF.font = [UIFont systemFontOfSize:18];
    _phoneTF.placeholder = @"请输入手机号";
    _phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    _phoneTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_phoneTF.placeholder attributes:@{NSForegroundColorAttributeName : [UIColor colorFromHexCode:@"B2B2B2"]}];
    [self addSubview:_phoneTF];
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = ZDLineColor;
    [self addSubview:_lineView];
    
    _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextButton.backgroundColor = ZDBlackColor3;
    _nextButton.layer.cornerRadius = 5;
    _nextButton.layer.masksToBounds = YES;
    _nextButton.titleLabel.font = ZDSystemFont(14);
    [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [_nextButton addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_nextButton];
}

#pragma mark --- 布局
- (void)initLayout {
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(15);
        make.top.equalTo(self).offset(30 + ZD_StatusBar_H);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.closeButton.mas_bottom).offset(50);
        make.leading.equalTo(self).offset(40);
        make.height.mas_equalTo(40);
    }];
    [self.countryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(40);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(48);
        make.width.mas_equalTo(35);
    }];
    [self.countryArrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.countryLabel);
        make.leading.equalTo(self.countryLabel.mas_trailing).offset(8);
        make.size.mas_equalTo(CGSizeMake(10, 10));
    }];
    [self.phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.countryLabel);
        make.leading.equalTo(self.countryArrowImg.mas_trailing).offset(10);
        make.trailing.equalTo(self.lineView.mas_trailing);
        make.height.mas_equalTo(40);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.countryLabel.mas_bottom).offset(15);
        make.leading.equalTo(self).offset(40);
        make.trailing.equalTo(self).offset(-40);
        make.height.mas_equalTo(1);
    }];
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(18);
        make.trailing.equalTo(self).offset(-18);
        make.height.mas_equalTo(44);
        make.top.equalTo(self.lineView.mas_bottom).offset(80);
    }];
}

#pragma mark --- setter

#pragma mark --- UITextFieldDelegate

#pragma mark --- action
- (void)closeAction:(UIButton *)button {
    if ([self.loginCodeSendViewDelegate respondsToSelector:@selector(ZDLoginCodeSendView:didTapCloseButton:)]) {
        [self.loginCodeSendViewDelegate ZDLoginCodeSendView:self didTapCloseButton:button];
    }
}
- (void)nextAction:(UIButton *)nextButton {
    if ([self.loginCodeSendViewDelegate respondsToSelector:@selector(ZDLoginCodeSendView:didTapNextButton:)]) {
        [self.loginCodeSendViewDelegate ZDLoginCodeSendView:self didTapNextButton:nextButton];
    }
}

@end
