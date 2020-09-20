#import "PGExportVideoWith.h"
//
//  ZDStatisticsHeaderView.m
//  jingjing
//
//  Created by maj on 2020/9/16.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "PGStatisticsBottomView.h"

static const CGFloat itemHeight = 44.f;

@interface PGStatisticsBottomView()
@property (nonatomic, strong) UIView *shadowView;
@property (nonatomic, strong) UIView *cornerView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *subtitleView;
@property (nonatomic, strong) UILabel *departLabel;
@property (nonatomic, strong) UILabel *totalLabel;

@end

@implementation PGStatisticsBottomView

- (instancetype)init {
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
        _shadowView.layer.shadowOpacity = 0.05;
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
        _titleLabel.text = @"组织报名动态";
    }
    return _titleLabel;
}
- (UIView *)subtitleView {
    if (!_subtitleView) {
        _subtitleView = [UIView new];
        _subtitleView.backgroundColor = ZDBackgroundColor;
        _subtitleView.layer.cornerRadius = 4;
        _subtitleView.layer.masksToBounds = YES;
    }
    return _subtitleView;
}
- (UILabel *)departLabel {
    if (!_departLabel) {
        _departLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDHeaderTitleColor font:ZDBoldFont(15) numberOfLines:0 lineBreakMode:0 lineAlignment:NSTextAlignmentCenter];
        _departLabel.text = @"组织名称";
    }
    return _departLabel;
}
- (UILabel *)totalLabel {
    if (!_totalLabel) {
        _totalLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDHeaderTitleColor font:ZDBoldFont(15) numberOfLines:0 lineBreakMode:0 lineAlignment:NSTextAlignmentCenter];
        _totalLabel.text = @"总报名人数";
    }
    return _totalLabel;
}

#pragma mark --- UI
- (void)setupUI {
    [self addSubview:self.shadowView];
    [self.shadowView addSubview:self.cornerView];
    [self.cornerView addSubview:self.titleLabel];
    [self.cornerView addSubview:self.subtitleView];
    [self.subtitleView addSubview:self.departLabel];
    [self.subtitleView addSubview:self.totalLabel];
}

#pragma mark --- 布局
- (void)initLayout {
    [self.shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(15);
        make.trailing.equalTo(self).offset(-15);
        make.height.mas_equalTo(200);
    }];
    [self.cornerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.shadowView);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.cornerView).offset(15);
        make.top.equalTo(self.cornerView).offset(15);
    }];
    [self.subtitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(15);
        make.leading.equalTo(self.cornerView).offset(15);
        make.trailing.equalTo(self.cornerView).offset(-15);
        make.height.mas_equalTo(itemHeight);
    }];
    [self.departLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.subtitleView);
        make.leading.equalTo(self.subtitleView);
        make.trailing.equalTo(self.subtitleView.mas_centerX);
    }];
    [self.totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.subtitleView);
        make.leading.equalTo(self.subtitleView.mas_centerX);
        make.trailing.equalTo(self.subtitleView);
    }];
}

#pragma mark --- setter
- (void)setDataSource:(NSMutableArray<PGStatisticsModel *> *)dataSource {
    _dataSource = dataSource;
    
    [self.shadowView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo((self.dataSource.count + 1) * itemHeight + 50);
    }];
    
    for (int i = 0 ; i< self.dataSource.count; i++) {
        PGStatisticsModel *model = self.dataSource[i];
        UILabel *leftLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDBlackColor font:ZDSystemFont(14) numberOfLines:0 lineBreakMode:0 lineAlignment:NSTextAlignmentCenter];
        leftLabel.text = model.DepartName;
        [self.cornerView addSubview:leftLabel];
        
        UILabel *rightLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDBlackColor font:ZDSystemFont(14) numberOfLines:0 lineBreakMode:0 lineAlignment:NSTextAlignmentCenter];
        rightLabel.text = @(model.TotalCount).stringValue;
        [self.cornerView addSubview:rightLabel];
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = ZDLineColor;
        [self.cornerView addSubview:lineView];
        
        [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(self.departLabel);
            make.top.equalTo(self.subtitleView.mas_bottom).offset(itemHeight * i);
            make.height.mas_equalTo(itemHeight);
        }];
        [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(self.totalLabel);
            make.top.equalTo(self.subtitleView.mas_bottom).offset(itemHeight * i);
            make.height.mas_equalTo(itemHeight);
        }];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(leftLabel.mas_bottom).offset(-0.5);
            make.trailing.equalTo(self.totalLabel);
            make.leading.equalTo(self.departLabel);
            make.height.mas_equalTo(0.5);
        }];
        lineView.hidden = self.dataSource.count == i + 1;
    }
}

#pragma mark --- action

@end
