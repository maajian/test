//
//  ActivityCell.m
//  zhundao
//
//  Created by zhundao on 2016/12/6.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import "ActivityCell.h"
#import "Time.h"
@interface ActivityCell() {
    ActivityCell *mycell;
}
@property (weak, nonatomic) IBOutlet UILabel *enrollCount;
@property (weak, nonatomic) IBOutlet UILabel *incomeLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *beginTimeLabel;
@property (weak, nonatomic) IBOutlet UIView *shareView;
@property (weak, nonatomic) IBOutlet UIView *ListView;
@property(nonatomic,strong)NSDateFormatter *date;
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
    
    if (_model.UserLimit==0) {
        _enrollCount.text = [NSString stringWithFormat:@"报名人数:%li/不限",(long)_model.HasJoinNum];
    }
    else{
        _enrollCount.text = [NSString stringWithFormat:@"报名人数:%li/%li",(long)_model.HasJoinNum,(long)_model.UserLimit];
    }
    if (_model.Fee) {
         _incomeLabel.hidden = NO;
        _incomeLabel.text = [NSString stringWithFormat:@"线上收入:%.2f",_model.Amount];
    }else{
        _incomeLabel.hidden = YES;
    }
    
    [_userImageView sd_setImageWithURL:[NSURL URLWithString:_model.ShareImgurl] placeholderImage:[UIImage imageNamed:@"logogray"]];
    [_userImageView setContentMode:UIViewContentModeScaleAspectFill];
    _userImageView.clipsToBounds = YES;
    NSDate *currentdate = [NSDate date];
    //TimeStop = "2016-12-07T18:15:00";
    if (_model.TimeStop!=nil ) {
        Time *time1  = [Time bringWithTime:_model.TimeStop];
        NSArray *onlyarr = [time1.timeStr componentsSeparatedByString:@"-"];
        NSString *str4 = [onlyarr objectAtIndex:1];
        NSString *str5 = [onlyarr objectAtIndex:2];
        NSString *str6 = [str4 stringByAppendingString:@"-"];
        
        NSString  *endstr = [str6 stringByAppendingString:str5];
        
        //        NSDate *startD =[date dateFromString:currentDateStr1];
        NSString *sss = [time1.timeStr stringByAppendingString:@":00"];
        NSDate *endD = [self.date dateFromString:sss];
        
        NSTimeInterval start = [currentdate timeIntervalSince1970]*1;
        NSTimeInterval end = [endD timeIntervalSince1970]*1;
        NSTimeInterval value = end - start;
        int minute = (int)value /60%60;
        int house = (int)value / (3600)%24;

        int day1 = (int)value / (24 * 3600);
        
        if (day1>=1) {
            _timeLabel.text = [NSString stringWithFormat:@"报名截止: %@(剩%d天%d小时)",endstr,day1,house];
        }
        if (day1==0&&house>=1) {
            _timeLabel.text = [NSString stringWithFormat:@"报名截止: %@(剩%d小时%d分)",endstr,house,minute];
        }
        if (day1==0&&house==0&&minute>=0) {
            _timeLabel.text = [NSString stringWithFormat:@"报名截止: %@(剩%d分)",endstr,minute];
        }
        if (minute<0)
        {
            _timeLabel.text = [NSString stringWithFormat:@"报名截止: %@",endstr];
        }
    }
    if (_model.TimeStart!=nil ) {
        Time *time1  = [Time bringWithTime:_model.TimeStart];
        NSArray *onlyarr = [time1.timeStr componentsSeparatedByString:@"-"];
        NSString *str4 = [onlyarr objectAtIndex:1];
        NSString *str5 = [onlyarr objectAtIndex:2];
        NSString *str6 = [str4 stringByAppendingString:@"-"];
        
       NSString  *endstr = [str6 stringByAppendingString:str5];
        NSString *sss = [time1.timeStr stringByAppendingString:@":00"];
        NSDate *endD = [self.date dateFromString:sss];
        
        NSTimeInterval start = [currentdate timeIntervalSince1970]*1;
        NSTimeInterval end = [endD timeIntervalSince1970]*1;
        NSTimeInterval value = end - start;
        int minute = (int)value /60%60;
        int house = (int)value / (3600)%24;
        int day1 = (int)value / (24 * 3600);
        
        if (day1>=1) {
            _beginTimeLabel.text = [NSString stringWithFormat:@"活动开始: %@(剩%d天%d小时)",endstr,day1,house];
        }
        if (day1==0&&house>=1) {
            _beginTimeLabel.text = [NSString stringWithFormat:@"活动开始: %@(剩%d小时%d分)",endstr,house,minute];
        }
        if (day1==0&&house==0&&minute>=0) {
            _beginTimeLabel.text = [NSString stringWithFormat:@"活动开始: %@(剩%d分)",endstr,minute];
        }
        if (minute<0)
        {
            _beginTimeLabel.text = [NSString stringWithFormat:@"活动开始: %@",endstr];
        }
    }
    for (CALayer *layer in self.ListView.layer.sublayers) {
        if ([layer isKindOfClass:[CAShapeLayer class]]) {
            [layer removeFromSuperlayer];
        }
    }
    if ([self isShowRed]) {
        [self createShape];
    }
}

- (void)createShape {
    CAShapeLayer *shape = [CAShapeLayer layer];
    float y = 4 ;
    CGRect rect = CGRectMake(kScreenWidth/8 +6 , y, 8, 8);
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:rect];
    shape.path = bezierPath.CGPath;
    shape.fillColor = kColorA(238, 28, 38, 1).CGColor;
    [self.ListView.layer addSublayer:shape];
    
}

- (BOOL)isShowRed{
    NSArray *array1 = [[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"%li",(long)_model.ID]];
    if (_model.HasJoinNum!=array1.count&&_model.HasJoinNum!=0) {
        return YES;
    }else{
        return NO;
    }
}

- (NSDateFormatter *)date {
    if (!_date) {
        _date = [[NSDateFormatter alloc]init];
        [_date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    return _date;
}


#pragma mark --- action







- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
