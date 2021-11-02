//
//  ZDMeAdsPopView.m
//  zhundao
//
//  Created by maj on 2021/9/23.
//  Copyright © 2021 zhundao. All rights reserved.
//

#import "ZDMeAdsPopView.h"

@interface ZDMeAdsPopView()
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *closeButton;

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) ZDBlock_Void clickBlock;
@property (nonatomic, copy) ZDBlock_Void cancelBlock;

@end

@implementation ZDMeAdsPopView

+ (void)showWithImage:(UIImage *)image clickBlock:(ZDBlock_Void)clickBlock cancelBlock:(ZDBlock_Void)cancelBlock {
    ZDMeAdsPopView *view = [[ZDMeAdsPopView alloc] initWithImage:image clickBlock:clickBlock cancelBlock:cancelBlock];
    [ZD_KeyWindow addSubview:view];
    [view animationIn];
}

- (instancetype)initWithImage:(UIImage *)image clickBlock:(ZDBlock_Void)clickBlock cancelBlock:(ZDBlock_Void)cancelBlock {
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        _image = image;
        _clickBlock = clickBlock;
        _cancelBlock = cancelBlock;
        [self initSet];
        [self initLayout];
    }
    return self;
}

#pragma mark --- Init
- (void)initSet {
    [self addSubview:self.contentView];
    [self addSubview:self.imageView];
    [self addSubview:self.closeButton];
}
- (void)initLayout {
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenWidth * 0.7);
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
    }];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.leading.trailing.equalTo(self.contentView);
        make.height.mas_equalTo(kScreenWidth * 0.7 * self.image.size.height / self.image.size.width);
    }];
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.imageView.mas_bottom).offset(30);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
}

#pragma mark --- action
- (void)clickAction:(id)sender  {
    ZDDo_Block_Safe_Main(self.clickBlock)
    [self animationOut];
}
- (void)cancelAction:(id)sender {
    ZDDo_Block_Safe_Main(self.cancelBlock)
    [self animationOut];
}

#pragma mark --- animation
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

#pragma mark --- Lazyload
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
    }
    return _contentView;
}
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.image = self.image;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [_imageView addTapGestureTarget:self action:@selector(clickAction:)];
    }
    return _imageView;
}
- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithFrame:CGRectZero normalImage:[UIImage imageNamed:@"me_close"] target:self action:@selector(animationOut)];
    }
    return _closeButton;
}


@end
