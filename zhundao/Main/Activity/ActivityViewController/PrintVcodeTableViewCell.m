//
//  PrintVcodeTableViewCell.m
//  zhundao
//
//  Created by zhundao on 2017/7/19.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PrintVcodeTableViewCell.h"

@implementation PrintVcodeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(listModel *)model
{
    if (model) {
        _model = model;
    }
    _CountLabel.text =[NSString stringWithFormat:@"%li",(long)_model.count];
    _nameLabel.text =_model.UserName;
    _phoneLabel.text = _model.Mobile;
    [self setButtonC:_pMoreButton];
    [self setButtonC:_pOneButton];
}

- (void)setButtonC :(UIButton *)button
{
    [button setTitleColor:ZDGreenColor forState:UIControlStateNormal];
    [button setTitleColor:ZDGrayColor forState:UIControlStateHighlighted];
    button.layer.borderColor = ZDGreenColor.CGColor;
    button.layer.borderWidth = 1 ;
    button.layer.cornerRadius = 5 ;
    button.layer.masksToBounds = YES;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
