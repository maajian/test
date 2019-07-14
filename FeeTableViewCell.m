//
//  FeeTableViewCell.m
//  zhundao
//
//  Created by zhundao on 2017/5/3.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "FeeTableViewCell.h"

@implementation FeeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        [self initLayout];
    }
    return self;
}

#pragma mark --- lazyload
- (UILabel *)leftLabel1 {
    if (!_leftLabel1) {
        _leftLabel1 = [[UILabel alloc] init];
        _leftLabel1.text = @"费用名称";
        _leftLabel1.font = [UIFont systemFontOfSize:17];
    }
    return _leftLabel1;
}
- (UILabel *)leftLabel2 {
    if (!_leftLabel2) {
        _leftLabel2 = [[UILabel alloc] init];
        _leftLabel2.text = @"金额";
        _leftLabel2.font = [UIFont systemFontOfSize:17];
    }
    return _leftLabel2;
}
- (UILabel *)leftLabel3 {
    if (!_leftLabel3) {
        _leftLabel3 = [[UILabel alloc] init];
        _leftLabel3.text = @"名额限制";
        _leftLabel3.font = [UIFont systemFontOfSize:17];
    }
    return _leftLabel3;
}
- (UILabel *)leftLabel4 {
    if (!_leftLabel4) {
        _leftLabel4 = [[UILabel alloc] init];
        _leftLabel4.text= @"排序";
        _leftLabel4.font = [UIFont systemFontOfSize:17];
    }
    return _leftLabel4;
}
- (UILabel *)leftLable5 {
    if (!_leftLable5) {
        _leftLable5 = [[UILabel alloc] init];
        _leftLable5.text = @"显示";
        _leftLable5.font = [UIFont systemFontOfSize:17];
    }
    return _leftLable5;
}
- (UITextField *)textFIeld1 {
    if (!_textFIeld1) {
        _textFIeld1 = [[UITextField alloc] init];
        _textFIeld1.font = [UIFont systemFontOfSize:17];
        _textFIeld1.placeholder = @"费用名称";
        _textFIeld1.textColor = [UIColor blackColor];
    }
    return _textFIeld1;
}
- (UITextField *)textFIeld2 {
    if (!_textFIeld2) {
        _textFIeld2 = [[UITextField alloc] init];
        _textFIeld2.placeholder = @"请输入金额";
        _textFIeld2.keyboardType = UIKeyboardTypeDecimalPad;
        _textFIeld2.font = [UIFont systemFontOfSize:17];
        _textFIeld2.textColor = [UIColor blackColor];
    }
    return _textFIeld2;
}
- (UITextField *)textFIeld3 {
    if (!_textFIeld3) {
        _textFIeld3 = [[UITextField alloc] init];
        _textFIeld3.placeholder = @"默认不限";
        _textFIeld3.font = [UIFont systemFontOfSize:17];
        _textFIeld3.keyboardType = UIKeyboardTypeNumberPad;
        _textFIeld3.textColor = [UIColor blackColor];
    }
    return _textFIeld3;
}
- (UITextField *)textField4 {
    if (!_textField4) {
        _textField4 = [[UITextField alloc] init];
        _textField4.keyboardType = UIKeyboardTypeNumberPad;
        _textField4.font = [UIFont systemFontOfSize:17];
        _textField4.textColor = [UIColor blackColor];
    }
    return _textField4;
}
- (UISwitch *)showSwitch {
    if (!_showSwitch) {
        _showSwitch = [[UISwitch alloc] init];
        [_showSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _showSwitch;
}
- (UIImageView *)deleteImageView {
    if (!_deleteImageView) {
        _deleteImageView = [[UIImageView alloc] init];;
        _deleteImageView.image = [UIImage imageNamed:@"deleteCant.png"];
    }
    return _deleteImageView;
}
- (UIView *)lineView1 {
    if (!_lineView1) {
        _lineView1 = [[UIView alloc] init];
        _lineView1.backgroundColor = zhundaoLineColor;
    }
    return _lineView1;
}
- (UIView *)lineView2 {
    if (!_lineView2) {
        _lineView2 = [[UIView alloc] init];
        _lineView2.backgroundColor = zhundaoLineColor;
    }
    return _lineView2;
}
- (UIView *)lineView3 {
    if (!_lineView3) {
        _lineView3 = [[UIView alloc] init];
        _lineView3.backgroundColor = zhundaoLineColor;
    }
    return _lineView3;
}
- (UIView *)lineView4 {
    if (!_lineView4) {
        _lineView4 = [[UIView alloc] init];
        _lineView4.backgroundColor = zhundaoLineColor;
    }
    return _lineView4;
}

#pragma mark --- UI
- (void)setupUI {
    [self.contentView addSubview:self.leftLabel1];
    [self.contentView addSubview:self.leftLabel2];
    [self.contentView addSubview:self.leftLabel3];
    [self.contentView addSubview:self.leftLabel4];
    [self.contentView addSubview:self.leftLable5];
    [self.contentView addSubview:self.textFIeld1];
    [self.contentView addSubview:self.textFIeld2];
    [self.contentView addSubview:self.textFIeld3];
    [self.contentView addSubview:self.textField4];
    [self.contentView addSubview:self.showSwitch];
    [self.contentView addSubview:self.deleteImageView];
    [self.contentView addSubview:self.lineView1];
    [self.contentView addSubview:self.lineView2];
    [self.contentView addSubview:self.lineView3];
    [self.contentView addSubview:self.lineView4];
}

#pragma mark --- 布局
- (void)initLayout {
    [self.leftLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(85);
        make.height.mas_equalTo(44);
    }];
    [self.leftLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.leftLabel1.mas_bottom).offset(0);
        make.width.mas_equalTo(85);
        make.height.mas_equalTo(44);
    }];
    [self.leftLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.leftLabel2.mas_bottom).offset(0);
        make.width.mas_equalTo(85);
        make.height.mas_equalTo(44);
    }];
    [self.leftLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.leftLabel3.mas_bottom).offset(0);
        make.width.mas_equalTo(85);
        make.height.mas_equalTo(44);
    }];
    [self.leftLable5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.leftLabel4.mas_bottom).offset(0);
        make.width.mas_equalTo(85);
        make.height.mas_equalTo(44);
    }];
    [self.textFIeld1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.leftLabel1.mas_trailing).offset(5);
        make.trailing.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.contentView).offset(0);
        make.height.mas_equalTo(44);
    }];
    [self.textFIeld2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.leftLabel2.mas_trailing).offset(5);
        make.trailing.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.textFIeld1.mas_bottom).offset(0);
        make.height.mas_equalTo(44);
    }];
    [self.textFIeld3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.leftLabel3.mas_trailing).offset(5);
        make.trailing.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.textFIeld2.mas_bottom).offset(0);
        make.height.mas_equalTo(44);
    }];
    [self.textField4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.leftLabel4.mas_trailing).offset(5);
        make.trailing.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.textFIeld3.mas_bottom).offset(0);
        make.height.mas_equalTo(44);
    }];
    [self.showSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).offset(-10);
        make.centerY.equalTo(self.leftLable5);
    }];
    [self.deleteImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).offset(-10);
        make.size.mas_offset(CGSizeMake(25, 25));
        make.centerY.equalTo(self.contentView.mas_top);
    }];
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.contentView);
        make.top.equalTo(self.leftLabel1.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.contentView);
        make.top.equalTo(self.leftLabel2.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    [self.lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.contentView);
        make.top.equalTo(self.leftLabel3.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    [self.lineView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.contentView);
        make.top.equalTo(self.leftLabel4.mas_bottom);
        make.height.mas_equalTo(1);
    }];
}

#pragma mark --- setter

#pragma mark --- action
- (void)switchAction:(UISwitch *)showSwitch {
    if ([self.feeTableViewCellDelegate respondsToSelector:@selector(feeTableViewCell:showSwitchDidChange:)]) {
        [self.feeTableViewCellDelegate feeTableViewCell:self showSwitchDidChange:showSwitch];
    }
}

@end
