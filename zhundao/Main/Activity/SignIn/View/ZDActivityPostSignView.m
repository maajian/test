//
//  ZDActivityPostSignView.m
//  zhundao
//
//  Created by maj on 2021/5/12.
//  Copyright © 2021 zhundao. All rights reserved.
//

#import "ZDActivityPostSignView.h"

@interface ZDActivityPostSignView()<UITextFieldDelegate>
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *nameFixLabel;
@property (nonatomic, strong) UITextField *nameTF;
@property (nonatomic, strong) UIView *nameBottonLine; // 姓名线

@property (nonatomic, strong) UILabel *typeFixLabel; // 签到类型
@property (nonatomic, strong) UIButton *unlimitButton; // 未限制
@property (nonatomic, strong) UIButton *onlySignupButton; // 仅限报名人员

@property (nonatomic, strong) UIButton *sureButton;
@property (nonatomic, strong) ZDSignInModel *model;
@property (nonatomic, copy) NSString *activityName;

@end

@implementation ZDActivityPostSignView

- (instancetype)initWithModel:(ZDSignInModel *)model activityName:(NSString *)activityName {
    if (self = [super init]) {
        self.model = model;
        self.activityName = activityName;
        [self initSet];
        [self initLayout];
    }
    return self;
}

#pragma mark --- Init
- (void)initSet {
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.nameFixLabel];
    [self.contentView addSubview:self.nameTF];
    [self.contentView addSubview:self.nameBottonLine];
    [self.contentView addSubview:self.typeFixLabel];
    [self.contentView addSubview:self.unlimitButton];
    [self.contentView addSubview:self.onlySignupButton];
    [self addSubview:self.sureButton];
    
    if (self.model) {
        self.nameTF.text = self.model.Name;
        self.onlySignupButton.selected = !self.model.SignObject;
        self.unlimitButton.selected = self.model.SignObject;
    } else {
        self.nameTF.text = [NSString stringWithFormat:@"%@签到1",self.activityName];
        self.onlySignupButton.selected = YES;
    }
}
- (void)initLayout {
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.leading.trailing.equalTo(self);
        make.height.mas_equalTo(203);
    }];
    [self.nameFixLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(16);
        make.top.equalTo(self.contentView).offset(22);
    }];
    [self.nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(16);
        make.trailing.equalTo(self.contentView).offset(-16);
        make.height.mas_equalTo(47);
        make.top.equalTo(self.nameFixLabel.mas_bottom);
    }];
    [self.nameBottonLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.nameTF);
        make.height.mas_equalTo(1);
        make.top.equalTo(self.nameTF.mas_bottom);
    }];
    [self.typeFixLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(16);
        make.top.equalTo(self.nameBottonLine.mas_bottom).offset(22);
    }];
    [self.onlySignupButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(16);
        make.top.equalTo(self.typeFixLabel.mas_bottom).offset(12);
        make.size.mas_equalTo(CGSizeMake(103, 40));
    }];
    [self.unlimitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.onlySignupButton.mas_trailing).offset(17);
        make.top.bottom.width.equalTo(self.onlySignupButton);
    }];
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_bottom).offset(32);
        make.leading.equalTo(self.contentView).offset(30);
        make.trailing.equalTo(self.contentView).offset(-30);
        make.height.mas_equalTo(44);
    }];
}

#pragma mark --- Private
- (void)sureAction:(id)sender {
    [self endEditing:YES];
    NSInteger type = self.onlySignupButton.selected ? 0 : 1;
    if ([self.postSignViewDelegate respondsToSelector:@selector(postSignView:didChooseType:name:)]) {
        [self.postSignViewDelegate postSignView:self didChooseType:type name:self.nameTF.text];
    }
}
- (void)unlimitAction:(UIButton *)sender {
    self.unlimitButton.selected = YES;
    self.onlySignupButton.selected = NO;
}
- (void)onlySignupAction:(UIButton *)sender {
    self.unlimitButton.selected = NO;
    self.onlySignupButton.selected = YES;
}
- (void)textFieldDidChange:(UITextField *)textField {
    self.sureButton.enabled = textField.text.length;
}

#pragma mark --- Lazyload
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}
- (UILabel *)nameFixLabel {
    if (!_nameFixLabel) {
        _nameFixLabel = [UILabel labelWithFrame:CGRectZero textColor:[UIColor colorFromHexCode:@"19191A"] font:ZDMediumFont(14) numberOfLines:0 lineBreakMode:0 lineAlignment:0];
        _nameFixLabel.text = @"签到名称";
    }
    return _nameFixLabel;
}
- (UITextField *)nameTF {
    if (!_nameTF) {
        _nameTF = [[UITextField alloc] init];
        _nameTF.textColor = [UIColor colorFromHexCode:@"19191A"];
        _nameTF.font = ZDBoldFont(16);
        _nameTF.clearButtonMode = UITextFieldViewModeAlways;
        [_nameTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _nameTF;
}
- (UIView *)nameBottonLine {
    if (!_nameBottonLine) {
        _nameBottonLine = [[UIView alloc] init];
        _nameBottonLine.backgroundColor = [UIColor colorFromHexCode:@"1AAC1B"];
    }
    return _nameBottonLine;
}
- (UILabel *)typeFixLabel {
    if (!_typeFixLabel) {
        _typeFixLabel = [UILabel labelWithFrame:CGRectZero textColor:[UIColor colorFromHexCode:@"19191A"] font:ZDMediumFont(14) numberOfLines:0 lineBreakMode:0 lineAlignment:0];
        _typeFixLabel.text = @"签到对象";
    }
    return _typeFixLabel;
}
- (UIButton *)unlimitButton {
    if (!_unlimitButton) {
        _unlimitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_unlimitButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorFromHexCode:@"1AAC1B"]] forState:UIControlStateSelected];
        [_unlimitButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorFromHexCode:@"F4F4F8"]] forState:UIControlStateNormal];
        [_unlimitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_unlimitButton setTitleColor:[UIColor colorFromHexCode:@"19191A"] forState:UIControlStateNormal];
        [_unlimitButton setTitle:@"不限" forState:UIControlStateNormal];
        _unlimitButton.layer.cornerRadius = 20;
        _unlimitButton.layer.masksToBounds = YES;
        _unlimitButton.titleLabel.font = ZDBoldFont(14);
        [_unlimitButton addTarget:self action:@selector(unlimitAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _unlimitButton;
}
- (UIButton *)onlySignupButton {
    if (!_onlySignupButton) {
        _onlySignupButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_onlySignupButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorFromHexCode:@"1AAC1B"]] forState:UIControlStateSelected];
        [_onlySignupButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorFromHexCode:@"F4F4F8"]] forState:UIControlStateNormal];
        [_onlySignupButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_onlySignupButton setTitleColor:[UIColor colorFromHexCode:@"19191A"] forState:UIControlStateNormal];
        [_onlySignupButton setTitle:@"仅报名人员" forState:UIControlStateNormal];
        [_onlySignupButton addTarget:self action:@selector(onlySignupAction:) forControlEvents:UIControlEventTouchUpInside];
        _onlySignupButton.layer.cornerRadius = 20;
        _onlySignupButton.layer.masksToBounds = YES;
        _onlySignupButton.titleLabel.font = ZDBoldFont(14);
    }
    return _onlySignupButton;;
}
- (UIButton *)sureButton {
    if (!_sureButton) {
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorFromHexCode:@"1AAC1B"]] forState:UIControlStateNormal];
        [_sureButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorFromHexCode:@"D2D6D9"]] forState:UIControlStateDisabled];
        [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [_sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sureButton.titleLabel.font = ZDBoldFont(16);
        _sureButton.layer.cornerRadius = 22;
        _sureButton.layer.masksToBounds = YES;
        [_sureButton addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureButton;
}

@end
