#import "PGFirendsViewModel.h"
#import "PGLogInfoEditView.h"
@interface PGLogInfoEditView()<UITextFieldDelegate> {
    NSString *_phoneStr;
}
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UIView *topLine;
@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UIView *centerLine;
@property (nonatomic, strong) UITextField *passWordTextField;
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) UIButton *nextButton;
@end
@implementation PGLogInfoEditView
- (instancetype)initWithFrame:(CGRect)frame phoneStr:(NSString *)phoneStr{
    if (self = [super initWithFrame:frame]) {
        _phoneStr = phoneStr;
        [self PG_setupUI];
        [self PG_updateFrame];
    }
    return self;
}
#pragma mark --- UI创建
- (void)PG_setupUI {
dispatch_async(dispatch_get_main_queue(), ^{
    UITableViewStyle sendButtonStatusb0 = UITableViewStylePlain; 
        CGPoint arrayUsingComparatorG7 = CGPointZero;
    PGFirendsViewModel *strokeCourseData= [[PGFirendsViewModel alloc] init];
[strokeCourseData vertexAttribPointerWithrouteChangeListener:sendButtonStatusb0 showFullButton:arrayUsingComparatorG7 ];
});
    _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_closeButton setImage:[UIImage imageNamed:@"img_public_delete_1"] forState:UIControlStateNormal];
    [_closeButton addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:_closeButton];
    _phoneLabel = [[UILabel alloc] init];
    _phoneLabel.text = [NSString stringWithFormat:@"+86 %@",_phoneStr];
    _phoneLabel.textColor = kColorA(51, 51, 51, 1);
    _phoneLabel.textAlignment = NSTextAlignmentCenter;
    _phoneLabel.font = [UIFont boldSystemFontOfSize:16];
    [self addSubview:_phoneLabel];
    _topLine = [[UIView alloc] init];
    _topLine.backgroundColor = kColorA(219, 219, 219, 1);
    [self addSubview:_topLine];
    _nameTextField = [[UITextField alloc] init];
    _nameTextField.textColor = kColorA(102, 102, 102, 1);
    _nameTextField.font = [UIFont systemFontOfSize:14];
    _nameTextField.placeholder = @"请输入姓名";
    _nameTextField.delegate = self;
    [_nameTextField becomeFirstResponder];
    [self addSubview:_nameTextField];
    _centerLine = [[UIView alloc] init];
    _centerLine.backgroundColor = kColorA(219, 219, 219, 1);
    [self addSubview:_centerLine];
    _passWordTextField = [[UITextField alloc] init];
    _passWordTextField.textColor = kColorA(102, 102, 102, 1);
    _passWordTextField.font = [UIFont systemFontOfSize:14];
    _passWordTextField.placeholder = @"请输入登录密码";
    _passWordTextField.delegate = self;
    _passWordTextField.secureTextEntry = YES;
    [self addSubview:_passWordTextField];
    _bottomLine = [[UIView alloc] init];
    _bottomLine.backgroundColor = kColorA(219, 219, 219, 1);
    [self addSubview:_bottomLine];
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
- (void)PG_updateFrame {
    [_closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self).offset(30);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_closeButton.mas_bottom).offset(20);
        make.left.equalTo(self).offset(0);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 14));
    }];
    [_topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_phoneLabel.mas_bottom).offset(20);
        make.left.equalTo(self.mas_left).offset(15);
        make.right.equalTo(self.mas_right).offset(-15);
        make.height.mas_equalTo(0.5);
    }];
    [_nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topLine.mas_bottom);
        make.height.mas_equalTo(40);
        make.left.equalTo(_topLine);
        make.right.equalTo(_topLine);
    }];
    [_centerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topLine);
        make.right.equalTo(_topLine);
        make.top.equalTo(_nameTextField.mas_bottom);
        make.height.mas_equalTo(0.5);
    }];
    [_passWordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topLine);
        make.right.equalTo(_topLine);
        make.top.equalTo(_centerLine.mas_bottom);
        make.height.mas_equalTo(40);
    }];
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topLine);
        make.right.equalTo(_topLine);
        make.top.equalTo(_passWordTextField.mas_bottom);
        make.height.mas_equalTo(0.5);
    }];
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
- (void)back {
    if ([self.infoEditViewDelegate respondsToSelector:@selector(backPop)]) {
        [self.infoEditViewDelegate backPop];
    }
}
- (void)nextStep {
    if (self.nameTextField.text.length == 0) {
        [self PG_showAlert:@"姓名不能为空"];
    } else if (self.nameTextField.text.length > 15) {
        [self PG_showAlert:@"姓名不得超出15个字符"];
    } else if (self.passWordTextField.text.length < 6) {
        [self PG_showAlert:@"密码至少6个字符"];
    } else {
        if ([self.infoEditViewDelegate respondsToSelector:@selector(finishEditWithName:passWord:)]) {
            [self.infoEditViewDelegate finishEditWithName:_nameTextField.text passWord:_passWordTextField.text];
        }
    }
}
#pragma mark --- action
- (void)PG_showAlert:(NSString *)str {
    PGMaskLabel *label = [[PGMaskLabel alloc] initWithTitle:str];
    [label labelAnimationWithViewlong:self];
}
@end
