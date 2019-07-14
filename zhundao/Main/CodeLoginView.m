//
//  CodeLoginView.m
//  zhundao
//
//  Created by 罗程勇 on 2018/6/15.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import "CodeLoginView.h"

@interface CodeLoginView ()<UITextFieldDelegate>
 // 返回按钮
@property (nonatomic, strong) UIButton *backButton;
 // 国家/地区
@property (nonatomic, strong) UILabel *countryFixLabel;
 // 国家显示
@property (nonatomic, strong) UILabel *countryLabel;
 // 箭头
@property (nonatomic, strong) UIButton *arrowImage;
 // 国家底部线
@property (nonatomic, strong) UIView *countryBottomLine;
 // 电话前缀
@property (nonatomic, strong) UILabel *prefixPhoneLabel;
 // 电话中间线
@property (nonatomic, strong) UIView *phoneCenterLine;
 // 电话label
@property (nonatomic, strong) UITextField *phoneTextField;
 // 手机号码底部线
@property (nonatomic, strong) UIView *phoneBottomLine;
 // 验证码输入框
@property (nonatomic, strong) UITextField *codeTextField;
 // 发送验证码
@property (nonatomic, strong) UIButton *sendCodeButton;
 // 验证码底部线
@property (nonatomic, strong) UIView *codeBottomLine;
 // 下一步按钮
@property (nonatomic, strong) UIButton *nextButton;
 // 无法获取验证码
@property (nonatomic, strong) UIButton *dontGetCodeButton;

@end

@implementation CodeLoginView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        [self updateFrame];
    }
    return self;
}

#pragma mark --- UI创建
- (void)setupUI {
     // 返回按钮
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:_backButton];
    
     // 国家/地区
    _countryFixLabel = [[UILabel alloc] init];
    _countryFixLabel.text = @"国家/地区";
    _countryFixLabel.textColor = [UIColor blackColor];
    _countryFixLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:_countryFixLabel];
    
     // 国家
    _countryLabel = [[UILabel alloc] init];
    _countryLabel.text = @"中国";
    _countryLabel.textColor = [UIColor blackColor];
    _countryLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:_countryLabel];
    
     // 箭头
    _arrowImage = [UIButton buttonWithType:UIButtonTypeCustom];
    [_arrowImage setImage:[UIImage imageNamed:@"rightArrows"] forState:UIControlStateNormal];
    [self addSubview:_arrowImage];
    
     // 国家底部线
    _countryBottomLine = [[UIView alloc] init];
    _countryBottomLine.backgroundColor = kColorA(219, 219, 219, 1);
    [self addSubview:_countryBottomLine];
    
     // 电话前缀
    _prefixPhoneLabel = [[UILabel alloc] init];
    _prefixPhoneLabel.text = @"+86";
    _prefixPhoneLabel.textColor = [UIColor blackColor];
    _prefixPhoneLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:_prefixPhoneLabel];
    
     // 电话号码中间线
    _phoneCenterLine = [[UIView alloc] init];
    _phoneCenterLine.backgroundColor = kColorA(219, 219, 219, 1);
    [self addSubview:_phoneCenterLine];
    
     // 电话号码
    _phoneTextField = [[UITextField alloc] init];
    _phoneTextField.textColor = [UIColor blackColor];
    _phoneTextField.font = [UIFont systemFontOfSize:16];
    _phoneTextField.placeholder = @"请输入电话号码";
    [_phoneTextField setValue:kColorA(178, 178, 178, 1) forKeyPath:@"_placeholderLabel.textColor"];
    _phoneTextField.delegate = self;
    [_phoneTextField becomeFirstResponder];
    _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:_phoneTextField];
    
     // 电话号码底部线
    _phoneBottomLine = [[UIView alloc] init];
    _phoneBottomLine.backgroundColor = kColorA(219, 219, 219, 1);
    [self addSubview:_phoneBottomLine];
    
     // 验证码输入框
    _codeTextField = [[UITextField alloc] init];
    _codeTextField.textColor = [UIColor blackColor];
    _codeTextField.font = [UIFont systemFontOfSize:16];
    _codeTextField.textAlignment = NSTextAlignmentCenter;
    [_codeTextField setValue:kColorA(178, 178, 178, 1) forKeyPath:@"_placeholderLabel.textColor"];
    _codeTextField.placeholder = @"请填写验证码";
    _codeTextField.delegate = self;
    _codeTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:_codeTextField];
    
     // 验证码
    _sendCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_sendCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_sendCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_sendCodeButton setBackgroundColor:zhundaoGreenColor];
    _sendCodeButton.titleLabel.font = [UIFont systemFontOfSize:16];
    _sendCodeButton.layer.cornerRadius = 4;
    _sendCodeButton.layer.masksToBounds = YES;
    [_sendCodeButton addTarget:self action:@selector(sendCode) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_sendCodeButton];
    
     // 验证码底部线
    _codeBottomLine = [[UIView alloc] init];
    _codeBottomLine.backgroundColor = kColorA(219, 219, 219, 1);
    [self addSubview:_codeBottomLine];
    
     // 下一步
    _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextButton.layer.cornerRadius = 5;
    _nextButton.layer.masksToBounds = YES;
    [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [_nextButton setTitleColor:kColorA(255, 255, 255, 0.4) forState:UIControlStateNormal];
    [_nextButton setBackgroundColor:kColorA(175, 220, 168, 1)];
    _nextButton.userInteractionEnabled = YES;
    _nextButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_nextButton addTarget:self action:@selector(nextStep) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_nextButton];
    
     // 无法获取验证码
    _dontGetCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_dontGetCodeButton setTitle:@"无法获取验证码" forState:UIControlStateNormal];
    [_dontGetCodeButton setTitleColor:zhundaoGreenColor forState:UIControlStateNormal];
    [_dontGetCodeButton addTarget:self action:@selector(codeWeb) forControlEvents:UIControlEventTouchUpInside];
    _dontGetCodeButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_dontGetCodeButton];
}

#pragma mark --- 自动布局
- (void)updateFrame {
     // 返回
    [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self).offset(30);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
     // 国家/地区
    CGSize countryFixSize = [_countryFixLabel sizeThatFits:CGSizeMake(200, 20)];
    [_countryFixLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(_backButton.mas_bottom).offset(40);
        make.size.mas_equalTo(CGSizeMake(countryFixSize.width + 10, countryFixSize.height));
    }];
    
     // 国家
    [_countryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_countryFixLabel.mas_right).offset(20);
        make.top.equalTo(_countryFixLabel.mas_top);
        make.right.equalTo(self).offset(-40);
        make.height.mas_equalTo(countryFixSize.height);
    }];
    
     // 箭头
    [_arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.top.equalTo(_countryFixLabel.mas_top).offset(4);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
     // 国家下边线
    [_countryBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_countryFixLabel.mas_bottom).offset(8);
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.height.mas_equalTo(0.5);
    }];
    
     // 手机前缀
    CGSize prefixPhoneSize = [_prefixPhoneLabel sizeThatFits:CGSizeMake(100, 20)];
    [_prefixPhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(prefixPhoneSize.width + 5);
        make.top.equalTo(_countryBottomLine.mas_bottom);
    }];
    
     // 手机中间线
    [_phoneCenterLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_countryBottomLine.mas_bottom);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(0.5);
        make.left.equalTo(_prefixPhoneLabel.mas_right).offset(10);
    }];
    
     // 手机输入框
    [_phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_phoneCenterLine.mas_right).offset(15);
        make.top.equalTo(_countryBottomLine.mas_bottom);
        make.bottom.equalTo(_prefixPhoneLabel.mas_bottom);
        make.right.equalTo(self).offset(-15);
    }];
    
     // 手机下的线
    [_phoneBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(_prefixPhoneLabel.mas_bottom);
        make.height.mas_equalTo(0.5);
    }];
    
     // 验证码输入框
    [_codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_phoneBottomLine.mas_bottom);
        make.height.mas_equalTo(40);
        make.left.equalTo(self).offset(15);
        make.right.equalTo(_sendCodeButton.mas_left);
    }];
    
     // 验证码发送
    CGSize sendCodeSize = [_sendCodeButton.titleLabel sizeThatFits:CGSizeMake(200, 20)];
    [_sendCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(_phoneBottomLine.mas_bottom);
        make.bottom.equalTo(_codeTextField.mas_bottom);
        make.width.mas_equalTo(sendCodeSize.width + 40);
    }];
    
     // 验证码下划线
    [_codeBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_codeTextField.mas_bottom);
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.height.mas_equalTo(0.5);
    }];
    
     // 下一步按钮
    [_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(_codeBottomLine.mas_bottom).offset(30);
        make.height.mas_equalTo(44);
    }];
    
     // 无法获取验证码
    CGSize codeSize = [_dontGetCodeButton sizeThatFits:CGSizeMake(200, 20)];
    [_dontGetCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(_nextButton.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(codeSize.width, codeSize.height));
    }];
}
#pragma mark --- UITextFieldDelegate
 // 结束编辑 
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([textField isEqual:_phoneTextField]) {
        if (_sendCodeButton.userInteractionEnabled) {
            [self sendCode];
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (_codeTextField.text.length) {
        [_nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nextButton setBackgroundColor:zhundaoGreenColor];
        _nextButton.userInteractionEnabled = YES;
    } else {
        [_nextButton setTitleColor:kColorA(255, 255, 255, 0.4) forState:UIControlStateNormal];
        [_nextButton setBackgroundColor:kColorA(175, 220, 168, 1)];
        _nextButton.userInteractionEnabled = NO;
    }
    return YES;
}

#pragma mark --- 点击事件
 // 返回
- (void)back {
    if ([self.codeLoginViewDelegate respondsToSelector:@selector(backLogin)]) {
        [self.codeLoginViewDelegate backLogin];
    }
}

 // 发送验证码
- (void)sendCode {
     // 判断手机号
    if (_phoneTextField.text.length != 11) {
        maskLabel *label = [[maskLabel alloc] initWithTitle:@"请输入正确的手机号"];
        [label labelAnimationWithViewlong:self];
        return;
    }
     // 验证码输入框弹出 
    [_codeTextField becomeFirstResponder];
    
    __block int timeout =60;
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        if (timeout<=0) {
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                _sendCodeButton.userInteractionEnabled = YES;
                [_sendCodeButton setBackgroundColor:zhundaoGreenColor];
                [_sendCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
            });
            
            
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                _sendCodeButton.userInteractionEnabled = NO;
                [_sendCodeButton setBackgroundColor:kColorA(200, 200, 200, 1)];
                [_sendCodeButton setTitle:[NSString stringWithFormat:@"(%d)发送验证码",timeout] forState:UIControlStateNormal];
                timeout--;
            });
            
        }
    });
    dispatch_resume(timer);
    
     // 发送验证码
    if ([self.codeLoginViewDelegate respondsToSelector:@selector(codeLoginView:phoneStr:)]) {
        [self.codeLoginViewDelegate codeLoginView:self phoneStr:_phoneTextField.text];
    }
}

 // 下一步
- (void)nextStep {
    [self endEditing:YES];
    if (self.phoneTextField.text.length != 11) {
        maskLabel *label = [[maskLabel alloc] initWithTitle:@"请输入正确的手机号"];
        [label labelAnimationWithViewlong:self];
        return;
    }
    
     // 登录 
    if ([self.codeLoginViewDelegate respondsToSelector:@selector(loginWithPhoneStr:code:)]) {
        [self.codeLoginViewDelegate loginWithPhoneStr:self.phoneTextField.text code:self.codeTextField.text];
    }
}

 // 无法获取验证码
- (void)codeWeb {
    if ([self.codeLoginViewDelegate respondsToSelector:@selector(goCodeWeb)]) {
        [self.codeLoginViewDelegate goCodeWeb];
    }
}

@end
