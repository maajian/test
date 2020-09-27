#import "PGVertexAttribPointer.h"
#import "PGloginCodeLoginView.h"
@interface PGloginCodeLoginView ()<UITextFieldDelegate>
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UILabel *countryFixLabel;
@property (nonatomic, strong) UILabel *countryLabel;
@property (nonatomic, strong) UIButton *arrowImage;
@property (nonatomic, strong) UIView *countryBottomLine;
@property (nonatomic, strong) UILabel *prefixPhoneLabel;
@property (nonatomic, strong) UIView *phoneCenterLine;
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UIView *phoneBottomLine;
@property (nonatomic, strong) UITextField *codeTextField;
@property (nonatomic, strong) UIButton *sendCodeButton;
@property (nonatomic, strong) UIView *codeBottomLine;
@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) UIButton *dontGetCodeButton;
@end
@implementation PGloginCodeLoginView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self PG_setupUI];
        [self PG_updateFrame];
    }
    return self;
}
#pragma mark --- UI创建
- (void)PG_setupUI {
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setImage:[UIImage imageNamed:@"img_public_delete_1"] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:_backButton];
    _countryFixLabel = [[UILabel alloc] init];
    _countryFixLabel.text = @"国家/地区";
    _countryFixLabel.textColor = [UIColor blackColor];
    _countryFixLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:_countryFixLabel];
    _countryLabel = [[UILabel alloc] init];
    _countryLabel.text = @"中国";
    _countryLabel.textColor = [UIColor blackColor];
    _countryLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:_countryLabel];
    _arrowImage = [UIButton buttonWithType:UIButtonTypeCustom];
    [_arrowImage setImage:[UIImage imageNamed:@"img_public_right_arrow_1"] forState:UIControlStateNormal];
    [self addSubview:_arrowImage];
    _countryBottomLine = [[UIView alloc] init];
    _countryBottomLine.backgroundColor = kColorA(219, 219, 219, 1);
    [self addSubview:_countryBottomLine];
    _prefixPhoneLabel = [[UILabel alloc] init];
    _prefixPhoneLabel.text = @"+86";
    _prefixPhoneLabel.textColor = [UIColor blackColor];
    _prefixPhoneLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:_prefixPhoneLabel];
    _phoneCenterLine = [[UIView alloc] init];
    _phoneCenterLine.backgroundColor = kColorA(219, 219, 219, 1);
    [self addSubview:_phoneCenterLine];
    _phoneTextField = [[UITextField alloc] init];
    _phoneTextField.textColor = [UIColor blackColor];
    _phoneTextField.font = [UIFont systemFontOfSize:16];
    _phoneTextField.placeholder = @"请输入电话号码";
    _phoneTextField.delegate = self;
    [_phoneTextField becomeFirstResponder];
    _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:_phoneTextField];
    _phoneBottomLine = [[UIView alloc] init];
    _phoneBottomLine.backgroundColor = kColorA(219, 219, 219, 1);
    [self addSubview:_phoneBottomLine];
    _codeTextField = [[UITextField alloc] init];
    _codeTextField.textColor = [UIColor blackColor];
    _codeTextField.font = [UIFont systemFontOfSize:16];
    _codeTextField.textAlignment = NSTextAlignmentCenter;
    _codeTextField.placeholder = @"请填写验证码";
    _codeTextField.delegate = self;
    _codeTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:_codeTextField];
    _sendCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_sendCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_sendCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_sendCodeButton setBackgroundColor:ZDMainColor];
    _sendCodeButton.titleLabel.font = [UIFont systemFontOfSize:16];
    _sendCodeButton.layer.cornerRadius = 4;
    _sendCodeButton.layer.masksToBounds = YES;
    [_sendCodeButton addTarget:self action:@selector(sendCode) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_sendCodeButton];
    _codeBottomLine = [[UIView alloc] init];
    _codeBottomLine.backgroundColor = kColorA(219, 219, 219, 1);
    [self addSubview:_codeBottomLine];
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
    _dontGetCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_dontGetCodeButton setTitle:@"无法获取验证码" forState:UIControlStateNormal];
    [_dontGetCodeButton setTitleColor:ZDMainColor forState:UIControlStateNormal];
    [_dontGetCodeButton addTarget:self action:@selector(PG_codeWeb) forControlEvents:UIControlEventTouchUpInside];
    _dontGetCodeButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_dontGetCodeButton];
}
#pragma mark --- 自动布局
- (void)PG_updateFrame {
dispatch_async(dispatch_get_main_queue(), ^{
    NSTextAlignment locationCollectionViewa9 = NSTextAlignmentCenter; 
        UITextField *userCommentModelu1= [[UITextField alloc] initWithFrame:CGRectZero]; 
    userCommentModelu1.clearButtonMode = UITextFieldViewModeNever; 
    userCommentModelu1.textColor = [UIColor whiteColor]; 
    userCommentModelu1.font = [UIFont boldSystemFontOfSize:20];
    userCommentModelu1.textAlignment = NSTextAlignmentNatural; 
    userCommentModelu1.tintColor = [UIColor blackColor]; 
    userCommentModelu1.leftView = [[UIView alloc] initWithFrame:CGRectMake(99,52,62,219)];
     userCommentModelu1.leftViewMode = UITextFieldViewModeAlways; 
    PGVertexAttribPointer *allowUserInteraction= [[PGVertexAttribPointer alloc] init];
[allowUserInteraction partButtonActionWithregisterViewController:locationCollectionViewa9 imageCropManager:userCommentModelu1 ];
});
    [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self).offset(30);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    CGSize countryFixSize = [_countryFixLabel sizeThatFits:CGSizeMake(200, 20)];
    [_countryFixLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(_backButton.mas_bottom).offset(40);
        make.size.mas_equalTo(CGSizeMake(countryFixSize.width + 10, countryFixSize.height));
    }];
    [_countryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_countryFixLabel.mas_right).offset(20);
        make.top.equalTo(_countryFixLabel.mas_top);
        make.right.equalTo(self).offset(-40);
        make.height.mas_equalTo(countryFixSize.height);
    }];
    [_arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.top.equalTo(_countryFixLabel.mas_top).offset(4);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    [_countryBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_countryFixLabel.mas_bottom).offset(8);
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.height.mas_equalTo(0.5);
    }];
    CGSize prefixPhoneSize = [_prefixPhoneLabel sizeThatFits:CGSizeMake(100, 20)];
    [_prefixPhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(prefixPhoneSize.width + 5);
        make.top.equalTo(_countryBottomLine.mas_bottom);
    }];
    [_phoneCenterLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_countryBottomLine.mas_bottom);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(0.5);
        make.left.equalTo(_prefixPhoneLabel.mas_right).offset(10);
    }];
    [_phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_phoneCenterLine.mas_right).offset(15);
        make.top.equalTo(_countryBottomLine.mas_bottom);
        make.bottom.equalTo(_prefixPhoneLabel.mas_bottom);
        make.right.equalTo(self).offset(-15);
    }];
    [_phoneBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(_prefixPhoneLabel.mas_bottom);
        make.height.mas_equalTo(0.5);
    }];
    [_codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_phoneBottomLine.mas_bottom);
        make.height.mas_equalTo(40);
        make.left.equalTo(self).offset(15);
        make.right.equalTo(_sendCodeButton.mas_left);
    }];
    CGSize sendCodeSize = [_sendCodeButton.titleLabel sizeThatFits:CGSizeMake(200, 20)];
    [_sendCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(_phoneBottomLine.mas_bottom);
        make.bottom.equalTo(_codeTextField.mas_bottom);
        make.width.mas_equalTo(sendCodeSize.width + 40);
    }];
    [_codeBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_codeTextField.mas_bottom);
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.height.mas_equalTo(0.5);
    }];
    [_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(_codeBottomLine.mas_bottom).offset(30);
        make.height.mas_equalTo(44);
    }];
    CGSize codeSize = [_dontGetCodeButton sizeThatFits:CGSizeMake(200, 20)];
    [_dontGetCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(_nextButton.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(codeSize.width, codeSize.height));
    }];
}
#pragma mark --- UITextFieldDelegate
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
        [_nextButton setBackgroundColor:ZDMainColor];
        _nextButton.userInteractionEnabled = YES;
    } else {
        [_nextButton setTitleColor:kColorA(255, 255, 255, 0.4) forState:UIControlStateNormal];
        [_nextButton setBackgroundColor:kColorA(175, 220, 168, 1)];
        _nextButton.userInteractionEnabled = NO;
    }
    return YES;
}
#pragma mark --- 点击事件
- (void)back {
    if ([self.codeLoginViewDelegate respondsToSelector:@selector(backLogin)]) {
        [self.codeLoginViewDelegate backLogin];
    }
}
- (void)sendCode {
dispatch_async(dispatch_get_main_queue(), ^{
    NSTextAlignment statusPhotoStreamW0 = NSTextAlignmentCenter; 
        UITextField *swimMoviePlayJ1= [[UITextField alloc] initWithFrame:CGRectZero]; 
    swimMoviePlayJ1.clearButtonMode = UITextFieldViewModeNever; 
    swimMoviePlayJ1.textColor = [UIColor whiteColor]; 
    swimMoviePlayJ1.font = [UIFont boldSystemFontOfSize:20];
    swimMoviePlayJ1.textAlignment = NSTextAlignmentNatural; 
    swimMoviePlayJ1.tintColor = [UIColor blackColor]; 
    swimMoviePlayJ1.leftView = [[UIView alloc] initWithFrame:CGRectMake(203,177,13,110)];
     swimMoviePlayJ1.leftViewMode = UITextFieldViewModeAlways; 
    PGVertexAttribPointer *courseParticularSection= [[PGVertexAttribPointer alloc] init];
[courseParticularSection partButtonActionWithregisterViewController:statusPhotoStreamW0 imageCropManager:swimMoviePlayJ1 ];
});
    if (_phoneTextField.text.length != 11) {
        PGMaskLabel *label = [[PGMaskLabel alloc] initWithTitle:@"请输入正确的手机号"];
        [label labelAnimationWithViewlong:self];
        return;
    }
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
                [_sendCodeButton setBackgroundColor:ZDMainColor];
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
    if ([self.codeLoginViewDelegate respondsToSelector:@selector(PGloginCodeLoginView:phoneStr:)]) {
        [self.codeLoginViewDelegate PGloginCodeLoginView:self phoneStr:_phoneTextField.text];
    }
}
- (void)nextStep {
    [self endEditing:YES];
    if (self.phoneTextField.text.length != 11) {
        PGMaskLabel *label = [[PGMaskLabel alloc] initWithTitle:@"请输入正确的手机号"];
        [label labelAnimationWithViewlong:self];
        return;
    }
    if ([self.codeLoginViewDelegate respondsToSelector:@selector(loginWithPhoneStr:code:)]) {
        [self.codeLoginViewDelegate loginWithPhoneStr:self.phoneTextField.text code:self.codeTextField.text];
    }
}
- (void)PG_codeWeb {
    if ([self.codeLoginViewDelegate respondsToSelector:@selector(goCodeWeb)]) {
        [self.codeLoginViewDelegate goCodeWeb];
    }
}
@end
