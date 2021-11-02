//
//  ZDServiceAlertView.m
//  zhundao
//
//  Created by maj on 2020/1/13.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "ZDServiceAlertView.h"

#import "UILabel+YBAttributeTextTapAction.h"

@interface ZDServiceAlertView()<UITextViewDelegate, YBAttributeTapActionDelegate>
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIButton *checkButton;
@property (nonatomic, strong) UILabel *confirmLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *sureButton;

@property (nonatomic, copy) ZDBlock_Void cancelBlock;
@property (nonatomic, copy) ZDBlock_Void sureBlock;

@end

@implementation ZDServiceAlertView

- (instancetype)init {
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        [self setupUI];
        [self initLayout];
    }
    return self;
}

- (instancetype)initWithCancelBlock:(ZDBlock_Void)cancelBlock sureBlock:(ZDBlock_Void)sureBlock {
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        _cancelBlock = cancelBlock;
        _sureBlock = sureBlock;
        [self setupUI];
        [self initLayout];
    }
    return self;
}

#pragma mark --- UI
- (void)setupUI {
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.textView];
    [self.contentView addSubview:self.checkButton];
    [self.contentView addSubview:self.confirmLabel];
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.sureButton];
    [self.contentView addSubview:self.cancelButton];
}

#pragma mark --- 布局
- (void)initLayout {
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.leading.equalTo(self).offset(30);
        make.trailing.equalTo(self).offset(-30);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.height.mas_equalTo(50);
        make.leading.equalTo(self.contentView).offset(20);
        make.trailing.equalTo(self.contentView).offset(-20);
    }];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(0);
        make.leading.trailing.equalTo(self.contentView).offset(20);
        make.trailing.equalTo(self.contentView).offset(-20);
        make.height.mas_lessThanOrEqualTo(280);
        make.height.mas_equalTo(280);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.textView);
        make.leading.trailing.equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
    }];
    [self.checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(20);
        make.size.mas_equalTo(CGSizeMake(18, 18));
        make.centerY.equalTo(self.confirmLabel);
    }];
    [self.confirmLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textView.mas_bottom).offset(20);
        make.leading.equalTo(self.checkButton.mas_trailing).offset(10);
        make.trailing.equalTo(self.contentView).offset(-20);
    }];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.confirmLabel.mas_bottom).offset(15);
        make.leading.equalTo(self.contentView).offset(20);
        make.trailing.equalTo(self.contentView.mas_centerX).offset(-8);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-20);
        make.height.mas_equalTo(40);
    }];
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.cancelButton);
        make.leading.equalTo(self.contentView.mas_centerX).offset(8);
        make.trailing.equalTo(self.contentView).offset(-20);
    }];
    [self layoutIfNeeded];
}

#pragma mark --- YBAttributeTapActionDelegate
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    if ([URL.absoluteString containsString:@"xieyi"] ) {
        if ([self.alertViewDelegate respondsToSelector:@selector(alertView:didTapUrl:title:)]) {
            [self.alertViewDelegate alertView:self didTapUrl:URL.absoluteString title:@"《准到用户服务协议》"];
        }
    } else {
        if ([self.alertViewDelegate respondsToSelector:@selector(alertView:didTapUrl:title:)]) {
            [self.alertViewDelegate alertView:self didTapUrl:URL.absoluteString title:@"《准到隐私政策》"];
        }
    }
    return NO;
}
- (void)yb_tapAttributeInLabel:(UILabel *)label string:(NSString *)string range:(NSRange)range index:(NSInteger)index {
    if ([string isEqualToString:@"《准到用户服务协议》"]) {
        if ([self.alertViewDelegate respondsToSelector:@selector(alertView:didTapUrl:title:)]) {
            [self.alertViewDelegate alertView:self didTapUrl:@"https://www.zhundao.net/demo/xieyi.html" title:string];
        }
    } else {
        if ([self.alertViewDelegate respondsToSelector:@selector(alertView:didTapUrl:title:)]) {
            [self.alertViewDelegate alertView:self didTapUrl:@"https://www.zhundao.net/yinsi.html" title:string];
        }
    }
}

#pragma mark --- setter
- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    _titleLabel.textColor = titleColor;
}
- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
    _titleLabel.font = titleFont;
}
- (void)setContent:(NSString *)content {
    _content = content;
    _textView.text = content;
}
- (void)setLinkTextAttributes:(NSDictionary<NSAttributedStringKey,id> *)linkTextAttributes {
    _linkTextAttributes = linkTextAttributes;
    _textView.linkTextAttributes = linkTextAttributes;
}
- (void)setTextViewAlignment:(NSTextAlignment)textViewAlignment {
    _textViewAlignment = textViewAlignment;
    _textView.textAlignment = _textViewAlignment;
}
#pragma mark --- action
- (void)cancelAction:(UIButton *)button {
    ZDDo_Block_Safe_Main(_cancelBlock);
    [self animationOut];
    exit(0);
}
- (void)sureAction:(UIButton *)button {
    if (!_checkButton.selected) {
        ZD_HUD_SHOW_ERROR_STATUS(@"你未打勾同意个人信息保护说明")
        return;
    }
    [self animationOut];
    ZD_UserM.hasShowPrivacy = YES;
}
- (void)checkAction:(UIButton *)button {
    button.selected = !button.selected;
}
- (void)animationIn {
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.01];
    self.contentView.transform = CGAffineTransformMakeScale(0.3, 0.3);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0 options:(UIViewAnimationOptionCurveEaseIn) animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        self.contentView.transform = CGAffineTransformMakeScale(1, 1);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)animationOut {
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0.01;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark --- lazyload
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView new];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.cornerRadius = 10;
        _contentView.layer.masksToBounds = YES;
    }
    return _contentView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDBlackColor font:ZDLightFont(18) numberOfLines:0 lineBreakMode:0 lineAlignment:NSTextAlignmentCenter];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.text = @"个人信息保护说明";
    }
    return _titleLabel;
}
- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.backgroundColor = [UIColor clearColor];
        _textView.textAlignment = NSTextAlignmentLeft;
        _textView.delegate = self;
        _textView.editable = NO;
        _textView.text = @"感谢您信任并使用准到服务，我们非常重视您的个人信息和隐私保护。为向您提供更好的服务，本应用可能会在必要范围内收集、使用或共享您的个人信息。请您在使用前仔细阅读《准到用户服务协议》和《准到隐私政策》，并确认是否同意，同意后将开启我们的服务。\n\n为保障向您提供优质的服务，本应用需要申请获取您的系统权限，我们将在首次调用时逐项征询您是否开启相关权限：\n\n蓝牙\n用于连接蓝牙打印机打印参会者信息\n\n拍照\n用于活动现场扫码二维码签到\n\n定位\n对活动举办地点位置的定位\n\n相册\n用于上传头像和活动发布图片素材上传";
        
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:_textView.text];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:4];
        [attr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, _textView.text.length)];
        [attr addAttribute:NSFontAttributeName value:ZDLightFont(12) range:NSMakeRange(0, _textView.text.length)];
        [attr addAttribute:NSForegroundColorAttributeName value:ZDBlackColor range:NSMakeRange(0, _textView.text.length)];
        [attr addAttributes:@{NSLinkAttributeName: @"https://www.zhundao.net/demo/xieyi.html"} range:[[attr string] rangeOfString:@"《准到用户服务协议》"]];
        [attr addAttributes:@{NSLinkAttributeName: @"https://www.zhundao.net/yinsi.html"} range:[[attr string] rangeOfString:@"《准到隐私政策》"]];
        [attr addAttribute:NSForegroundColorAttributeName value:ZDGreyColor999 range:[_textView.text rangeOfString:@"用于连接蓝牙打印机打印参会者信息"]];
        [attr addAttribute:NSForegroundColorAttributeName value:ZDGreyColor999 range:[_textView.text rangeOfString:@"用于活动现场扫码二维码签到"]];
        [attr addAttribute:NSForegroundColorAttributeName value:ZDGreyColor999 range:[_textView.text rangeOfString:@"对活动举办地点位置的定位"]];
        [attr addAttribute:NSForegroundColorAttributeName value:ZDGreyColor999 range:[_textView.text rangeOfString:@"用于上传头像和活动发布图片素材上传"]];
        _textView.attributedText = attr;
        _textView.linkTextAttributes = @{NSForegroundColorAttributeName : ZDGreenColor};
    }
    return _textView;
}
- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.layer.cornerRadius = 20;
        _cancelButton.layer.masksToBounds = YES;
        _cancelButton.layer.borderColor = ZDLineColor.CGColor;
        _cancelButton.layer.borderWidth = 1;
        [_cancelButton setTitle:@"不同意" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:ZDGrayColor forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = ZDLightFont(12);
        [_cancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}
- (UIButton *)sureButton {
    if (!_sureButton) {
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureButton.layer.cornerRadius = 20;
        _sureButton.layer.masksToBounds = YES;
        _sureButton.backgroundColor = ZDGreenColor2;
        [_sureButton setTitle:@"同意" forState:UIControlStateNormal];
        [_sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sureButton.titleLabel.font = ZDLightFont(12);
        [_sureButton addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureButton;
}
- (UIButton *)checkButton {
    if (!_checkButton) {
        _checkButton = [UIButton buttonWithFrame:CGRectZero normalImage:[UIImage imageNamed:@"me_check_normal"] selectedImage:[UIImage imageNamed:@"me_check_select"] target:self action:@selector(checkAction:)];
        _checkButton.addInsetWidth = 20;
        _checkButton.addInsetHeight = 20;
    }
    return _checkButton;
}
- (UILabel *)confirmLabel {
    if (!_confirmLabel) {
        _confirmLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDBlackColor font:ZDLightFont(12) numberOfLines:0 lineBreakMode:0 lineAlignment:NSTextAlignmentCenter];
        _confirmLabel.text = @"使用APP前请阅读并同意《准到用户服务协议》《准到隐私政策》";
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:_confirmLabel.text];
        [attr addAttribute:NSFontAttributeName value:ZDLightFont(12) range:NSMakeRange(0, _confirmLabel.text.length - 1)];
        [attr addAttribute:NSForegroundColorAttributeName value:ZDGreenColor range:[_confirmLabel.text rangeOfString:@"《准到用户服务协议》"]];
        [attr addAttribute:NSForegroundColorAttributeName value:ZDGreenColor range:[_confirmLabel.text rangeOfString:@"《准到隐私政策》"]];
        _confirmLabel.attributedText = attr;
        
        _confirmLabel.tapHighlightedColor = [UIColor clearColor];
        [_confirmLabel yb_addAttributeTapActionWithStrings:@[@"《准到用户服务协议》", @"《准到隐私政策》"] delegate:self];
    }
    return _confirmLabel;
}
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = ZDLineColor;
    }
    return _lineView;
}

@end
