//
//  ZDSupplierMeCell.m
//  zhundao
//
//  Created by maj on 2021/9/2.
//  Copyright © 2021 zhundao. All rights reserved.
//

#import "ZDSupplierMeCell.h"

@interface ZDSupplierMeCell()
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *desTitleLabel;

@end

@implementation ZDSupplierMeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initSet];
        [self initLayout];
    }
    return self;
}

#pragma mark --- Init
- (void)initSet {
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.desTitleLabel];
}
- (void)initLayout {
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.leading.equalTo(self.contentView).offset(16);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.iconImageView.mas_trailing).offset(8);
        make.bottom.equalTo(self.iconImageView.mas_centerY).offset(-2);
        make.trailing.equalTo(self.contentView).offset(-16);
    }];
    [self.desTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.iconImageView.mas_trailing).offset(8);
        make.top.equalTo(self.iconImageView.mas_centerY).offset(4);
        make.trailing.equalTo(self.contentView).offset(-16);
    }];
}

#pragma mark --- setter
- (void)setModel:(ZDSupplierMeModel *)model {
    _model = model;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"user"]];
    self.titleLabel.text = model.admin_name;
    self.desTitleLabel.text = model.company;
}

#pragma mark --- Lazyload
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.layer.cornerRadius = 25;
        _iconImageView.layer.masksToBounds = YES;
    }
    return _iconImageView;;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDGreyColor666 font:ZDSystemFont(16) numberOfLines:1 lineBreakMode:NSLineBreakByTruncatingTail lineAlignment:0];
    }
    return _titleLabel;
}
- (UILabel *)desTitleLabel {
    if (!_desTitleLabel) {
        _desTitleLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDGreyColor666 font:ZDSystemFont(14) numberOfLines:1 lineBreakMode:NSLineBreakByTruncatingTail lineAlignment:0];
    }
    return _desTitleLabel;
}

@end
