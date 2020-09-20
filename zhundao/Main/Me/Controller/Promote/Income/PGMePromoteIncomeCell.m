#import "PGUploadCompletionBlock.h"
//
//  PGDiscoverPromoteIncomeCell.m
//  zhundao
//
//  Created by maj on 2020/1/6.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "PGMePromoteIncomeCell.h"

@interface PGMePromoteIncomeCell()
@property (nonatomic, strong) UILabel *countLabel; // 金额
@property (nonatomic, strong) UILabel *typeLabel; // 类型
@property (nonatomic, strong) UILabel *markLabel; // 备注
@property (nonatomic, strong) UILabel *timeLabel; // 时间

@end

@implementation PGMePromoteIncomeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
        [self initLayout];
    }
    return self;
}

#pragma mark --- lazyload
- (UILabel *)countLabel {
    if (!_countLabel) {
        _countLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDMainColor font:PGMediumFont(18) numberOfLines:0 lineBreakMode:0 lineAlignment:NSTextAlignmentCenter];
    }
    return _countLabel;
}
- (UILabel *)typeLabel {
    if (!_typeLabel) {
        _typeLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDBlackColor font:[UIFont systemFontOfSize:13] numberOfLines:0 lineBreakMode:0 lineAlignment:NSTextAlignmentCenter];
    }
    return _typeLabel;
}
- (UILabel *)markLabel {
    if (!_markLabel) {
        _markLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDBlackColor font:[UIFont systemFontOfSize:13] numberOfLines:0 lineBreakMode:0 lineAlignment:NSTextAlignmentCenter];
    }
    return _markLabel;
}
- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDBlackColor font:[UIFont systemFontOfSize:12] numberOfLines:0 lineBreakMode:0 lineAlignment:NSTextAlignmentCenter];
    }
    return _timeLabel;
}

#pragma mark --- UI
- (void)setupUI {
    [self.contentView addSubview:self.countLabel];
    [self.contentView addSubview:self.typeLabel];
    [self.contentView addSubview:self.markLabel];
    [self.contentView addSubview:self.timeLabel];
}

#pragma mark --- 布局
- (void)initLayout {
    CGFloat width = (kScreenWidth - 140) / 3;
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(width);
        make.top.bottom.leading.equalTo(self.contentView);
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
        make.trailing.equalTo(self.contentView);
        make.top.bottom.equalTo(self.countLabel);
    }];
}

#pragma mark --- setter
- (void)setModel:(PGMePromoteIncomeModel *)model {
    _model = model;
    _countLabel.text = [NSString stringWithFormat:@"+ %ld", (long)_model.Amount];
    _typeLabel.text = model.typeStr;
    _markLabel.text = model.Remark;
    _timeLabel.text = model.AddTime;
}


#pragma mark --- action


@end
