//
//  ZDDiscoverFaceDetailCell.m
//  zhundao
//
//  Created by zhundao on 2017/7/27.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ZDDiscoverFaceDetailCell.h"

@implementation ZDDiscoverFaceDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.rightLabel];
    }
    return self;
}

- (void)setModel:(ZDDiscoverFaceModel *)model{
    if (model) {
        _model = model;
    }
    switch (self.tag) {
        case 0:
            _nameLabel.text = @"设备名称";
            _rightLabel.text = _model.Name;
            break;
        case 1:
            _nameLabel.text = @"设备编号";
            _rightLabel.text = _model.deviceKey;
            break;
        case 2:
            _nameLabel.text = @"支持人数";
            _rightLabel.text = [NSString stringWithFormat:@"%li",(long)_model.stock];
            break;
        case 3:
            _nameLabel.text = @"绑定签到";
            _rightLabel.text = _model.checkInName;
;
            break;
        default:
            break;
    }
    
}


#pragma mark ----懒加载
- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 44)];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLabel;
}
- (UILabel *)rightLabel{
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 0, kScreenWidth-120 , 44)];
        _rightLabel.font = [UIFont systemFontOfSize:14];
        _rightLabel.textAlignment = NSTextAlignmentRight;
    }
    return _rightLabel;
}
#pragma mark ----设置大小


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
