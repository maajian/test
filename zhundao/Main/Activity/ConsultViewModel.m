//
//  ConsultViewModel.m
//  zhundao
//
//  Created by zhundao on 2017/8/3.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ConsultViewModel.h"
#import "ConsultModel.h"
#import "Time.h"
@implementation ConsultViewModel

/*! 获取回复列表 */
//POST api/PerBase/PstConsultList?accessKey={accessKey}

/*! 回复留言 */
//POST api/PerBase/ReplyConsult/{id}?accessKey={accessKey}&answer={answer}&IsRecommend={IsRecommend}

/*! 删除活动资讯 */
//GET api/PerBase/DeleteConsult/{id}?accessKey={accessKey}


- (void)getAllConsult :(NSDictionary *)dic  getAllBlock:(getAllBlock)getAllBlock
{
    NSString *url = [NSString stringWithFormat:@"%@api/PerBase/PstConsultList?accessKey=%@",zhundaoApi,[[SignManager shareManager] getaccseekey]];
    NSMutableArray *muarray = [NSMutableArray array];
    NSMutableArray *timeArray = [NSMutableArray array];
    NSMutableArray *hadArray = [NSMutableArray array];
    NSMutableArray *notArray = [NSMutableArray array];
    __weak typeof(self) weakSelf = self;
    [ZD_NetWorkM postDataWithMethod:url parameters:dic succ:^(NSDictionary *obj) {
        NSLog(@"responseObject = %@",obj);
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:obj];
        NSArray *array = dic[@"Data"];
        for (NSDictionary *datadic  in array) {
            ConsultModel *model = [ConsultModel yy_modelWithJSON:datadic];
            [muarray addObject:model];
            if (model.IsReply) [hadArray addObject:model];
            else [notArray addObject:model];
            [timeArray addObject:[weakSelf getTime:model.AddTime]];
        }
        getAllBlock(muarray,timeArray,notArray,hadArray);
    } fail:^(NSError *error) {
        
    }];
}




/*! 获取高度数组 */
- (NSArray *)getHeight:(NSArray *)array
{
    NSMutableArray *heightArray = [NSMutableArray array];
    for (ConsultModel *model in array) {
        NSString *str = model.Question;
        CGSize size = [str boundingRectWithSize:CGSizeMake(0.85*kScreenWidth-88, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15]} context:nil].size;
        [heightArray addObject:@(size.height)];
    }
    return heightArray;
}



/*! 获取时间 */
- (NSString *)getTime:(NSString *)timeStr
{
    Time *time = [Time bringWithTime:timeStr];
    NSDateFormatter *dateFormatter= [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
    NSDate *postDate = [dateFormatter dateFromString:time.timeStr];
    NSDate *nowDate = [NSDate date];
    NSTimeInterval postInterval = [postDate timeIntervalSince1970];
    NSTimeInterval nowInterval = [nowDate timeIntervalSince1970];
    NSTimeInterval value = nowInterval -postInterval;
    int minute = (int)value /60%60;
    int hour = (int)value / (3600)%24;
    int day1 = (int)value / (24 * 3600)%30;
    int month = (int)value / (24 * 3600*30)%12;
    int year = (int)value / (24 * 3600*30*12);
    if (year) {
        return [NSString stringWithFormat:@"%d年前",year];
    }else if (month){
        return [NSString stringWithFormat:@"%d月前",month];
    }else if (day1)
    {
        return [NSString stringWithFormat:@"%d天前",day1];
    }else if (hour){
        return [NSString stringWithFormat:@"%d小时前",hour];
    }else{
        return [NSString stringWithFormat:@"%d分钟前",minute];
    }
}
@end
