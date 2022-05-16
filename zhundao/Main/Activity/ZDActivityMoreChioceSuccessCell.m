//
//  ZDActivityMoreChioceSuccessCell.m
//  zhundao
//
//  Created by huanfutech on 2022/5/12.
//  Copyright © 2022 zhundao. All rights reserved.
//

#import "ZDActivityMoreChioceSuccessCell.h"

@interface ZDActivityMoreChioceSuccessCell()<UITextFieldDelegate>
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *desLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UILabel *bottomLabel;
@property (nonatomic, strong) UIView *addBorderView;
@property (nonatomic, strong) UIImageView *addImageView;
@property (nonatomic, strong) UITextField *linkTF;
@property (nonatomic, strong) UIImageView *chooseImageView; // 选择的图片

@end

@implementation ZDActivityMoreChioceSuccessCell

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
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.desLabel];
    [self.contentView addSubview:self.arrowImageView];
    [self.contentView addSubview:self.bottomLabel];
    [self.contentView addSubview:self.addBorderView];
    [self.contentView addSubview:self.addImageView];
    [self.contentView addSubview:self.linkTF];
    [self.contentView addSubview:self.chooseImageView];
}
- (void)initLayout {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(16);
        make.top.equalTo(self.contentView).offset(16);
        make.height.mas_equalTo(20);
    }];
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.titleLabel.mas_trailing).offset(8);
        make.top.bottom.equalTo(self.titleLabel);
        make.trailing.equalTo(self.arrowImageView.mas_leading).offset(-8);
    }];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).offset(-16);
        make.centerY.equalTo(self.titleLabel);
        make.size.mas_equalTo(CGSizeMake(12, 12));
    }];
    [self.addBorderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(8);
        make.leading.equalTo(self.titleLabel);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    [self.addImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.addBorderView);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [self.chooseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.addBorderView.mas_trailing).offset(20);
        make.size.centerY.equalTo(self.addBorderView);
    }];
    [self.linkTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.titleLabel);
        make.trailing.equalTo(self.contentView).offset(-16);
        make.height.mas_equalTo(40);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(12);
    }];
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addBorderView.mas_bottom).offset(10);
        make.leading.equalTo(self.addBorderView);
        make.trailing.equalTo(self.linkTF);
    }];
}

#pragma mark --- setter
- (void)setAdModel:(ZDActivityADModel *)adModel {
    _adModel = adModel;
    self.titleLabel.text = @"报名成功后设置";
    self.bottomLabel.text = @"";
    self.linkTF.hidden = adModel.adtype != ZDActivityADTypeLink;
    self.addImageView.hidden = self.addBorderView.hidden = adModel.adtype != ZDActivityADTypeImage;
    self.arrowImageView.image = [UIImage imageNamed:@"rightArrows"];
    self.chooseImageView.hidden = YES;
    if (adModel.adtype == ZDActivityADTypeNone) {
        self.desLabel.text = @"系统默认";
    } else if (adModel.adtype == ZDActivityADTypeImage) {
        self.desLabel.text = @"显示图片(如微信群二维码)";
        self.bottomLabel.text = @"建议尺寸600px*360px, 或宽度600px高度自适应";
        self.chooseImageView.hidden = adModel.adurl.length == 0;
        [self.chooseImageView sd_setImageWithURL:[NSURL URLWithString:adModel.adurl]];
    } else {
        self.desLabel.text = @"跳转链接";
    }
}

#pragma mark --- Action
- (void)addImageAction:(id)sender {
    if ([self.activityMoreChioceSuccessCellDelegate respondsToSelector:@selector(ZDActivityMoreChioceSuccessCellSelectImage:)]) {
        [self.activityMoreChioceSuccessCellDelegate ZDActivityMoreChioceSuccessCellSelectImage:self];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.adModel.adurl = textField.text;
}

#pragma mark --- Lazyload
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithFrame:CGRectZero textColor:[UIColor blackColor] font:KHeitiSCMedium(15) numberOfLines:0 lineBreakMode:0 lineAlignment:0];
    }
    return _titleLabel;
}
- (UILabel *)desLabel {
    if (!_desLabel) {
        _desLabel = [UILabel labelWithFrame:CGRectZero textColor:ZD_FontColor_Subtitle font:KHeitiSCLight(15) numberOfLines:0 lineBreakMode:0 lineAlignment:NSTextAlignmentRight];
    }
    return _desLabel;
}
- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] init];
    }
    return _arrowImageView;
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
- (UITextField *)linkTF {
    if (!_linkTF) {
        _linkTF = [[UITextField alloc] init];
        _linkTF.textColor = [UIColor blackColor];
        _linkTF.font = [UIFont systemFontOfSize:14];
        _linkTF.delegate = self;
        _linkTF.layer.cornerRadius = 5;
        _linkTF.layer.masksToBounds = YES;
        _linkTF.layer.borderColor = ZDLineColor.CGColor;
        _linkTF.layer.borderWidth = 1;
        _linkTF.placeholder = @"请输入跳转地址需+http:// 或https://";
        _linkTF.returnKeyType = UIReturnKeySearch;
        _linkTF.keyboardType = UIKeyboardTypeNumberPad;
        _linkTF.backgroundColor = [UIColor whiteColor];
        _linkTF.tintColor = ZDGreenColor;
        _linkTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
        _linkTF.leftViewMode = UITextFieldViewModeAlways;
    }
    return _linkTF;
}
- (UILabel *)bottomLabel {
    if (!_bottomLabel) {
        _bottomLabel = [UILabel labelWithFrame:CGRectZero textColor:ZD_FontColor_Subtitle font:KHeitiSCMedium(12) numberOfLines:0 lineBreakMode:0 lineAlignment:0];
    }
    return _bottomLabel;
}
- (UIImageView *)chooseImageView {
    if (!_chooseImageView) {
        _chooseImageView = [[UIImageView alloc] init];
    }
    return _chooseImageView;
}

@end
