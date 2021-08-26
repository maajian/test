//
//  ZDActivitySignCell.m
//  zhundao
//
//  Created by maj on 2021/5/12.
//  Copyright © 2021 zhundao. All rights reserved.
//

#import "ZDActivitySignCell.h"

@interface ZDActivitySignCell()
@property (nonatomic, strong) UILabel *signTitleLabel;
@property (nonatomic, strong) UIButton *moreButton;
@property (nonatomic, strong) UIView *centerView;
@property (nonatomic, strong) UISwitch *openSwitch;
@property (nonatomic, strong) UIButton *signButton;

@property (nonatomic, copy) NSArray *titleArray;
@property (nonatomic, strong) NSMutableArray<UILabel *> *countLabelArray;

@end

@implementation ZDActivitySignCell
ZDGetter_MutableArray(countLabelArray)

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
    [self.contentView addSubview:self.signTitleLabel];
    [self.contentView addSubview:self.moreButton];
    [self.contentView addSubview:self.centerView];
    [self.contentView addSubview:self.openSwitch];
    [self.contentView addSubview:self.signButton];
}
- (void)initLayout {
    [self.signTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(16);
        make.leading.equalTo(self.contentView).offset(16);
        make.trailing.equalTo(self.moreButton.mas_leading).offset(-10);
    }];
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).offset(-16);
        make.top.equalTo(self.contentView).offset(16);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(56);
        make.leading.trailing.equalTo(self.contentView);
        make.height.mas_equalTo(50);
    }];
    [self.openSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-14);
        make.leading.equalTo(self.contentView).offset(18);
    }];
    [self.signButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(53, 20));
        make.bottom.equalTo(self.contentView).offset(-18);
    }];
    for (int i = 0; i < self.titleArray.count; i++) {
        UILabel *countLabel = [UILabel labelWithFrame:CGRectZero textColor:[UIColor colorFromHexCode:@"7B7D8D"] font:ZDSystemFont(14) numberOfLines:0 lineBreakMode:0 lineAlignment:NSTextAlignmentCenter];
        countLabel.text = [NSString stringWithFormat:@"%@ --", self.titleArray[i]];
        [self.centerView addSubview:countLabel];
        [self.countLabelArray addObject:countLabel];
    }
    [self.countLabelArray mas_distributeViewsAlongAxis:(MASAxisTypeHorizontal) withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [self.countLabelArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.centerView);
    }];
    [self.contentView layoutIfNeeded];
    [self.signButton setButtonWithButtonInsetType:(WYButtonInsetTypeTitleLeft) space:5];
}

#pragma mark --- setter
- (void)setSignInModel:(ZDSignInModel *)signInModel {
    _signInModel = signInModel;
    self.signTitleLabel.text = signInModel.Name;
    self.openSwitch.on = signInModel.Status;
    
    self.countLabelArray[0].text = [NSString stringWithFormat:@"%@ %li", self.titleArray[0], signInModel.NumFact];
    self.countLabelArray[1].text = [NSString stringWithFormat:@"%@ %li", self.titleArray[1], signInModel.NumShould - signInModel.NumFact];
    self.countLabelArray[2].text = [NSString stringWithFormat:@"%@ %li", self.titleArray[2], signInModel.NumShould];
    
    [self setAttributedText:0 string:@(signInModel.NumFact).stringValue];
    [self setAttributedText:1 string:@(signInModel.NumShould - signInModel.NumFact).stringValue];
    [self setAttributedText:2 string:@(signInModel.NumShould).stringValue];
    if (signInModel.NumShould == 0) {
        self.countLabelArray[3].text = [NSString stringWithFormat:@"%@ 0.0%%", self.titleArray[3]];
        [self setAttributedText:3 string:@"0.0%%"];
    } else {
        self.countLabelArray[3].text = [NSString stringWithFormat:@"%@ %.0f%%", self.titleArray[3], (float)signInModel.NumFact/signInModel.NumShould * 100];
        [self setAttributedText:3 string:[NSString stringWithFormat:@"%.0f%%",(float)signInModel.NumFact/signInModel.NumShould * 100]];
    }
}

#pragma mark --- Action
- (void)openAction:(UISwitch *)openSwitch {
    if ([self.activitySignCellDelegate respondsToSelector:@selector(activitySignCell:didTapOpenSwitch:)]) {
        [self.activitySignCellDelegate activitySignCell:self didTapOpenSwitch:openSwitch];
    }
}
- (void)moreAction:(UIButton *)button {
    if ([self.activitySignCellDelegate respondsToSelector:@selector(activitySignCell:didTapMoreButton:)]) {
        [self.activitySignCellDelegate activitySignCell:self didTapMoreButton:button];
    }
}
- (void)signAction:(UIButton *)button {
    if ([self.activitySignCellDelegate respondsToSelector:@selector(activitySignCell:didTapSignButton:)]) {
        [self.activitySignCellDelegate activitySignCell:self didTapSignButton:button];
    }
}
- (void)setAttributedText:(NSInteger)index string:(NSString *)string {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.countLabelArray[index].text];
    [attributedString addAttributes:@{NSForegroundColorAttributeName: [UIColor colorFromHexCode:@"2C2D30"], NSFontAttributeName : ZDBoldFont(14)} range:[self.countLabelArray[index].text rangeOfString:string]];
    self.countLabelArray[index].attributedText = attributedString;
}

#pragma mark --- Lazyload
- (NSArray *)titleArray {
    return @[@"已签", @"待签", @"全部", @"签到率"] ;
}
- (UILabel *)signTitleLabel {
    if (!_signTitleLabel) {
        _signTitleLabel = [UILabel labelWithFrame:CGRectZero textColor:[UIColor colorFromHexCode:@"19191A"] font:ZDBoldFont(16) numberOfLines:0 lineBreakMode:NSLineBreakByTruncatingTail lineAlignment:0];
    }
    return _signTitleLabel;
}
- (UIButton *)moreButton {
    if (!_moreButton) {
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreButton setImage:[UIImage imageNamed:@"sign_more"] forState:UIControlStateNormal];
        [_moreButton addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreButton;
}
- (UIView *)centerView {
    if (!_centerView) {
        _centerView = [[UIView alloc] init];
        _centerView.backgroundColor = [UIColor colorFromHexCode:@"F5F8FE"];
    }
    return _centerView;
}
- (UISwitch *)openSwitch {
    if (!_openSwitch) {
        _openSwitch = [[UISwitch alloc] init];
        [_openSwitch addTarget:self action:@selector(openAction:) forControlEvents:UIControlEventTouchUpInside];;
    }
    return _openSwitch;
}
- (UIButton *)signButton {
    if (!_signButton) {
        _signButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_signButton setTitle:@"签到" forState:UIControlStateNormal];
        [_signButton setTitleColor:ZDBlackColor forState:UIControlStateNormal];
        _signButton.titleLabel.font = ZDSystemFont(14);
        [_signButton addTarget:self action:@selector(signAction:) forControlEvents:UIControlEventTouchUpInside];
        [_signButton setImage:[UIImage imageNamed:@"sign_arrow"] forState:UIControlStateNormal];
    }
    return _signButton;
}

@end
