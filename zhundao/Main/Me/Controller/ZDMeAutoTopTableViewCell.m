//
//  ZDMeAutoTopTableViewCell.m
//  zhundao
//
//  Created by zhundao on 2017/9/19.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ZDMeAutoTopTableViewCell.h"

@implementation ZDMeAutoTopTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.leftlabel];
        [self.contentView addSubview:self.rightTf];
    }
    return self;
}

- (UILabel *)leftlabel{
    if (!_leftlabel) {
        _leftlabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 1000, 44)];
    }
    return _leftlabel;
}


- (UITextField *)rightTf{
    if (!_rightTf) {
        _rightTf = [myTextField initWithFrame:CGRectZero placeholder:nil font:[UIFont systemFontOfSize:17] TextAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
    }
    return _rightTf;
}

- (void)setLeftStr:(NSString *)leftStr{
    _leftStr =leftStr;
    _leftlabel.text = leftStr;
     [_leftlabel sizeToFit];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    _leftlabel.frame= CGRectMake(10, 0, _leftlabel.frame.size.width, 44);
    _rightTf.frame = CGRectMake(CGRectGetMaxX(_leftlabel.frame)+5, 0, kScreenWidth-(CGRectGetMaxX(_leftlabel.frame)+5), 44);
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
