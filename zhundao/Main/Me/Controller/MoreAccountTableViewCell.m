//
//  MoreAccountTableViewCell.m
//  zhundao
//
//  Created by xhkj on 2018/1/23.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import "MoreAccountTableViewCell.h"

@implementation MoreAccountTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.tintColor = ZDGreenColor;
        [self setupUI];
    }
    return self;
}

#pragma mark --- ui添加
- (void)setupUI {
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 5, 60, 60)];
    _iconImageView.layer.cornerRadius = 30;
    _iconImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:_iconImageView];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(95, 10, kScreenWidth - 95, 25)];
    _nameLabel.font = [UIFont boldSystemFontOfSize:14];
    _nameLabel.textColor = kColorA(51, 51, 51, 1);
    [self.contentView addSubview:_nameLabel];
    
    _phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(95, CGRectGetMaxY(_nameLabel.frame), kScreenWidth - 95, 25)];
    _phoneLabel.font = [UIFont boldSystemFontOfSize:14];
    _phoneLabel.textColor = kColorA(153, 153, 153, 1);
    [self.contentView addSubview:_phoneLabel];
}

#pragma mark --- 数据设置
- (void)setModel:(MoreAccountModel *)model {
    _phoneLabel.text = model.phone;
    _nameLabel.text = model.name;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:model.headImgurl] placeholderImage:[UIImage imageNamed:@"user.png"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
