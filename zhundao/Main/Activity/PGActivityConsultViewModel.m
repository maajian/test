#import "PGActivityConsultViewModel.h"
#import "PGActivityConsultModel.h"
#import "Time.h"
@implementation PGActivityConsultViewModel
- (void)getAllConsult :(NSDictionary *)dic  getAllBlock:(getAllBlock)getAllBlock
{
    NSString *url = [NSString stringWithFormat:@"%@api/PerBase/PstConsultList?accessKey=%@",zhundaoApi,[[PGSignManager shareManager] getaccseekey]];
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
            PGActivityConsultModel *model = [PGActivityConsultModel yy_modelWithJSON:datadic];
            [muarray addObject:model];
            if (model.IsReply) [hadArray addObject:model];
            else [notArray addObject:model];
            [timeArray addObject:[weakSelf getTime:model.AddTime]];
        }
        getAllBlock(muarray,timeArray,notArray,hadArray);
    } fail:^(NSError *error) {
    }];
}
- (NSArray *)getHeight:(NSArray *)array
{
    NSMutableArray *heightArray = [NSMutableArray array];
    for (PGActivityConsultModel *model in array) {
        NSString *str = model.Question;
        CGSize size = [str boundingRectWithSize:CGSizeMake(0.85*kScreenWidth-88, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15]} context:nil].size;
        [heightArray addObject:@(size.height)];
    }
    return heightArray;
}
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
