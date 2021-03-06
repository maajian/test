//
//  ZDDiscoverPromoteCustomContactCell.m
//  zhundao
//
//  Created by maj on 2020/1/6.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "ZDMePromoteCustomContactCell.h"

@interface ZDMePromoteCustomContactCell()
// 圆角
@property (nonatomic, strong) UIView *cornerView;
// 阴影
@property (nonatomic, strong) UIView *shadowView;
// 主标题
@property (nonatomic, strong) UILabel *MainTitleLabel;
// 箭头
@property (nonatomic, strong) UIButton *arrowButton;
// 总xx
@property (nonatomic, strong) UILabel *allTitleLabel;
// 总xx 数量
@property (nonatomic, strong) UILabel *allCountLabel;
// 今日xx
@property (nonatomic, strong) UILabel *todayTitleLabel;
// 今日xx 数量
@property (nonatomic, strong) UILabel *todayCountLabel;

@end

@implementation ZDMePromoteCustomContactCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = ZDBackgroundColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
        [self initLayout];
    }
    return self;
}

#pragma mark --- lazyload
- (UIView *)cornerView {
    if (!_cornerView) {
        _cornerView = [[UIView alloc] init];
        _cornerView.backgroundColor = [UIColor whiteColor];
        _cornerView.layer.cornerRadius = 5;
        _cornerView.layer.masksToBounds = YES;
    }
    return _cornerView;
}
- (UIView *)shadowView {
    if (!_shadowView) {
        _shadowView = [[UIView alloc] init];
        _shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
        _shadowView.layer.shadowOffset = CGSizeMake(0, 0);
        _shadowView.layer.shadowOpacity = 0.1;
        _shadowView.layer.shadowRadius = 5;
    }
    return _shadowView;
}
- (UILabel *)MainTitleLabel {
    if (!_MainTitleLabel) {
        _MainTitleLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDBlackColor font:ZDMediumFont(14) numberOfLines:0 lineBreakMode:0 lineAlignment:0];
    }
    return _MainTitleLabel;
}
- (UIButton *)arrowButton {
    if (!_arrowButton) {
        _arrowButton = [UIButton buttonWithFrame:CGRectZero normalImage:[UIImage imageNamed:@"public_image_arrow_right"] target:self action:nil];
        _arrowButton.addInsetWidth = 20;
        _arrowButton.addInsetHeight = 20;
        _arrowButton.userInteractionEnabled = NO;
    }
    return _arrowButton;
}
- (UILabel *)allTitleLabel {
    if (!_allTitleLabel) {
        _allTitleLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDBlackColor font:ZDSystemFont(13) numberOfLines:0 lineBreakMode:0 lineAlignment:NSTextAlignmentCenter];
    }
    return _allTitleLabel;
}
- (UILabel *)allCountLabel {
    if (!_allCountLabel) {
        _allCountLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDBlackColor font:ZDMediumFont(24) numberOfLines:0 lineBreakMode:0 lineAlignment:NSTextAlignmentCenter];
    }
    return _allCountLabel;
}
- (UILabel *)todayTitleLabel {
    if (!_todayTitleLabel) {
        _todayTitleLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDBlackColor font:ZDSystemFont(13) numberOfLines:0 lineBreakMode:0 lineAlignment:NSTextAlignmentCenter];
    }
    return _todayTitleLabel;
}
- (UILabel *)todayCountLabel {
    if (!_todayCountLabel) {
        _todayCountLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDBlackColor font:ZDMediumFont(24) numberOfLines:0 lineBreakMode:0 lineAlignment:NSTextAlignmentCenter];
    }
    return _todayCountLabel;
}

#pragma mark --- UI
- (void)setupUI {
    [self.contentView addSubview:self.shadowView];
    [self.shadowView addSubview:self.cornerView];
    [self.cornerView addSubview:self.MainTitleLabel];
    [self.cornerView addSubview:self.arrowButton];
    [self.cornerView addSubview:self.allTitleLabel];
    [self.cornerView addSubview:self.allCountLabel];
    [self.cornerView addSubview:self.todayTitleLabel];
    [self.cornerView addSubview:self.todayCountLabel];
}

#pragma mark --- 布局
- (void)initLayout {
    [self.shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(13);
        make.trailing.equalTo(self.contentView).offset(-13);
        make.top.equalTo(self.contentView).offset(10);
        make.bottom.equalTo(self.contentView);
    }];
    [self.cornerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.shadowView);
    }];
    [self.MainTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.cornerView.mas_leading).offset(17);
        make.top.equalTo(self.cornerView).offset(11);
    }];
    [self.arrowButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.cornerView.mas_trailing).offset(-20);
        make.centerY.equalTo(self.MainTitleLabel);
        make.size.mas_equalTo(CGSizeMake(10, 10));
    }];
    [self.allCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.cornerView);
        make.width.equalTo(self.contentView.mas_width).multipliedBy(0.5);
        make.top.equalTo(self.MainTitleLabel.mas_bottom).offset(13);
    }];
    [self.allTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.cornerView);
        make.width.equalTo(self.contentView.mas_width).multipliedBy(0.5);
        make.top.equalTo(self.allCountLabel.mas_bottom).offset(13);
    }];
    [self.todayCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.cornerView);
        make.width.top.equalTo(self.allCountLabel);
    }];
    [self.todayTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.cornerView);
        make.width.top.equalTo(self.allTitleLabel);
    }];
}

#pragma mark --- setter
- (void)setModel:(ZDMePromoteCustomContactModel *)model {
    self.allCountLabel.text = model.totalString;
    self.todayCountLabel.text = model.yesterdayString;
    switch (model.promoteCustomContactType) {
        case ZDMePromoteCustomContactTypeIncome:
            self.MainTitleLabel.text = @"我的收益数";
            self.allTitleLabel.text = @"总收益";
            self.todayTitleLabel.text = @"昨日收益";
            break;
        case ZDMePromoteCustomContactTypeUserNumber:
            self.MainTitleLabel.text = @"我的用户数";
            self.allTitleLabel.text = @"总人数";
            self.todayTitleLabel.text = @"今日新增";
            break;
        case ZDMePromoteCustomContactTypeOrder:
            self.MainTitleLabel.text = @"我的订单数";
            self.allTitleLabel.text = @"总订单";
            self.todayTitleLabel.text = @"昨日新增";
            break;
            
        default:
            break;
    }
}

@end
