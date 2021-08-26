//
//  ZDActivityMoreChioceOptionCell.m
//  zhundao
//
//  Created by maj on 2021/3/31.
//  Copyright © 2021 zhundao. All rights reserved.
//

#import "ZDActivityMoreChioceOptionCell.h"

@interface ZDActivityMoreChioceOptionCell()
@property (nonatomic, strong) UIButton *selectButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *mustLabel;
@property (nonatomic, strong) UIImageView *sortImageView;

@end

@implementation ZDActivityMoreChioceOptionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initSet];
        [self initLayout];
    }
    return self;
}

#pragma mark --- Init
- (void)initSet {
    [self.contentView addSubview:self.selectButton];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.mustLabel];
    [self.contentView addSubview:self.sortImageView];
}
- (void)initLayout {
    [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(20);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerY.equalTo(self.contentView);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.selectButton.mas_trailing).offset(4);
        make.centerY.equalTo(self.selectButton);
    }];
    [self.mustLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.titleLabel.mas_trailing).offset(4);
        make.size.mas_equalTo(CGSizeMake(14, 14));
        make.centerY.equalTo(self.selectButton);
    }];
    [self.sortImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).offset(-16);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerY.equalTo(self.contentView);
    }];
}

#pragma mark --- setter
- (void)setModel:(ZDActivityOptionModel *)model {
    _model = model;
    self.selectButton.selected = _model.IsCheck;
    self.titleLabel.text = _model.Title;
    self.mustLabel.text = _model.Required ? @"*" : @"";
    self.sortImageView.hidden = !_model.IsCheck;
}

#pragma mark --- Lazyload
- (UIButton *)selectButton {
    if (!_selectButton) {
        _selectButton = [UIButton buttonWithFrame:CGRectZero normalImage:[UIImage imageNamed:@"activity_more_check_disable"] selectedImage:[UIImage imageNamed:@"activity_more_check_select"] target:self action:nil];
        _selectButton.userInteractionEnabled = NO;
    }
    return _selectButton;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [MyLabel initWithLabelFrame:CGRectMake(10, 0, 120, 44) Text:nil textColor:ZDBlackColor font:ZDSystemFont(13) textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:0];
    }
    return _titleLabel;
}
- (UILabel *)mustLabel {
    if (!_mustLabel) {
        _mustLabel = [MyLabel initWithLabelFrame:CGRectMake(10, 0, 120, 44) Text:nil textColor:ZDRedColor font:ZDSystemFont(14) textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:0];
    }
    return _mustLabel;
}
- (UIImageView *)sortImageView {
    if (!_sortImageView) {
        _sortImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"activity_more_sort"]];
    }
    return _sortImageView;
}

@end
