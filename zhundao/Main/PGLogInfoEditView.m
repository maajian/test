//
//  PGLogInfoEditView.m
//  zhundao
//
//  Created by 罗程勇 on 2018/6/15.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import "PGLogInfoEditView.h"

@interface PGLogInfoEditView()<UITextFieldDelegate> {
    NSString *_phoneStr;
}
 // 关闭返回按钮
@property (nonatomic, strong) UIButton *closeButton;
 // 手机号码
@property (nonatomic, strong) UILabel *phoneLabel;
 // 顶部线条
@property (nonatomic, strong) UIView *topLine;
 // 姓名输入框
@property (nonatomic, strong) UITextField *nameTextField;
 // 中间线
@property (nonatomic, strong) UIView *centerLine;
 // 密码输入框
@property (nonatomic, strong) UITextField *passWordTextField;
 // 底部线
@property (nonatomic, strong) UIView *bottomLine;
 // 下一步
@property (nonatomic, strong) UIButton *nextButton;

@end

@implementation PGLogInfoEditView

 // 初始化 
- (instancetype)initWithFrame:(CGRect)frame phoneStr:(NSString *)phoneStr{
    if (self = [super initWithFrame:frame]) {
        _phoneStr = phoneStr;
        [self setupUI];
        [self updateFrame];
    }
    return self;
}

#pragma mark --- UI创建
- (void)setupUI {
     // 关闭按钮
    _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_closeButton setImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
    [_closeButton addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:_closeButton];
    
     // 手机号码
    _phoneLabel = [[UILabel alloc] init];
    _phoneLabel.text = [NSString stringWithFormat:@"+86 %@",_phoneStr];
    _phoneLabel.textColor = kColorA(51, 51, 51, 1);
    _phoneLabel.textAlignment = NSTextAlignmentCenter;
    _phoneLabel.font = [UIFont boldSystemFontOfSize:16];
    [self addSubview:_phoneLabel];
    
    // 顶部线条
    _topLine = [[UIView alloc] init];
    _topLine.backgroundColor = kColorA(219, 219, 219, 1);
    [self addSubview:_topLine];
    
    // 姓名输入框
    _nameTextField = [[UITextField alloc] init];
    _nameTextField.textColor = kColorA(102, 102, 102, 1);
    _nameTextField.font = [UIFont systemFontOfSize:14];
    _nameTextField.placeholder = @"请输入姓名";
    _nameTextField.delegate = self;
    [_nameTextField becomeFirstResponder];
    [self addSubview:_nameTextField];
    
    // 中间线
    _centerLine = [[UIView alloc] init];
    _centerLine.backgroundColor = kColorA(219, 219, 219, 1);
    [self addSubview:_centerLine];
    
    // 密码输入框
    _passWordTextField = [[UITextField alloc] init];
    _passWordTextField.textColor = kColorA(102, 102, 102, 1);
    _passWordTextField.font = [UIFont systemFontOfSize:14];
    _passWordTextField.placeholder = @"请输入登录密码";
    _passWordTextField.delegate = self;
    _passWordTextField.secureTextEntry = YES;
    [self addSubview:_passWordTextField];
    
    // 底部线
    _bottomLine = [[UIView alloc] init];
    _bottomLine.backgroundColor = kColorA(219, 219, 219, 1);
    [self addSubview:_bottomLine];
    
    // 下一步
    _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextButton.layer.cornerRadius = 5;
    _nextButton.layer.masksToBounds = YES;
    [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [_nextButton setTitleColor:kColorA(255, 255, 255, 0.6) forState:UIControlStateNormal];
    [_nextButton setBackgroundColor:kColorA(68, 186, 37, 0.6)];
    _nextButton.userInteractionEnabled = YES;
    [_nextButton addTarget:self action:@selector(nextStep) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_nextButton];
    
}

#pragma mark --- 自动布局
- (void)updateFrame {
     // 返回按钮
    [_closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self).offset(30);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
     // 手机号码
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_closeButton.mas_bottom).offset(20);
        make.left.equalTo(self).offset(0);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 14));
    }];
    
     // 顶部线
    [_topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_phoneLabel.mas_bottom).offset(20);
        make.left.equalTo(self.mas_left).offset(15);
        make.right.equalTo(self.mas_right).offset(-15);
        make.height.mas_equalTo(0.5);
    }];
    
     // 姓名输入框
    [_nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topLine.mas_bottom);
        make.height.mas_equalTo(40);
        make.left.equalTo(_topLine);
        make.right.equalTo(_topLine);
    }];
    
     // 中心线
    [_centerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topLine);
        make.right.equalTo(_topLine);
        make.top.equalTo(_nameTextField.mas_bottom);
        make.height.mas_equalTo(0.5);
    }];
    
     // 密码输入框
    [_passWordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topLine);
        make.right.equalTo(_topLine);
        make.top.equalTo(_centerLine.mas_bottom);
        make.height.mas_equalTo(40);
    }];
    
     // 底部线
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topLine);
        make.right.equalTo(_topLine);
        make.top.equalTo(_passWordTextField.mas_bottom);
        make.height.mas_equalTo(0.5);
    }];
    
     // 下一步按钮
    [_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bottomLine.mas_bottom).offset(30);
        make.left.equalTo(_topLine);
        make.right.equalTo(_topLine);
        make.height.mas_equalTo(40);
    }];
}
#pragma mark --- UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (_nameTextField.text.length > 0 && _passWordTextField.text.length>0) {
        [_nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nextButton setBackgroundColor:ZDMainColor];
    }
}

#pragma mark --- 点击事件
 // 返回
- (void)back {
    if ([self.infoEditViewDelegate respondsToSelector:@selector(backPop)]) {
        [self.infoEditViewDelegate backPop];
    }
}

/** 下一步 */
- (void)nextStep {
    if (self.nameTextField.text.length == 0) {
        [self showAlert:@"姓名不能为空"];
    } else if (self.nameTextField.text.length > 15) {
        [self showAlert:@"姓名不得超出15个字符"];
    } else if (self.passWordTextField.text.length < 6) {
        [self showAlert:@"密码至少6个字符"];
    } else {
        if ([self.infoEditViewDelegate respondsToSelector:@selector(finishEditWithName:passWord:)]) {
            [self.infoEditViewDelegate finishEditWithName:_nameTextField.text passWord:_passWordTextField.text];
        }
    }
}

#pragma mark --- action
- (void)showAlert:(NSString *)str {
    PGMaskLabel *label = [[PGMaskLabel alloc] initWithTitle:str];
    [label labelAnimationWithViewlong:self];
}

@end
