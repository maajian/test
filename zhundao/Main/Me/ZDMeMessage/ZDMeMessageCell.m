//
//  ZDMeMessageCell.m
//  jingjing
//
//  Created by maj on 2020/8/4.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "ZDMeMessageCell.h"

@interface ZDMeMessageCell()
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailTitleLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation ZDMeMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

#pragma mark --- lazyload
- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
    }
    return _leftImageView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDBlackColor font:ZDSystemFont(15) numberOfLines:0 lineBreakMode:NSLineBreakByTruncatingTail lineAlignment:1];
    }
    return _titleLabel;
}
- (UILabel *)detailTitleLabel {
    if (!_detailTitleLabel) {
        _detailTitleLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDGreyColor666 font:ZDSystemFont(13) numberOfLines:0 lineBreakMode:NSLineBreakByTruncatingTail lineAlignment:1];
    }
    return _detailTitleLabel;
}
- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDGreyColor999 font:ZDSystemFont(11) numberOfLines:0 lineBreakMode:0 lineAlignment:NSTextAlignmentRight];
    }
    return _timeLabel;
}

#pragma mark --- UI
- (void)setupUI {
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.leftImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.detailTitleLabel];
    [self.contentView addSubview:self.timeLabel];
}

#pragma mark --- 布局
- (void)initLayout {
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(16);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(43, 43));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.leftImageView.mas_trailing).offset(10);
        make.top.equalTo(self.contentView).offset(11);
    }];
    [self.detailTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.titleLabel);
        make.bottom.equalTo(self.contentView).offset(15);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel);
        make.trailing.equalTo(self.contentView).offset(-17);
    }];
}

#pragma mark --- setter
- (void)setModel:(ZDMeMessageModel *)model {
    _model = model;
    
    
}

#pragma mark --- action

@end
