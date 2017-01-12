//
//  signinTableViewCell.m
//  zhundao
//
//  Created by zhundao on 2016/12/9.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import "signinTableViewCell.h"
#import "Time.h"
@implementation signinTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setModel:(signinModel *)model
{
    if (model) {
        _model = model;
    }
    _titleLabel.text = _model.ActivityName;
    if (_model.CheckInType==0) {
        _tpyeLabel.text = @"【到场签到】";
    }
    else if (_model.CheckInType==1)
    {
        _tpyeLabel.text = @"【离场签退】";
    }
    else
    {
        _tpyeLabel.text =@"【集合签到】";
    }
    
     
    _signobjectLabel.text =[NSString stringWithFormat: @"报名用户:%li",(long)_model.NumShould];
    [_signcountLabel setTitle:[NSString stringWithFormat:@"已签到: %li  查看",(long)_model.NumFact] forState:UIControlStateNormal];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
