//
//  ZDMePromoteIncomeHeaderView.m
//  zhundao
//
//  Created by maj on 2020/1/19.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "ZDMePromoteIncomeHeaderView.h"

@interface ZDMePromoteIncomeHeaderView()
@property (nonatomic, strong) UILabel *countLabel; // 金额
@property (nonatomic, strong) UILabel *typeLabel; // 类型
@property (nonatomic, strong) UILabel *markLabel; // 备注
@property (nonatomic, strong) UILabel *timeLabel; // 时间

@end

@implementation ZDMePromoteIncomeHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        [self initLayout];
    }
    return self;
}

#pragma mark --- lazyload
- (UILabel *)countLabel {
    if (!_countLabel) {
        _countLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDHeaderTitleColor font:ZDMediumFont(14) numberOfLines:0 lineBreakMode:0 lineAlignment:NSTextAlignmentCenter];
        _countLabel.text = @"金额";
    }
    return _countLabel;
}
- (UILabel *)typeLabel {
    if (!_typeLabel) {
        _typeLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDHeaderTitleColor font:ZDMediumFont(14) numberOfLines:0 lineBreakMode:0 lineAlignment:NSTextAlignmentCenter];
        _typeLabel.text = @"类型";
    }
    return _typeLabel;
}
- (UILabel *)markLabel {
    if (!_markLabel) {
        _markLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDHeaderTitleColor font:ZDMediumFont(14) numberOfLines:0 lineBreakMode:0 lineAlignment:NSTextAlignmentCenter];
        _markLabel.text = @"备注";
    }
    return _markLabel;
}
- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDHeaderTitleColor font:ZDMediumFont(14) numberOfLines:0 lineBreakMode:0 lineAlignment:NSTextAlignmentCenter];
        _timeLabel.text = @"时间";
    }
    return _timeLabel;
}

#pragma mark --- UI
- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.countLabel];
    [self addSubview:self.typeLabel];
    [self addSubview:self.markLabel];
    [self addSubview:self.timeLabel];
}

#pragma mark --- 布局
- (void)initLayout {
    CGFloat width = (kScreenWidth - 140) / 3;
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(width);
        make.top.bottom.leading.equalTo(self);
    }];
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.equalTo(self.countLabel);
        make.leading.equalTo(self.countLabel.mas_trailing).offset(0);
    }];
    [self.markLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.equalTo(self.countLabel);
        make.leading.equalTo(self.typeLabel.mas_trailing).offset(0);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.markLabel.mas_trailing);
        make.trailing.equalTo(self);
        make.top.bottom.equalTo(self.countLabel);
    }];
}

@end
