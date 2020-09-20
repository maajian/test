//
//  PGSignInLoadAllSignCell.m
//  zhundao
//
//  Created by zhundao on 2016/12/20.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import "PGSignInLoadAllSignCell.h"
#import "Time.h"
#import "PGSignInLoadAllSignVC.h"
#import "PGSignResult.h"
@interface PGSignInLoadAllSignCell()
{
   
  
}
@end
@implementation PGSignInLoadAllSignCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
 -(void)setModel:(PGSignInLoadallsignModel *)model
{
    
    if (model) {
        _model=model;
    }
    _phoneLabel.text =_model.Mobile;
    if (_model.Status==1) {
        if (![_model.SignTime isEqualToString:@""]) {
            
            Time *time = [Time bringWithTime:_model.SignTime];
            _timeLabel.text = time.timeStr ;
            _timeLabel.textColor =[UIColor lightGrayColor];
            _timeLabel.layer.borderWidth = 0;
        }
     if ([_model.SignTime isEqualToString:@""]) {
         NSDate *currentDate = [NSDate date];
         NSDateFormatter *date = [[NSDateFormatter alloc]init];
        [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
         NSString *timestr = [date stringFromDate:currentDate];
         Time *time = [Time bringWithTime:timestr];
         _timeLabel.text = time.timeStr ;
         _timeLabel.textColor =[UIColor lightGrayColor];
         _timeLabel.layer.borderWidth = 0;
     }
    }
       if (_model.Status==0)
        {
            
            _timeLabel.text =@" 管理员代签  ";
            _timeLabel.textAlignment = NSTextAlignmentCenter;
            _timeLabel.textColor =[UIColor blackColor];
            _timeLabel.layer.borderColor = ZDGrayColor.CGColor;
            _timeLabel.layer.borderWidth = 1;
        }


    _nameLabel.text = _model.TrueName;
}


//
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
@end
