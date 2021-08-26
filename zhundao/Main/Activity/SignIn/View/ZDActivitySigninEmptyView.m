//
//  ZDActivitySigninEmptyView.m
//  zhundao
//
//  Created by maj on 2021/5/25.
//  Copyright © 2021 zhundao. All rights reserved.
//

#import "ZDActivitySigninEmptyView.h"

@interface ZDActivitySigninEmptyView()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabal;
@property (nonatomic, strong) UIButton *signButton;

@property (nonatomic, copy) ZDBlock_Void emptyBlock;

@end

@implementation ZDActivitySigninEmptyView

- (instancetype)initWithEmptyBlock:(ZDBlock_Void)emptyBlock {
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTopBarHeight);
        self.emptyBlock = emptyBlock;
        [self initSet];
        [self initLayout];
    }
    return self;
}

#pragma mark --- Init
- (void)initSet {
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[self(400)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)]];
    [self addSubview:self.imageView];
    [self addSubview:self.titleLabal];
    [self addSubview:self.signButton];
}
- (void)initLayout {
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(149, 84));
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(-40);
    }];
    [self.titleLabal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).offset(20);
        make.centerX.equalTo(self);
    }];
    [self.signButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabal.mas_bottom).offset(40);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(145, 44));
    }];
}

#pragma mark --- Lazyload
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"public_signin_empty"]];
    }
    return _imageView;
}
- (UILabel *)titleLabal {
    if (!_titleLabal) {
        _titleLabal = [UILabel labelWithFrame:CGRectZero textColor:[UIColor colorFromHexCode:@"767B80"] font:ZDSystemFont(12) numberOfLines:0 lineBreakMode:0 lineAlignment:NSTextAlignmentCenter];
        _titleLabal.text = @"目前没任何签到任务！";
    }
    return _titleLabal;
}
- (UIButton *)signButton {
    if (!_signButton) {
        _signButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_signButton setTitle:@"创建签到" forState:UIControlStateNormal];
        [_signButton setTitleColor:ZDGreenColor forState:UIControlStateNormal];
        _signButton.titleLabel.font = ZDBoldFont(14);
        _signButton.layer.cornerRadius = 22;
        _signButton.layer.masksToBounds = YES;
        _signButton.layer.borderColor = ZDGreenColor.CGColor;
        _signButton.layer.borderWidth = 1;
        [_signButton addTarget:self action:@selector(signAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _signButton;
}

#pragma mark --- Action
- (void)signAction:(id)sender {
    ZDDo_Block_Safe_Main(self.emptyBlock);
}

@end
