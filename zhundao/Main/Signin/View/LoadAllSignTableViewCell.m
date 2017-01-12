//
//  LoadAllSignTableViewCell.m
//  zhundao
//
//  Created by zhundao on 2016/12/20.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import "LoadAllSignTableViewCell.h"
#import "Time.h"
@implementation LoadAllSignTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
 -(void)setModel:(LoadallsignModel *)model
{
    if (model) {
        _model=model;
    }
    _phoneLabel.text =_model.Mobile;
    if (![model.SignTime isEqualToString:@""]) {
        Time *time = [Time bringWithTime:_model.SignTime];
        _timeLabel.text = time.timeStr ;

    }
  
    _nameLabel.text = _model.TrueName;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
