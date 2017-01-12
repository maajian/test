//
//  ActivityCell.m
//  zhundao
//
//  Created by zhundao on 2016/12/6.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import "ActivityCell.h"
#import "ShareView.h"
#import "TYAlertController+BlurEffects.h"
#import "UIView+TYAlertView.h"
#import "Time.h"
@interface ActivityCell()
{
    ActivityCell *mycell;
}
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *enrollCount;
@property (weak, nonatomic) IBOutlet UILabel *incomeLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *beginTimeLabel;


@end
@implementation ActivityCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



- (void)setModel:(ActivityModel *)model
{
    if (model) {
        _model = model ;
    }

    _titleLabel.text = _model.Title;
    _enrollCount.text = [NSString stringWithFormat:@"报名人数:%li",(long)_model.HasJoinNum];
    _incomeLabel.text = [NSString stringWithFormat:@"收入:%.2f",_model.Amount];
    [_userImageView sd_setImageWithURL:[NSURL URLWithString:_model.ShareImgurl] placeholderImage:[UIImage imageNamed:@"logogray"]];
    NSDate *currentdate = [NSDate date];
    
    //TimeStop = "2016-12-07T18:15:00";
    if (_model.TimeStop!=nil ) {
        
        Time *time1  = [Time bringWithTime:_model.TimeStop];
        NSArray *onlyarr = [time1.timeStr componentsSeparatedByString:@"-"];
        NSString *str4 = [onlyarr objectAtIndex:1];
        NSString *str5 = [onlyarr objectAtIndex:2];
        NSString *str6 = [str4 stringByAppendingString:@"-"];
        
        NSString  *endstr = [str6 stringByAppendingString:str5];
        
        
        NSDateFormatter *date = [[NSDateFormatter alloc]init];
        [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        //        NSDate *startD =[date dateFromString:currentDateStr1];
        NSString *sss = [time1.timeStr stringByAppendingString:@":00"];
        NSDate *endD = [date dateFromString:sss];
        
        NSTimeInterval start = [currentdate timeIntervalSince1970]*1;
        NSTimeInterval end = [endD timeIntervalSince1970]*1;
        NSTimeInterval value = end - start;
        int minute = (int)value /60%60;
     
        int house = (int)value / (3600)%24;

        int day1 = (int)value / (24 * 3600);
    

        if (day1>=1) {
            _beginTimeLabel.text = [NSString stringWithFormat:@"活动截止: %@(剩%d天%d小时)",endstr,day1,house];
        }
        if (day1==0&&house>=1) {
            _beginTimeLabel.text = [NSString stringWithFormat:@"活动截止: %@(剩%d小时%d分)",endstr,house,minute];
        }
        if (day1==0&&house==0&&minute>=0) {
            _beginTimeLabel.text = [NSString stringWithFormat:@"活动截止: %@(剩%d分)",endstr,minute];
        }
        if (minute<0)
        {
            _beginTimeLabel.text = [NSString stringWithFormat:@"%@(截止)",endstr];
        }
    }
    if (_model.TimeStart!=nil ) {
        
        Time *time1  = [Time bringWithTime:_model.TimeStart];
        NSArray *onlyarr = [time1.timeStr componentsSeparatedByString:@"-"];
        NSString *str4 = [onlyarr objectAtIndex:1];
        NSString *str5 = [onlyarr objectAtIndex:2];
        NSString *str6 = [str4 stringByAppendingString:@"-"];
        
       NSString  *endstr = [str6 stringByAppendingString:str5];
        
        
        NSDateFormatter *date = [[NSDateFormatter alloc]init];
        [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *sss = [time1.timeStr stringByAppendingString:@":00"];
        NSDate *endD = [date dateFromString:sss];
        
        NSTimeInterval start = [currentdate timeIntervalSince1970]*1;
        NSTimeInterval end = [endD timeIntervalSince1970]*1;
        NSTimeInterval value = end - start;
        int minute = (int)value /60%60;
        int house = (int)value / (3600)%24;
        int day1 = (int)value / (24 * 3600);
   
        
        
        
        if (day1>=1) {
            _timeLabel.text = [NSString stringWithFormat:@"活动开始: %@(剩%d天%d小时)",endstr,day1,house];
        }
        if (day1==0&&house>=1) {
            _timeLabel.text = [NSString stringWithFormat:@"活动开始: %@(剩%d小时%d分)",endstr,house,minute];
        }
        if (day1==0&&house==0&&minute>=0) {
            _timeLabel.text = [NSString stringWithFormat:@"活动开始: %@(剩%d分)",endstr,minute];
        }
        if (minute<0)
        {
            _timeLabel.text = [NSString stringWithFormat:@"%@(活动正在进行或已结束)",endstr];
        }
    }
 

    
    
}

// -------------------懒加载视图--------------------











- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
