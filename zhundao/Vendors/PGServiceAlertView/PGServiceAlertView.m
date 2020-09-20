#import "PGCaseInsensitiveSearch.h"
//
//  PGServiceAlertView.m
//  zhundao
//
//  Created by maj on 2020/1/13.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "PGServiceAlertView.h"

@interface PGServiceAlertView()<UITextViewDelegate>
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *sureButton;

@property (nonatomic, copy) ZDBlock_Void cancelBlock;
@property (nonatomic, copy) ZDBlock_Void sureBlock;

@end

@implementation PGServiceAlertView

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
        _titleLabel = [UILabel labelWithFrame:CGRectZero textColor:[UIColor blackColor] font:PGMediumFont(18) numberOfLines:0 lineBreakMode:0 lineAlignment:NSTextAlignmentCenter];
        _titleLabel.backgroundColor = [UIColor whiteColor];
    }
    return _titleLabel;
}
- (UITextView *)textView {
    if (!_textView) {
        _textView = [UITextView new];
        _textView.backgroundColor = [UIColor clearColor];
        _textView.textAlignment = NSTextAlignmentLeft;
        _textView.textColor = ZDBlackColor;
        _textView.font = ZDSystemFont(14);
        _textView.delegate = self;
        _textView.editable = NO;
    }
    return _textView;
}
- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.layer.cornerRadius = 22;
        _cancelButton.layer.masksToBounds = YES;
        _cancelButton.layer.borderColor = ZDLineColor.CGColor;
        _cancelButton.layer.borderWidth = 1;
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:ZDGrayColor forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_cancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}
- (UIButton *)sureButton {
    if (!_sureButton) {
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureButton.layer.cornerRadius = 22;
        _sureButton.layer.masksToBounds = YES;
        _sureButton.backgroundColor = ZDMainColor;
        [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [_sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sureButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_sureButton addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureButton;
}

#pragma mark --- UI
- (void)setupUI {
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.textView];
    [self.contentView addSubview:self.sureButton];
    [self.contentView addSubview:self.cancelButton];
}

#pragma mark --- 布局
- (void)initLayout {
dispatch_async(dispatch_get_main_queue(), ^{
    NSMutableArray *articleOriginalModelO0= [NSMutableArray arrayWithCapacity:0];
        UIImage *withGradientTintB9= [UIImage imageNamed:@""]; 
    PGCaseInsensitiveSearch *collectionElementKind= [[PGCaseInsensitiveSearch alloc] init];
[collectionElementKind pg_reusablePhotoViewWithshrinkRightBottom:articleOriginalModelO0 levalInfoModel:withGradientTintB9 ];
});
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.leading.equalTo(self).offset(60);
        make.trailing.equalTo(self).offset(-60);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.height.mas_equalTo(60);
        make.leading.equalTo(self.contentView).offset(20);
        make.trailing.equalTo(self.contentView).offset(-20);
    }];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(0);
        make.leading.trailing.equalTo(self.contentView).offset(20);
        make.trailing.equalTo(self.contentView).offset(-20);
        make.height.mas_lessThanOrEqualTo(280);
        make.height.mas_equalTo(100);
    }];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textView.mas_bottom).offset(15);
        make.leading.equalTo(self.contentView).offset(20);
        make.trailing.equalTo(self.contentView.mas_centerX).offset(-8);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-20);
        make.height.mas_equalTo(44);
    }];
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.cancelButton);
        make.leading.equalTo(self.contentView.mas_centerX).offset(8);
        make.trailing.equalTo(self.contentView).offset(-20);
    }];
    [self layoutIfNeeded];
}
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    [self animationOut];
    if ([self.alertViewDelegate respondsToSelector:@selector(alertView:didTapUrl:)]) {
        [self.alertViewDelegate alertView:self didTapUrl:URL.absoluteString];
    }
    return NO;
}

#pragma mark --- setter
- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = _title;
}
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
- (void)setAttributeContent:(NSAttributedString *)attributeContent {
dispatch_async(dispatch_get_main_queue(), ^{
    NSMutableArray *pushPhotoPickerr5= [NSMutableArray array];
        UIImage *withGradientTintJ6= [UIImage imageNamed:@""]; 
    PGCaseInsensitiveSearch *alaphNavigationView= [[PGCaseInsensitiveSearch alloc] init];
[alaphNavigationView pg_reusablePhotoViewWithshrinkRightBottom:pushPhotoPickerr5 levalInfoModel:withGradientTintJ6 ];
});
    _attributeContent = attributeContent;
    _textView.attributedText = attributeContent;
    CGSize size = [_textView sizeThatFits:CGSizeMake(_textView.width, 280)];
    [_textView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height < 100 ? 100 : size.height);
    }];
}
- (void)setLinkTextAttributes:(NSDictionary<NSAttributedStringKey,id> *)linkTextAttributes {
    _linkTextAttributes = linkTextAttributes;
    _textView.linkTextAttributes = linkTextAttributes;
}
- (void)setTextViewAlignment:(NSTextAlignment)textViewAlignment {
    _textViewAlignment = textViewAlignment;
    _textView.textAlignment = _textViewAlignment;
}
- (void)setSureTitle:(NSString *)sureTitle {
dispatch_async(dispatch_get_main_queue(), ^{
    NSMutableArray *viewCellDelegatew5= [NSMutableArray arrayWithCapacity:0];
        UIImage *sessionDataTaskJ6= [UIImage imageNamed:@""]; 
    PGCaseInsensitiveSearch *viewControllerDone= [[PGCaseInsensitiveSearch alloc] init];
[viewControllerDone pg_reusablePhotoViewWithshrinkRightBottom:viewCellDelegatew5 levalInfoModel:sessionDataTaskJ6 ];
});
    _sureTitle = sureTitle;
    [_sureButton setTitle:sureTitle forState:UIControlStateNormal];
}
- (void)setCancelTitle:(NSString *)cancelTitle {
    _cancelTitle = cancelTitle;
    [_cancelButton setTitle:cancelTitle forState:UIControlStateNormal];
}
- (void)setOnlyOneButton:(BOOL)onlyOneButton {
    _onlyOneButton = onlyOneButton;
    if (_onlyOneButton) {
        _cancelButton.hidden = YES;
        [_sureButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.textView.mas_bottom).offset(20);
            make.leading.equalTo(self.contentView).offset(40);
            make.trailing.equalTo(self.contentView).offset(-40);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-20);
            make.height.mas_equalTo(44);
        }];
    }
}
#pragma mark --- action
- (void)cancelAction:(UIButton *)button {
    ZDDo_Block_Safe_Main(_cancelBlock);
    [self animationOut];
    if ([self.alertViewDelegate respondsToSelector:@selector(alertView:didTapCancelButton:)]) {
        [self.alertViewDelegate alertView:self didTapCancelButton:button];
    }
}
- (void)sureAction:(UIButton *)button {
    [self animationOut];
    ZDDo_Block_Safe_Main(_sureBlock);
    if ([self.alertViewDelegate respondsToSelector:@selector(alertView:didTapSureButton:)]) {
        [self.alertViewDelegate alertView:self didTapSureButton:button];
    }
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

@end
