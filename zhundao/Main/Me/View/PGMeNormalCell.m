//
//  PGMeNormalCell.m
//  zhundao
//
//  Created by maj on 2020/1/30.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "PGMeNormalCell.h"

@interface PGMeNormalCell()
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *redDotView;

@end

@implementation PGMeNormalCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self setupUI];
        [self initLayout];
    }
    return self;
}

#pragma mark --- lazyload
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
    }
    return _iconImageView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithFrame:CGRectZero textColor:[UIColor blackColor] font:ZDSystemFont(16) numberOfLines:0 lineBreakMode:0 lineAlignment:0];
    }
    return _titleLabel;
}
- (UIView *)redDotView {
    if (!_redDotView) {
        _redDotView = [[UIView alloc] init];
        _redDotView.backgroundColor = ZDRedColor;
        _redDotView.layer.cornerRadius = 5;
        _redDotView.layer.masksToBounds = YES;
        _redDotView.hidden = YES;
    }
    return _redDotView;
}

#pragma mark --- UI
- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.redDotView];
}

#pragma mark --- 布局
- (void)initLayout {
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(18);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerY.equalTo(self.contentView);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.leading.equalTo(self.iconImageView.mas_trailing).offset(15);
    }];
    [self.redDotView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).offset(-8);
        make.size.mas_equalTo(CGSizeMake(10, 10));
        make.centerY.mas_equalTo(self.contentView);
    }];
}

#pragma mark --- setter
- (void)setModel:(PGMeModel *)model {
    _model = model;
    self.iconImageView.image = model.image;
    self.titleLabel.text = model.title;
    if (model.type != PGMeTypeNotice) {
        self.redDotView.hidden = YES;
    } else {
       self.redDotView.hidden = !model.showRod;
    }
}


#pragma mark --- action

@end
