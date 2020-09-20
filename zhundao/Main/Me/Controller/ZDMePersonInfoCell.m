//
//  ZDMePersonInfoCell.m
//  zhundao
//
//  Created by zhundao on 2017/11/1.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ZDMePersonInfoCell.h"

@implementation ZDMePersonInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.leftLabel];
        [self.contentView addSubview:self.rightLabel];
        [self updataFrame];
        _rightLabel.text = @"sssadsds";
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

-(UILabel *)leftLabel{
    if (!_leftLabel) {
        _leftLabel = [MyLabel initWithLabelFrame:CGRectMake(10, 0, 40, 44) Text:@"姓名" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:0];
    }
    return _leftLabel;
}

- (UILabel *)rightLabel{
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc]init];
        _rightLabel.textColor = kColorA(120, 120, 120, 1);
        _rightLabel.font = [UIFont systemFontOfSize:14];
        _rightLabel.textAlignment = NSTextAlignmentRight;
    }
    return _rightLabel;
}

- (void)updataFrame{
    [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.contentView).offset(5);
        make.bottom.equalTo(self.contentView).offset(-5);
        make.left.equalTo(self.leftLabel.mas_right).offset(0);
    }];
}

#pragma mark --- 存取器

- (void)setCellTag:(NSInteger)cellTag{
    _cellTag = cellTag;
    _leftLabel.text = _leftArray[cellTag];
    switch (cellTag) {
        case 1:
        {
            if (![_model.trueName isEqualToString:@""]){
              _rightLabel.text =  _model.trueName;
                self.accessoryType = UITableViewCellAccessoryNone;
                [_rightLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                     make.right.equalTo(self.contentView).offset(-15);
                }];
                self.userInteractionEnabled = NO;
            }else{
              _rightLabel.text = @"未填写";
            }
       
        }
            break;
        case 2:
        {
            if (![_model.nickName isEqualToString:@""]) _rightLabel.text =  _model.nickName;
            else _rightLabel.text = @"未填写";
        }
            break;
        case 3:
        {
            if (_model.phone) {
                _rightLabel.text =  _model.phone;
            }
            else{
                _rightLabel.text = @"未填写";
            }
            self.accessoryType = UITableViewCellAccessoryNone;
            [_rightLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.contentView).offset(-15);
            }];
            self.userInteractionEnabled = NO;
        }
            break;
        case 4:
        {
            if (![_model.email isEqualToString:@""]) _rightLabel.text =  _model.email;
            else _rightLabel.text = @"未填写";
        }
            break;
        case 5:
        {
            if (_model.Sex ==1) _rightLabel.text =  @"男";
            else _rightLabel.text = @"女";
        }
            break;
        case 6:
        {
            if (![_model.company isEqualToString:@""]) _rightLabel.text =  _model.company;
            else _rightLabel.text = @"未填写";
        }
            break;
        case 7:
        {
            if (![_model.industry isEqualToString:@""]) _rightLabel.text =  _model.industry;
            else _rightLabel.text = @"未填写";
        }
            break;
        case 8:
        {
            if (![_model.duty isEqualToString:@""]) _rightLabel.text =  _model.duty;
            else _rightLabel.text = @"未填写";
        }
            break;
        default:
            break;
    }
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
