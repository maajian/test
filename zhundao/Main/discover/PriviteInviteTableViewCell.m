//
//  PriviteInviteTableViewCell.m
//  zhundao
//
//  Created by zhundao on 2017/9/13.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PriviteInviteTableViewCell.h"

@implementation PriviteInviteTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.leftLabel];
        [self.contentView addSubview:self.rightLabel];
        [self updataFrame];
    }
    return self;
}


#pragma mark --- 懒加载 

- (UILabel *)leftLabel{
    if (!_leftLabel) {
        _leftLabel = [MyLabel initWithLabelFrame:CGRectZero Text:nil textColor:[UIColor blackColor] font:KweixinFont(14) textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:0];
    }
    return _leftLabel;
}

- (UILabel *)rightLabel{
    if (!_rightLabel) {
        _rightLabel = [MyLabel initWithLabelFrame:CGRectZero Text:nil textColor:[UIColor lightGrayColor] font:KweixinFont(14) textAlignment:NSTextAlignmentRight cornerRadius:0 masksToBounds:0];
    }
    return _rightLabel;
}


- (void)updataFrame{
    [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(0);
        make.left.equalTo(self.contentView).offset(10);
        make.bottom.equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(150);
    }];
    [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(0);
        make.right.equalTo(self.contentView).offset(-10);
        make.bottom.equalTo(self.contentView).offset(0);
        make.left.equalTo(_leftLabel.mas_right).offset(10);
    }];
}







- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
