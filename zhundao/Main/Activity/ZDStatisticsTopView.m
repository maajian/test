//
//  ZDStatisticsTopView.m
//  jingjing
//
//  Created by maj on 2020/9/16.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "ZDStatisticsTopView.h"

@interface ZDStatisticsTopView()
@property (nonatomic, strong) UIView *shadowView;
@property (nonatomic, strong) UIView *cornerView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel * allCountNumberLabel;
@property (nonatomic, strong) UILabel * allCountFixLabel;
@property (nonatomic, strong) UILabel * yesterdayCountNumberLabel;
@property (nonatomic, strong) UILabel * yesterdayCountFixLabel;

@end

@implementation ZDStatisticsTopView

- (instancetype)init{
    if (self = [super init]) {
        [self setupUI];
        [self initLayout];
    }
    return self;
}

#pragma mark --- lazyload
- (UIView *)shadowView {
    if (!_shadowView) {
        _shadowView = [[UIView alloc] init];
        _shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
        _shadowView.layer.shadowOffset = CGSizeMake(0, 0);
        _shadowView.layer.shadowOpacity = 0.08;
        _shadowView.layer.shadowRadius = 4;
    }
    return _shadowView;
}
- (UIView *)cornerView {
    if (!_cornerView) {
        _cornerView = [UIView new];
        _cornerView.backgroundColor = [UIColor whiteColor];
        _cornerView.layer.cornerRadius = 4;
        _cornerView.layer.masksToBounds = YES;
        _cornerView.userInteractionEnabled = YES;
    }
    return _cornerView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDBlackColor font:ZDBoldFont(15) numberOfLines:0 lineBreakMode:0 lineAlignment:0];
        _titleLabel.text = @"报名关键指标";
    }
    return _titleLabel;
}
- (UILabel *)allCountNumberLabel {
    if (!_allCountNumberLabel) {
        _allCountNumberLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDBlackColor font:ZDBoldFont(34) numberOfLines:0 lineBreakMode:0 lineAlignment:NSTextAlignmentCenter];
        _allCountNumberLabel.text = @"0";
    }
    return _allCountNumberLabel;
}
- (UILabel *)allCountFixLabel {
    if (!_allCountFixLabel) {
        _allCountFixLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDBlackColor font:ZDSystemFont(14) numberOfLines:0 lineBreakMode:0 lineAlignment:NSTextAlignmentCenter];
        _allCountFixLabel.text = @"总报名人数";
    }
    return _allCountFixLabel;
}
- (UILabel *)yesterdayCountNumberLabel {
    if (!_yesterdayCountNumberLabel) {
        _yesterdayCountNumberLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDBlackColor font:ZDBoldFont(34) numberOfLines:0 lineBreakMode:0 lineAlignment:NSTextAlignmentCenter];
        _yesterdayCountNumberLabel.text = @"0";
    }
    return _yesterdayCountNumberLabel;
}
- (UILabel *)yesterdayCountFixLabel {
    if (!_yesterdayCountFixLabel) {
        _yesterdayCountFixLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDBlackColor font:ZDSystemFont(14) numberOfLines:0 lineBreakMode:0 lineAlignment:NSTextAlignmentCenter];
        _yesterdayCountFixLabel.text = @"昨日报名人数";
    }
    return _yesterdayCountFixLabel;
}

#pragma mark --- UI
- (void)setupUI {
    [self addSubview:self.shadowView];
    [self.shadowView addSubview:self.cornerView];
    [self.cornerView addSubview:self.titleLabel];
    [self.cornerView addSubview:self.allCountNumberLabel];
    [self.cornerView addSubview:self.allCountFixLabel];
    [self.cornerView addSubview:self.yesterdayCountFixLabel];
    [self.cornerView addSubview:self.yesterdayCountNumberLabel];
}

#pragma mark --- 布局
- (void)initLayout {
    [self.shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(15);
        make.trailing.equalTo(self).offset(-15);
        make.top.equalTo(self).offset(15);
        make.height.mas_equalTo(150);
    }];
    [self.cornerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.shadowView);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.cornerView).offset(15);
        make.top.equalTo(self.cornerView).offset(15);
    }];
    [self.allCountNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(20);
        make.leading.equalTo(self.cornerView);
        make.trailing.equalTo(self.cornerView.mas_centerX);
    }];
    [self.allCountFixLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.allCountNumberLabel.mas_bottom).offset(15);
        make.leading.trailing.equalTo(self.allCountNumberLabel);
    }];
    [self.yesterdayCountNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.allCountNumberLabel);
        make.leading.equalTo(self.allCountNumberLabel.mas_trailing);
        make.trailing.equalTo(self.cornerView);
    }];
    [self.yesterdayCountFixLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.yesterdayCountNumberLabel.mas_bottom).offset(15);
        make.leading.trailing.equalTo(self.yesterdayCountNumberLabel);
    }];
}

#pragma mark --- setter
- (void)setMoreModel:(ActivityModel *)moreModel {
    _moreModel = moreModel;
    _allCountNumberLabel.text = @(_moreModel.total).stringValue;
    _yesterdayCountNumberLabel.text = @(_moreModel.yesterday).stringValue;
}

#pragma mark --- action

@end
