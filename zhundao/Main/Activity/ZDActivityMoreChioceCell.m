//
//  ZDActivityMoreChioceCell.m
//  zhundao
//
//  Created by maj on 2021/3/31.
//  Copyright © 2021 zhundao. All rights reserved.
//

#import "ZDActivityMoreChioceCell.h"

@interface ZDActivityMoreChioceCell()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *desTitleLabel;
@property (nonatomic, strong) UISwitch *alertSwitch;
@property (nonatomic, strong) UIImageView *shareImageView;

@property (nonatomic, strong) UIView *addBorderView;
@property (nonatomic, strong) UIImageView *addImageView;

@end

@implementation ZDActivityMoreChioceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initSet];
        [self initLayout];
    }
    return self;
}

#pragma mark --- Init
- (void)initSet {
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.desTitleLabel];
    [self.contentView addSubview:self.alertSwitch];
    [self.contentView addSubview:self.shareImageView];
    [self.contentView addSubview:self.addBorderView];
    [self.addBorderView addSubview:self.addImageView];
}
- (void)initLayout {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(16);
        make.centerY.equalTo(self.contentView);
    }];
    [self.desTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).offset(-8);
        make.centerY.equalTo(self.contentView);
    }];
    [self.alertSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).offset(-16);
        make.centerY.equalTo(self.contentView);
    }];
    [self.shareImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(16);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    [self.addBorderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.shareImageView.mas_trailing).offset(10);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    [self.addImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.addBorderView);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
}

#pragma mark --- setter
- (void)setModel:(ZDActivityMoreChioceModel *)model {
    _model = model;
    self.titleLabel.hidden = model.moreChioceType == ZDActivityMoreChioceTypeImage;
    self.desTitleLabel.hidden = model.moreChioceType == ZDActivityMoreChioceTypeImage || model.moreChioceType == ZDActivityMoreChioceTypeAlert;
    self.alertSwitch.hidden = model.moreChioceType != ZDActivityMoreChioceTypeAlert;
    self.shareImageView.hidden = self.addImageView.hidden = self.addBorderView.hidden = model.moreChioceType != ZDActivityMoreChioceTypeImage;
    if (model.moreChioceType == ZDActivityMoreChioceTypeImage) {
        [self.shareImageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
        self.accessoryType = UITableViewCellAccessoryNone;
    } else if (model.moreChioceType == ZDActivityMoreChioceTypeAlert) {
        self.titleLabel.text = model.title;
        self.alertSwitch.on = model.isAlert;
        self.accessoryType = UITableViewCellAccessoryNone;
    } else if (model.moreChioceType == ZDActivityMoreChioceTypeOption) {
        self.titleLabel.text = model.title;
        self.desTitleLabel.text = model.detailTitle;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        self.titleLabel.text = model.title;
        if (model.showListType == ZDActivityShowListTypeNone) {
            self.desTitleLabel.text = @"隐藏";
        } else if (model.showListType == ZDActivityShowListTypeCount) {
            self.desTitleLabel.text = @"显示人数";
        } else if (model.showListType == ZDActivityShowListTypeCountAndNickname) {
            self.desTitleLabel.text = @"显示人数和头像昵称";
        } else {
            self.desTitleLabel.text = @"显示人数和头像姓名";
        }
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
}

#pragma mark --- Action
- (void)switchChange:(UISwitch *)alertSwitch {
    _model.isAlert = alertSwitch.on;
    if ([self.moreChioceCellDelegate respondsToSelector:@selector(moreChioceCell:didChangeAlertSwitch:)]) {
        [self.moreChioceCellDelegate moreChioceCell:self didChangeAlertSwitch:alertSwitch];
    }
}
- (void)addImageAction:(UITapGestureRecognizer *)sender {
    if ([self.moreChioceCellDelegate respondsToSelector:@selector(moreChioceCell:didChangeImage:)]) {
        [self.moreChioceCellDelegate moreChioceCell:self didChangeImage:self.addImageView];
    }
}

#pragma mark --- Lazyload
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [MyLabel initWithLabelFrame:CGRectZero Text:nil textColor:[UIColor blackColor] font:KHeitiSCMedium(15) textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:0];
    }
    return _titleLabel;
}
- (UILabel *)desTitleLabel {
    if (!_desTitleLabel) {
        _desTitleLabel = [MyLabel initWithLabelFrame:CGRectZero Text:nil textColor:ZD_FontColor_Subtitle font:KHeitiSCLight(15) textAlignment:NSTextAlignmentRight cornerRadius:0 masksToBounds:0];
    }
    return _desTitleLabel;
}
- (UISwitch *)alertSwitch {
    if (!_alertSwitch) {
        _alertSwitch = [[UISwitch alloc]initWithFrame:CGRectZero];
        [_alertSwitch addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _alertSwitch;
}
- (UIImageView *)shareImageView {
    if (!_shareImageView) {
        _shareImageView = [[UIImageView alloc] init];
    }
    return _shareImageView;
}
- (UIView *)addBorderView {
    if (!_addBorderView) {
        _addBorderView = [[UIView alloc] init];
        _addBorderView.layer.borderWidth = 1;
        _addBorderView.layer.borderColor = ZDLineColor.CGColor;
        [_addBorderView addTapGestureTarget:self action:@selector(addImageAction:)];
    }
    return _addBorderView;
}
- (UIImageView *)addImageView {
    if (!_addImageView) {
        _addImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"加号"]];
    }
    return _addImageView;
}

@end
