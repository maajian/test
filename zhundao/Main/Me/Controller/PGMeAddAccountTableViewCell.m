//
//  PGMeAddAccountTableViewCell.m
//  zhundao
//
//  Created by zhundao on 2017/9/19.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PGMeAddAccountTableViewCell.h"

@implementation PGMeAddAccountTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.bottomLeftLabel];
        [self.contentView addSubview:self.rightLabel];
    }
    return self;
}


- (void)setRow:(NSInteger)row{
    _row = row;
    switch (row) {
        case 0:{
            self.bottomLeftLabel.text = @"提现方式";;
            self.rightLabel.text = _currentType;
            [self.bottomLeftLabel sizeToFit];
            self.bottomLeftLabel.frame = CGRectMake(16, 0, self.bottomLeftLabel.frame.size.width, 44);
            self.rightLabel.frame = CGRectMake(CGRectGetMaxX(_bottomLeftLabel.frame)+20, 0, kScreenWidth-(CGRectGetMaxX(_bottomLeftLabel.frame)+20), 44);
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
            break;
        case 1:{
            while (self.contentView.subviews.lastObject!=nil) {
                [self.contentView.subviews.lastObject removeFromSuperview];
            }
            [self.contentView addSubview:self.topLeftLabel];
            [self.contentView addSubview:self.textf];
            if ([_currentType isEqualToString:@"支付宝"]) {
                self.topLeftLabel.text = @"支付宝账号";
            }else{
                self.topLeftLabel.text = @"银行卡号";
            }
            self.textf.placeholder = @"请输入对应的账号和卡号";
            [self.topLeftLabel sizeToFit];
            self.topLeftLabel.frame = CGRectMake(16, 0, self.topLeftLabel.frame.size.width, 44);
            self.textf.frame= CGRectMake(CGRectGetMaxX(_topLeftLabel.frame)+10, 0, kScreenWidth-(CGRectGetMaxX(_topLeftLabel.frame)+10), 44);
        }
            break;
        case 2:{
            self.bottomLeftLabel.text = @"真实姓名";
            self.rightLabel.text = _name;
            [self.bottomLeftLabel sizeToFit];
            self.bottomLeftLabel.frame = CGRectMake(16, 0, self.bottomLeftLabel.frame.size.width, 44);
            self.rightLabel.frame = CGRectMake( CGRectGetMaxX(_bottomLeftLabel.frame)+10,0, kScreenWidth-(CGRectGetMaxX(_bottomLeftLabel.frame)+20), 44);
        }
            break;
        default:
            break;
    }
}

#pragma mark --- 懒加载

- (UILabel *)topLeftLabel{
    if (!_topLeftLabel) {
        _topLeftLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, 0, 1000, 44)];
    }
    return _topLeftLabel;
}

- (UILabel *)rightLabel{
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    }
    return _rightLabel;
}

- (UILabel *)bottomLeftLabel{
    if (!_bottomLeftLabel) {
        _bottomLeftLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, 0, 1000, 44)];
    }
    return _bottomLeftLabel;
}


-(UITextField *)textf{
    if (!_textf) {
        _textf = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_topLeftLabel.frame)+20, 0, 250, 44)];
    }
    return _textf;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
