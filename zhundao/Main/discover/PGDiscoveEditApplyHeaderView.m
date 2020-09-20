#import "PGCollectionViewDelegate.h"
//
//  PGDiscoveEditApplyHeaderView.m
//  zhundao
//
//  Created by maj on 2018/12/4.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import "PGDiscoveEditApplyHeaderView.h"

@interface PGDiscoveEditApplyHeaderView()
// 标题
@property (nonatomic, strong) UITextField *titleTF;

// 开关背景视图
@property (nonatomic, strong) UIView *mustContentView;
// 是否必填
@property (nonatomic, strong) UILabel *mustLabel;
// 开关
@property (nonatomic, strong) UISwitch *mustSwitch;

// 类型背景视图
@property (nonatomic, strong) UIView *typeContentView;
// 类型
@property (nonatomic, strong) UILabel *typeTitleLabel;
// 类型的文字
@property (nonatomic, strong) UILabel *typeLabel;
// 箭头
@property (nonatomic, strong) UIImageView *arrowImageView;

// 填写提示输入框
@property (nonatomic, strong) UITextField *tipInputTF;

@end

@implementation PGDiscoveEditApplyHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self PG_setupUI];
        [self PG_initLayout];
    }
    return self;
}

#pragma mark --- lazyload

- (UITextField *)titleTF {
    if (!_titleTF) {
        _titleTF = [[UITextField alloc] init];
        _titleTF.backgroundColor = [UIColor whiteColor];
        _titleTF.placeholder = @"请输入项目名称";
        _titleTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 40)];
        _titleTF.leftViewMode = UITextFieldViewModeAlways;
        _titleTF.font = [UIFont systemFontOfSize:14];
        _titleTF.textColor = [UIColor blackColor];
    }
    return _titleTF;
}

// 开关背景视图
- (UIView *)mustContentView {
    if (!_mustContentView) {
        _mustContentView = [[UIView alloc] init];
        _mustContentView.backgroundColor = [UIColor whiteColor];
    }
    return _mustContentView;
}

// 是否必填
- (UILabel *)mustLabel {
    if (!_mustLabel) {
        _mustLabel = [UILabel new];
        _mustLabel.text = @"是否必填";
        _mustLabel.textColor = [UIColor blackColor];
        _mustLabel.font = [UIFont systemFontOfSize:16];
    }
    return _mustLabel;
}

// 开关
- (UISwitch *)mustSwitch {
    if (!_mustSwitch) {
        _mustSwitch = [[UISwitch alloc] init];
        _mustSwitch.on = YES;
        [_mustSwitch addTarget:self action:@selector(PG_switchAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _mustSwitch;
}

// 类型背景视图
- (UIView *)typeContentView {
    if (!_typeContentView) {
        _typeContentView = [[UIView alloc] init];
        _typeContentView.backgroundColor = [UIColor whiteColor];
    }
    return _typeContentView;
}

// 类型文字
- (UILabel *)typeTitleLabel {
    if (!_typeTitleLabel) {
        _typeTitleLabel = [UILabel new];
        _typeTitleLabel.text = @"类型";
        _typeTitleLabel.font = [UIFont systemFontOfSize:16];
        _typeTitleLabel.textColor = [UIColor blackColor];
        [_typeLabel addTapGestureTarget:self action:@selector(PG_changeType:)];
    }
    return _typeTitleLabel;
}

// 类型名称
- (UILabel *)typeLabel {
    if (!_typeLabel) {
        _typeLabel = [UILabel new];
        _typeLabel.text = @"输入框";
        _typeLabel.font = [UIFont systemFontOfSize:16];
        _typeLabel.textColor = ZDHeaderTitleColor;
        _typeLabel.textAlignment = NSTextAlignmentRight;
        [_typeLabel addTapGestureTarget:self action:@selector(PG_changeType:)];
    }
    return _typeLabel;
}

// 箭头
- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [UIImageView new];
        _arrowImageView.image = [UIImage imageNamed:@"rightArrows"];
    }
    return _arrowImageView;
}

// 填写提示输入框
- (UITextField *)tipInputTF {
    if (!_tipInputTF) {
        _tipInputTF = [[UITextField alloc] init];
        _tipInputTF.placeholder = @"请输入填写提示";
        _tipInputTF.font = [UIFont systemFontOfSize:14];
        _tipInputTF.textColor = [UIColor blackColor];
        _tipInputTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 40)];
        _tipInputTF.leftViewMode = UITextFieldViewModeAlways;
        _tipInputTF.backgroundColor = [UIColor whiteColor];
    }
    return _tipInputTF;
}

#pragma mark --- UI
- (void)PG_setupUI {
    self.backgroundColor = ZDBackgroundColor;
    [self addSubview:self.titleTF];
    
    [self addSubview:self.typeContentView];
    [self.typeContentView addSubview:self.typeTitleLabel];
    [self.typeContentView addSubview:self.typeLabel];
    [self.typeContentView addSubview:self.arrowImageView];
    
    [self addSubview:self.mustContentView];
    [self.mustContentView addSubview:self.mustLabel];
    [self.mustContentView addSubview:self.mustSwitch];
    
    [self addSubview:self.tipInputTF];
}

#pragma mark --- 布局
- (void)PG_initLayout {
    [self.titleTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(0);
        make.top.mas_equalTo(20);
        make.height.mas_equalTo(44);
    }];
    
    [self.typeContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(0);
        make.top.equalTo(self.titleTF.mas_bottom).offset(10);
        make.height.mas_equalTo(44);
    }];
    
    [self.typeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.leading.mas_equalTo(15);
        make.trailing.equalTo(self.typeLabel.mas_leading);
    }];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.arrowImageView.mas_leading).offset(-10);
        make.top.bottom.equalTo(self.typeTitleLabel);
        make.width.mas_equalTo(120);
    }];
    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.typeTitleLabel);
        make.size.mas_equalTo(CGSizeMake(10, 10));
        make.trailing.mas_equalTo(-10);
    }];
    
    [self.mustContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(0);
        make.top.equalTo(self.typeContentView.mas_bottom).offset(10);
        make.height.mas_equalTo(44);
    }];
    
    [self.mustLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.mustContentView);
        make.leading.mas_equalTo(15);
    }];
    
    [self.mustSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mustLabel);
        make.trailing.mas_equalTo(-10);
        make.size.mas_equalTo(CGSizeMake(60, 35));
    }];
    
    [self.tipInputTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mustContentView.mas_bottom).offset(10);
        make.leading.trailing.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
}

#pragma mark --- setter
- (void)setModel:(PGDiscoverCustomApplyModel *)model {
    if (model.ID) {
        _model = model;
        self.titleTF.text = model.title;
        self.typeLabel.text = model.typeStr;
        self.mustSwitch.on = model.required;
        self.tipInputTF.text = model.placeholder;
    } else {
        self.typeContentView.hidden = YES;
        [self.typeContentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        [self.mustContentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.typeContentView.mas_bottom);
        }];
    }
}

#pragma mark --- action
- (void)PG_switchAction:(UISwitch *)mustSwitch {
    
}

- (void)PG_changeType:(UITapGestureRecognizer *)gestureRecognizer {
    if ([self.discoveEditApplyHeaderViewDelegate respondsToSelector:@selector(headerView:didChangeType:)]) {
        [self.discoveEditApplyHeaderViewDelegate headerView:self didChangeType:self.typeLabel];
    }
}

@end
