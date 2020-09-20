//
//  PGDataPersonCell.m
//  jingjing
//
//  Created by maj on 2020/8/10.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "PGDataPersonCell.h"

@interface PGDataPersonCell()
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *statusLabel;

@end

@implementation PGDataPersonCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
        [self initLayout];
    }
    return self;
}

#pragma mark --- lazyload
- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDBlackColor font:PGMediumFont(13) numberOfLines:0 lineBreakMode:0 lineAlignment:0];
    }
    return _numberLabel;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDBlackColor font:PGMediumFont(13) numberOfLines:0 lineBreakMode:0 lineAlignment:0];
    }
    return _nameLabel;
}
- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDGreyColor666 font:ZDSystemFont(11) numberOfLines:0 lineBreakMode:0 lineAlignment:0];
    }
    return _timeLabel;
}
- (UILabel *)phoneLabel {
    if (!_phoneLabel) {
        _phoneLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDGreyColor666 font:ZDSystemFont(11) numberOfLines:0 lineBreakMode:0 lineAlignment:NSTextAlignmentRight];
    }
    return _phoneLabel;
}
- (UILabel *)statusLabel {
    if (!_statusLabel) {
        _statusLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDGreyColor666 font:ZDSystemFont(12) numberOfLines:0 lineBreakMode:0 lineAlignment:0];
        _statusLabel.layer.cornerRadius = 4;
        _statusLabel.layer.masksToBounds = YES;
        _statusLabel.layer.borderWidth = 1;
        _statusLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _statusLabel;
}

#pragma mark --- UI
- (void)setupUI {
    [self.contentView addSubview:self.numberLabel];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.phoneLabel];
    [self.contentView addSubview:self.statusLabel];
}

#pragma mark --- 布局
- (void)initLayout {
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(16);
        make.centerY.equalTo(self.contentView);
        make.width.mas_equalTo(40);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.numberLabel.mas_trailing).offset(0);
        make.bottom.equalTo(self.contentView.mas_centerY).offset(-3);
        make.trailing.equalTo(self.phoneLabel.mas_leading).offset(-10);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_centerY).offset(3);
        make.leading.equalTo(self.nameLabel);
        make.trailing.equalTo(self.statusLabel.mas_leading).offset(-10);
    }];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).offset(-20);
        make.bottom.equalTo(self.nameLabel);
        make.width.mas_equalTo(90);
    }];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.phoneLabel);
        make.top.equalTo(self.contentView.mas_centerY).offset(3);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
}

#pragma mark --- setter
- (void)setModel:(PGDataPersonModel *)model {
    _model = model;
    
    _numberLabel.text = [NSString stringWithFormat:@"%li", (long)model.number];
    _nameLabel.text = model.UserName;
    _timeLabel.text = model.AddTime;
    _phoneLabel.text = model.Phone;
    switch (model.dataPersonStatus) {
        case ZDDataPersonStatusReview:
            _statusLabel.text = @"待审核";
            _statusLabel.textColor = [UIColor colorFromHexCode:@"EF9740"];
            _statusLabel.layer.borderColor = [UIColor colorFromHexCode:@"EF9740"].CGColor;
            break;
        case ZDDataPersonStatusReject:
            _statusLabel.text = @"已拒绝";
            _statusLabel.textColor = [UIColor colorFromHexCode:@"E64340"];
            _statusLabel.layer.borderColor = [UIColor colorFromHexCode:@"E64340"].CGColor;
            break;
        case ZDDataPersonStatusPass:
            _statusLabel.text = @"已通过";
            _statusLabel.textColor = [UIColor colorFromHexCode:@"09BB07"];
            _statusLabel.layer.borderColor = [UIColor colorFromHexCode:@"09BB07"].CGColor;
            break;
            
        default:
            break;
    }
}

#pragma mark --- action

@end
