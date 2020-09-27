#import "PGFieldEdeitingChanging.h"
#import "PGPostSignManager.h"
@interface PGPostSignManager()
{
    NSMutableDictionary *postdic;
}
@end
@implementation PGPostSignManager
- (void)postWithstr :(NSString *)str
{
        NSMutableArray  *postArray = [NSMutableArray array];
        PGSignManager *manager = [PGSignManager shareManager];
        [manager createDatabase];
        if ([manager.dataBase open]) {
            NSString *sql =[NSString stringWithFormat:@"SELECT * FROM '%@'",str];
            FMResultSet * rs = [manager.dataBase executeQuery:sql];
            while ([rs next])
            {
                postdic = [NSMutableDictionary dictionary];
                if ([rs intForColumn:@"post"] ==0) {
                    [postdic setValue:[rs stringForColumn:@"vcode"] forKey:@"VCode"];
                    [postdic setValue:[NSString stringWithFormat:@"%i",[rs intForColumn:@"signID"]] forKey:@"CheckInId"];
                    [postdic setValue:[rs stringForColumn:@"addTime"] forKey:@"CheckInTime"];
                    [postArray addObject:postdic];
                }
            }
            [manager.dataBase close];
        }
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:postArray options:0 error:nil];
        NSString *jsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSString *postStr =[NSString stringWithFormat:@"%@api/CheckIn/BatchCheckIn?accessKey=%@&checkInWay=6",zhundaoApi,[[PGSignManager shareManager]getaccseekey ]];
        postStr = [postStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [ZD_NetWorkM postDataWithMethod:postStr parameters:@{@"checkJson": jsonStr} succ:^(NSDictionary *obj) {
        NSLog(@"responseObject = %@",obj);
        NSDictionary *msg = [NSDictionary dictionaryWithDictionary:obj];
        if ([msg[@"Msg"]integerValue] ==0) {
            PGSignManager *manager = [PGSignManager shareManager];
            [manager createDatabase];
            if ([manager.dataBase open]) {
                [manager.dataBase executeUpdate:[NSString stringWithFormat:@"UPDATE '%@' SET  post = '1' where post ='0';",str]];
                [manager.dataBase close];
            }
        }
    } fail:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];
}
@end
