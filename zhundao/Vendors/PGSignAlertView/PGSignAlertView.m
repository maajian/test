#import "PGColumnistChildData.h"
#import "PGSignAlertView.h"
@interface PGSignAlertView() {
    NSString *_title;
    NSString *_cancelTitle;
    NSString *_sureTitle;
    NSString *_messageTitle;
}
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *sureButton;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, copy) ZDBlock_Void cancelBlock;
@property (nonatomic, copy) ZDBlock_Void sureBlock;
@property (nonatomic, strong) UIColor *titleColor;
@end
@implementation PGSignAlertView
+ (instancetype)alertWithTitle:(NSString *)title titleColor:(UIColor *)titleColor messageTitle:(NSString *)messageTitle cancelTitle:(NSString *)cancelTitle sureTitle:(NSString *)sureTitle cancelBlock:(ZDBlock_Void)cancelBlock sureBlock:(ZDBlock_Void)sureBlock {
    PGSignAlertView *alert = [[self alloc] initWithFrame:[UIScreen mainScreen].bounds title:title titleColor:titleColor messageTitle:messageTitle cancelTitle:cancelTitle sureTitle:sureTitle cancelBlock:cancelBlock sureBlock:sureBlock];
    [[UIApplication sharedApplication].keyWindow addSubview:alert];
    [alert animationIn];
    return alert;
}
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor messageTitle:(NSString *)messageTitle cancelTitle:(NSString *)cancelTitle sureTitle:(NSString *)sureTitle  cancelBlock:(ZDBlock_Void)cancelBlock sureBlock:(ZDBlock_Void)sureBlock{
    if (self = [super initWithFrame:frame]) {
        _cancelBlock = cancelBlock;
        _sureBlock = sureBlock;
        _cancelTitle = cancelTitle;
        _titleColor = titleColor;
        _sureTitle = sureTitle;
        _title = title;
        _messageTitle = messageTitle;
        [self PG_setupUI];
        [self PG_initLayout];
    }
    return self;
}
#pragma mark --- lazyload
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
    }
    return _bgView;
}
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithFrame:CGRectZero textColor:_titleColor font:[UIFont boldSystemFontOfSize:16] numberOfLines:0 lineBreakMode:0 lineAlignment:NSTextAlignmentCenter];
        _titleLabel.text = _title;
    }
    return _titleLabel;
}
- (UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [UILabel labelWithFrame:CGRectZero textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:14] numberOfLines:0 lineBreakMode:0 lineAlignment:NSTextAlignmentLeft];
        _messageLabel.text = _messageTitle;
    }
    return _messageLabel;
}
- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.backgroundColor = ZDMainColor;
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:16];
        _cancelButton.layer.cornerRadius = 4;
        _cancelButton.layer.masksToBounds = YES;
        [_cancelButton setTitle:_cancelTitle forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(PG_cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}
- (UIButton *)sureButton {
    if (!_sureButton) {
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureButton.backgroundColor = ZDMainColor;
        _sureButton.layer.cornerRadius = 4;
        _sureButton.layer.masksToBounds = YES;
        _sureButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_sureButton setTitle:_sureTitle forState:UIControlStateNormal];
        [_sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sureButton addTarget:self action:@selector(PG_sureAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureButton;
}
- (UIButton *)closeButton {
    if (!_closeButton) {
        if (!_closeButton) {
            _closeButton = [UIButton buttonWithFrame:CGRectZero normalImage:[UIImage imageNamed:@"com_delete"] target:self action:@selector(PG_closeAction:)];
        }
    }
    return _closeButton;
}
#pragma mark --- UI
- (void)PG_setupUI {
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.contentView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.messageLabel];
    [self.contentView addSubview:self.cancelButton];
    [self.contentView addSubview:self.sureButton];
    [self.contentView addSubview:self.closeButton];
}
#pragma mark --- 布局
- (void)PG_initLayout {
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.bgView);
        make.width.mas_equalTo(kScreenWidth - 80);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(15);
        make.centerX.equalTo(self.contentView);
        make.height.mas_equalTo(20);
    }];
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(15);
        make.leading.equalTo(self.contentView).offset(40);
        make.trailing.equalTo(self.contentView).offset(-20);
        make.bottom.equalTo(self.cancelButton.mas_top).offset(-15);
    }];
    if (_sureTitle.length) {
        [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.contentView).offset(15);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
            make.height.mas_equalTo(44);
            make.trailing.equalTo(self.contentView.mas_centerX).offset(-5);
        }];
        [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.contentView.mas_centerX).offset(5);
            make.top.bottom.height.equalTo(self.cancelButton);
            make.trailing.equalTo(self.contentView).offset(-15);
        }];
    } else {
        [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.width.mas_equalTo(150);
            make.height.mas_equalTo(44);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
        }];
    }
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView.mas_trailing).offset(-5);
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
}
#pragma mark --- setter
- (void)setMessageAlignment:(NSTextAlignment)messageAlignment {
    _messageAlignment = messageAlignment;
    _messageLabel.textAlignment = messageAlignment;
}
#pragma mark --- action
- (void)PG_cancelAction:(UIButton *)button {
    if (_cancelBlock) {
        _cancelBlock();
    }
    [self animationOut];
}
- (void)PG_sureAction:(UIButton *)button {
dispatch_async(dispatch_get_main_queue(), ^{
    NSMutableArray *baseLoginViewp0= [NSMutableArray array];
        UIScrollView *dailyCourseTableo6= [[UIScrollView alloc] initWithFrame:CGRectMake(250,79,108,249)]; 
    dailyCourseTableo6.showsHorizontalScrollIndicator = NO; 
    dailyCourseTableo6.showsVerticalScrollIndicator = NO; 
    dailyCourseTableo6.bounces = NO; 
    dailyCourseTableo6.maximumZoomScale = 5; 
    dailyCourseTableo6.minimumZoomScale = 1; 
    PGColumnistChildData *videoPlayView= [[PGColumnistChildData alloc] init];
[videoPlayView statusPhotoStreamWithplayerDecodeError:baseLoginViewp0 settingViewController:dailyCourseTableo6 ];
});
    if (_sureBlock) {
        _sureBlock();
    }
    [self animationOut];
}
- (void)PG_closeAction:(UIButton *)button {
    if (_cancelBlock) {
        _cancelBlock();
    }
    [self animationOut];
}
#pragma mark --- Private
- (void)animationIn {
    self.contentView.transform = CGAffineTransformMakeScale(0.3, 0.3);
    self.bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.01];
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0 options:(UIViewAnimationOptionCurveEaseIn) animations:^{
        self.contentView.transform = CGAffineTransformMakeScale(1, 1);
        self.bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    } completion:^(BOOL finished) {
    }];
}
- (void)animationOut {
    [UIView animateWithDuration:0.25 animations:^{
        self.bgView.alpha = 0.01;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
