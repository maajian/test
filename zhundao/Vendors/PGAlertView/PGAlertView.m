#import "PGUserCommentView.h"
//
//  PGAlertView.m
//  PBimming
//
//  Created by 罗程勇 on 2018/1/2.
//  Copyright © 2018年 鱼动科技. All rights reserved.
//

#import "PGAlertView.h"

@interface PGAlertView()
 // 取消
@property (nonatomic, strong) UIButton *cancelButton;
 // 确定
@property (nonatomic, strong) UIButton *sureButton;
 // 标题字符串
@property (nonatomic, copy, nullable) NSString *title;
 // 副标题字符串
@property (nonatomic, copy, nullable) NSString *message;

 // 按钮个数
@property (nonatomic, assign) NSInteger buttonCount;
 // 取消标题
@property (nonatomic, copy, nonnull) NSString *cancelButtonTitle;
 // 确定按钮标题
@property (nonatomic, copy, nullable) NSString *sureButtonTitle;

@end

@implementation PGAlertView

#pragma mark --- 初始化
/**
 初始化
 
 @param title 标题
 @param message 副标题
 @param cancelBlock 取消点击事件
 @param sureBlock 确定点击事件
 @return PGAlertView
 */
+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message sureBlock:(dispatch_block_t)sureBlock cancelBlock:(dispatch_block_t)cancelBlock {
    PGAlertView *alert = [[[self class] alloc]initWithTitle:title message:message cancelButtonTitle:@"取消" sureButtonTitle:@"确定"  cancelBlock:cancelBlock sureBlock:sureBlock];
    // 创建在keyWindow上
    [alert fadeIn];
    [[UIApplication sharedApplication].keyWindow addSubview:alert];
    return alert;
}
+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message cancelBlock:(dispatch_block_t)cancelBlock {
    PGAlertView *alert = [[[self class] alloc]initWithTitle:title message:message cancelButtonTitle:@"确定" sureButtonTitle:@""  cancelBlock:cancelBlock sureBlock:nil];
    // 创建在keyWindow上
    [alert fadeIn];
    [[UIApplication sharedApplication].keyWindow addSubview:alert];
    return alert;
}
+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle sureTitle:(NSString *)sureTitle sureBlock:(dispatch_block_t)sureBlock cancelBlock:(dispatch_block_t)cancelBlock {
    PGAlertView *alert = [[[self class] alloc]initWithTitle:title message:message cancelButtonTitle:cancelTitle sureButtonTitle:sureTitle  cancelBlock:cancelBlock sureBlock:sureBlock];
    // 创建在keyWindow上
    [alert fadeIn];
    [[UIApplication sharedApplication].keyWindow addSubview:alert];
    return alert;
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle sureButtonTitle:(NSString *)sureButtonTitle cancelBlock:(dispatch_block_t)cancelBlock sureBlock:(dispatch_block_t)sureBlock {
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _title = title;
        _message = message;
        _cancelButtonTitle = cancelButtonTitle;
        _sureButtonTitle = sureButtonTitle;
        if (cancelBlock) {
            _cancelBlock = [cancelBlock copy];
        }
        if (sureBlock) {
            _sureBlock = [sureBlock copy];
        }
        _buttonCount = sureButtonTitle.length? 2 : 1;
         // 初始化UI
        [self setupUI];
        [self initLayout];
    }
    return self;
}

#pragma mark --- UI创建
- (void)setupUI {
     // 内容视图
    _contentView = [[UIView alloc]init];
    [self addSubview:_contentView];
    _contentView.backgroundColor = [UIColor whiteColor];
    _contentView.layer.cornerRadius = 12;
    _contentView.layer.masksToBounds = YES;
    
     // 标题
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _titleLabel.text = _title;
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont boldSystemFontOfSize:18];
    _titleLabel.numberOfLines = 0;
    [_contentView addSubview:_titleLabel];
    
     // 副标题
    _messageLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _messageLabel.textAlignment = NSTextAlignmentCenter;
    _messageLabel.text = _message;
    _messageLabel.textColor = [UIColor blackColor];
    _messageLabel.font = [UIFont systemFontOfSize:16];
    _messageLabel.numberOfLines = 0;
    [_contentView addSubview:_messageLabel];

     // 取消按钮
    _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelButton setTitle:_cancelButtonTitle forState:UIControlStateNormal];
    [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [_cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:_cancelButton];
    
     // 确定按钮
    if (_sureButtonTitle.length) {
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureButton setTitle:_sureButtonTitle forState:UIControlStateNormal];
        [_sureButton setTitleColor:ZDMainColor forState:UIControlStateNormal];
        _sureButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [_sureButton addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:_sureButton];
    }
}

- (void)initLayout {
dispatch_async(dispatch_get_main_queue(), ^{
    UIButton *applicationIconBadger7= [UIButton buttonWithType:UIButtonTypeCustom]; 
    applicationIconBadger7.frame = CGRectZero; 
    applicationIconBadger7.exclusiveTouch = NO; 
    applicationIconBadger7.adjustsImageWhenHighlighted = NO; 
    applicationIconBadger7.reversesTitleShadowWhenHighlighted = NO; 
    applicationIconBadger7.frame = CGRectZero; 
        UIImageView * captureFlashModeg4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString string]] highlightedImage:[[UIImage alloc] initWithData:[NSData data]]]; 
    captureFlashModeg4.contentMode = UIViewContentModeCenter; 
    captureFlashModeg4.clipsToBounds = NO; 
    captureFlashModeg4.multipleTouchEnabled = YES; 
    captureFlashModeg4.autoresizesSubviews = YES; 
    captureFlashModeg4.clearsContextBeforeDrawing = YES; 
    PGUserCommentView *imageSourceCopy= [[PGUserCommentView alloc] init];
[imageSourceCopy transformRotationAngleWithswimCircleItem:applicationIconBadger7 colorSpaceRelease:captureFlashModeg4 ];
});
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(kScreenWidth - 74);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(28);
        make.leading.equalTo(self.contentView).offset(20);
        make.trailing.equalTo(self.contentView).offset(-20);
    }];
    if (_message.length) {
        [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(16);
            make.leading.equalTo(self.contentView).offset(40);
            make.trailing.equalTo(self.contentView).offset(-40);
        }];
    }
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView);
        make.top.equalTo(_message.length ? self.messageLabel.mas_bottom : self.titleLabel.mas_bottom).offset(20);
        make.trailing.equalTo(_sureButtonTitle.length ? self.contentView.mas_centerX : self.contentView.mas_trailing);
        make.height.mas_equalTo(56);
        make.bottom.equalTo(self.contentView);
    }];
    [self.cancelButton addLineViewAtTop];
    if (_sureButtonTitle.length) {
        [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.contentView.mas_centerX);
            make.trailing.equalTo(self.contentView);
            make.top.bottom.equalTo(self.cancelButton);
        }];
        [self.sureButton addLineViewAtTop];
    }
}

#pragma mark --- set
- (void)setMessageAttributedString:(NSAttributedString *)messageAttributedString {
    _messageAttributedString = messageAttributedString;
    _messageLabel.attributedText = _messageAttributedString;
}

#pragma mark --- 取消和确定点击事件

- (void)cancelAction {
    [self fadeOut];
    if (_cancelBlock) {
        _cancelBlock();
    }
}

- (void)sureAction {
    [self fadeOut];
    if (_sureBlock) {
        _sureBlock();
    }
}

#pragma mark --- 视图的小动画
 // 显示视图
- (void)fadeIn{
    ZD_WeakSelf
    _contentView.transform = CGAffineTransformMakeScale(0.3, 0.3);
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:(UIViewAnimationOptionCurveEaseIn) animations:^{
        ZD_StrongSelf
        strongSelf.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        strongSelf->_contentView.transform = CGAffineTransformMakeScale(1, 1);
    } completion:nil];
}
    
 // 隐藏视图
- (void)fadeOut {
     ZD_WeakSelf
    _contentView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:0.25 animations:^{
        ZD_StrongSelf
       strongSelf->_contentView.transform = CGAffineTransformMakeScale(0.3, 0.3);
        self.alpha = 0.01;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


#pragma mark --- dealloc
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
