//
//  PGDataPersonAddCell.m
//  jingjing
//
//  Created by maj on 2020/8/10.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "PGDataPersonAddCell.h"

@interface PGDataPersonAddCell()<UITextFieldDelegate>
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *textTF;

@end

@implementation PGDataPersonAddCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        [self initLayout];
    }
    return self;
}

#pragma mark --- lazyload
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDBlackColor font:PGMediumFont(14) numberOfLines:0 lineBreakMode:0 lineAlignment:0];
    }
    return _titleLabel;
}
- (UITextField *)textTF {
    if (!_textTF) {
        _textTF = [[UITextField alloc] initWithFrame:CGRectZero];
        _textTF.placeholder = @"未填写*";
        _textTF.font = [UIFont systemFontOfSize:14];
        _textTF.textColor = ZDBlackColor;
        _textTF.attributedPlaceholder = [_textTF.placeholder dataPersonAttributed1];
        _textTF.delegate = self;
        _textTF.textAlignment = NSTextAlignmentRight;
    }
    return _textTF;
}

#pragma mark --- UI
- (void)setupUI {
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.textTF];
}

#pragma mark --- 布局
- (void)initLayout {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(15);
        make.centerY.equalTo(self.contentView);
        make.width.mas_equalTo(40);
    }];
    [self.textTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.titleLabel.mas_trailing);
        make.trailing.equalTo(self.contentView).offset(-15);
        make.top.bottom.equalTo(self.contentView);
    }];
}

#pragma mark --- setter
- (void)setModel:(PGDataPersonAddModel *)model {
    _model = model;
    self.titleLabel.text = model.text;
    self.textTF.text = model.content;
    if (_model.type == ZDDataPersonAddTypePhone) {
        _textTF.keyboardType = UIKeyboardTypeNumberPad;
    } else {
        _textTF.keyboardType = UIKeyboardTypeDefault;
    }
}

#pragma mark --- UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    _model.content = textField.text;
}

#pragma mark --- action

@end
