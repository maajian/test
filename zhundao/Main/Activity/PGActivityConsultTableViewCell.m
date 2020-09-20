//
//  PGActivityConsultTableViewCell.m
//  zhundao
//
//  Created by zhundao on 2017/8/3.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PGActivityConsultTableViewCell.h"

@implementation PGActivityConsultTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(PGActivityConsultModel *)model
{
    if (model) {
        _model = model;
    }
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:_model.HeadImgurl]];
    self.nameLabel.text = _model.NickName;
    self.consultLabel.text = _model.Question;
    self.consultLabel.textColor = ZDHeaderTitleColor;
//    self.timeLabel
    if (_model.IsReply){
        self.statusLabel.text = @"已回复";
        self.statusLabel.textColor = [UIColor colorWithRed:59.f/255.f green:120.f/255.f blue:203/255.f alpha:1];
    }else{
         self.statusLabel.text = @"待回复";
        self.statusLabel.textColor = [UIColor colorWithRed:233.f/255.f green:97.f/255.f blue:111/255.f alpha:1];
    }
    self.consultLabel.numberOfLines = 0 ;
    self.consultLabel.text = _model.Question;
    self.timeLabel.text = _timeStr;
    if (_model.IsRecommend) {
         self.recommendLabel.text = @"已推荐";
        self.recommendLabel.textColor = ZDMainColor;
    }else{
        self.recommendLabel.text = @"未推荐";
        self.recommendLabel.textColor = [UIColor grayColor];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
