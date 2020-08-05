//
//  ZDLoginCodeFixView.m
//  jingjing
//
//  Created by maj on 2020/8/3.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "ZDLoginCodeFixView.h"

#import "ZDLoginCodeView.h"

@interface ZDLoginCodeFixView()
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) ZDLoginCodeView *codeView;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIButton *sureButton;

@end

@implementation ZDLoginCodeFixView

- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
        [self initLayout];
    }
    return self;
}

#pragma mark --- lazyload

#pragma mark --- UI
- (void)setupUI {
    _closeButton = [UIButton buttonWithFrame:CGRectZero normalImage:[UIImage imageNamed:@"nav_close"] target:self action:@selector(closeAction:)];
    [self addSubview:_closeButton];
    
    _titleLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDBlackColor font:ZDSystemFont(32) numberOfLines:0 lineBreakMode:0 lineAlignment:0];
    _titleLabel.text = @"输入验证码";
    [self addSubview:_titleLabel];
    
    _phoneLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDFontColor666 font:ZDSystemFont(14) numberOfLines:0 lineBreakMode:0 lineAlignment:0];
    _phoneLabel.text = @"验证码已发送至 +86 188 4458 9997";
    [self addSubview:_phoneLabel];
    
    _codeView = [[ZDLoginCodeView alloc] init];
    [self addSubview:_codeView];
    
    _timeLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDFontColor666 font:ZDSystemFont(14) numberOfLines:0 lineBreakMode:0 lineAlignment:0];
    [self addSubview:_timeLabel];
    
    _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _sureButton.backgroundColor = ZDBlackColor3;
    _sureButton.layer.cornerRadius = 5;
    _sureButton.layer.masksToBounds = YES;
    _sureButton.titleLabel.font = ZDSystemFont(14);
    [_sureButton setTitle:@"下一步" forState:UIControlStateNormal];
    [_sureButton addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_sureButton];
}

#pragma mark --- 布局
- (void)initLayout {
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(15);
        make.top.equalTo(self).offset(30 + ZD_StatusBar_H);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.closeButton.mas_bottom).offset(60);
        make.leading.equalTo(self).offset(40);
    }];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(40);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
    }];
    [self.codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(40);
        make.trailing.equalTo(self).offset(-40);
        make.top.equalTo(self.phoneLabel.mas_bottom).offset(20);
        make.height.mas_equalTo(40);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.codeView);
        make.top.equalTo(self.codeView.mas_bottom).offset(20);
    }];
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLabel.mas_bottom).offset(50);
        make.leading.equalTo(self).offset(20);
        make.trailing.equalTo(self).offset(-20);
        make.height.mas_equalTo(44);
    }];
}

#pragma mark --- setter getter
- (NSString *)code {
    return self.codeView.textField.text;
}

#pragma mark --- action
- (void)closeAction:(UIButton *)button {
    if ([self.loginCodeFixViewDelegate respondsToSelector:@selector(ZDLoginCodeFixView:didTapCloseButton:)]) {
        [self.loginCodeFixViewDelegate ZDLoginCodeFixView:self didTapCloseButton:button];
    }
}
- (void)nextAction:(UIButton *)nextButton {
    if ([self.loginCodeFixViewDelegate respondsToSelector:@selector(ZDLoginCodeFixView:didTapNextButton:)]) {
        [self.loginCodeFixViewDelegate ZDLoginCodeFixView:self didTapNextButton:nextButton];
    }
}

@end
