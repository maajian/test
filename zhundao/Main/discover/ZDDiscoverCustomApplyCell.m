//
//  ZDDiscoverCustomApplyCell.m
//  zhundao
//
//  Created by maj on 2018/12/1.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import "ZDDiscoverCustomApplyCell.h"

@interface ZDDiscoverCustomApplyCell()
// 类型
@property (nonatomic, strong) UILabel *typeLabel;
// 标题
@property (nonatomic, strong) UILabel *titleLabel;
// 必须
@property (nonatomic, strong) UILabel *mustLabel;

@end

@implementation ZDDiscoverCustomApplyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self setupUI];
        [self initLayout];
    }
    return self;
}

#pragma mark --- lazyload
- (UILabel *)typeLabel {
    if (!_typeLabel) {
        _typeLabel = [UILabel new];
        _typeLabel.textColor = kColorA(153, 153, 153, 1);
        _typeLabel.font = [UIFont systemFontOfSize:14];
        _typeLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _typeLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (UILabel *)mustLabel {
    if (!_mustLabel) {
        _mustLabel = [UILabel new];
        _mustLabel.text = @"*";
        _mustLabel.textColor = kColorA(153, 153, 153, 1);
        _mustLabel.font = [UIFont systemFontOfSize:14];
        _mustLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _mustLabel;
}

#pragma mark --- UI
- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.typeLabel];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.mustLabel];
}

#pragma mark --- 布局
- (void)initLayout {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(16);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.mustLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.titleLabel.mas_trailing).offset(4);
        make.centerY.equalTo(self.titleLabel);
        make.width.mas_equalTo(14);
    }];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.mustLabel.mas_trailing).offset(4);
        make.centerY.equalTo(self.contentView);
    }];
    
}

#pragma mark --- setter
- (void)setModel:(ZDDiscoverCustomApplyModel *)model {
    _model = model;
    
    _titleLabel.text = model.title;
    _typeLabel.text =  model.typeStr;
    if (model.required) {
        _mustLabel.textColor = [UIColor redColor];
    } else {
        _mustLabel.textColor = kColorA(153, 153, 153, 1);
    }
}

#pragma mark --- action

@end
