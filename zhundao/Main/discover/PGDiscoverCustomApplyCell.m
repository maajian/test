#import "PGBottomViewDelegate.h"
//
//  PGDiscoverCustomApplyCell.m
//  zhundao
//
//  Created by maj on 2018/12/1.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import "PGDiscoverCustomApplyCell.h"

@interface PGDiscoverCustomApplyCell()
// 类型
@property (nonatomic, strong) UILabel *typeLabel;
// 标题
@property (nonatomic, strong) UILabel *titleLabel;
// 必须
@property (nonatomic, strong) UILabel *mustLabel;

@end

@implementation PGDiscoverCustomApplyCell

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
    }
    return _typeLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _titleLabel;
}

- (UILabel *)mustLabel {
    if (!_mustLabel) {
        _mustLabel = [UILabel new];
        _mustLabel.text = @"*";
        _mustLabel.textColor = kColorA(153, 153, 153, 1);
        _mustLabel.font = [UIFont systemFontOfSize:14];
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
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(4);
        make.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(75);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.typeLabel.mas_right).offset(20);
        make.top.bottom.mas_equalTo(0);
        make.right.equalTo(self.mustLabel.mas_left).offset(-10);
    }];
    
    [self.mustLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.centerY.equalTo(self.contentView);
        make.width.mas_equalTo(10);
    }];
}

#pragma mark --- setter
- (void)setModel:(PGDiscoverCustomApplyModel *)model {
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
