//
//  PGActivityListCell.m
//  zhundao
//
//  Created by zhundao on 2016/12/15.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import "PGActivityListCell.h"
@interface PGActivityListCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *departLabel;

@end
@implementation PGActivityListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIView *selectedBg = [[UIView alloc] initWithFrame:self.frame];
    selectedBg.backgroundColor =[UIColor clearColor];
    self.selectedBackgroundView = selectedBg;
    self.tintColor = ZDMainColor;
    // Initialization code
}
-(void)setModel:(PGActivityListModel *)model
{
    if (model) {
        _model = model;
    }
    if (_model.NickName==nil) {
        _titleLabel.text =[NSString stringWithFormat:@"%@",_model.UserName];
    }else{
         _titleLabel.text =[NSString stringWithFormat:@"%@(%@)",_model.UserName,_model.NickName];
    }
    _phoneLabel.text = _model.Mobile;
    _timeLabel.text = _model.AddTime;
    _departLabel.text = [NSString stringWithFormat:@"所属组织: %@", _model.DepartName.length ? _model.DepartName : @"无"];
    _timeLabel.textColor = _departLabel.textColor = ZDGreyColor999;
   _successLabel.layer.borderColor = [[UIColor colorWithRed:141.00f/255.0f green:189.00f/255.0f blue:38.00f/255.0f alpha:1] CGColor];
   _successLabel.layer.borderWidth = 1;
    _successLabel.layer.cornerRadius = 5;
    _successLabel.layer.masksToBounds = YES;
    if (_model.Status==0) {
        _successLabel.text = @"报名成功";
    }
    else if(_model.Status==1)
    {
        _successLabel.text = @"未付款";
    }else if(_model.Status == 2){
        _successLabel.text = @"待审核";
    } else {
        _successLabel.text = @"未通过";
    }
    [self.contentView addLineViewAtBottom];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
  
    // Configure the view for the selected state
}

@end
