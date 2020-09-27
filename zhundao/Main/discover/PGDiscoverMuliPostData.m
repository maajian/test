#import "PGNatatoriumBasicInfo.h"
#import "PGDiscoverMuliPostData.h"
@interface PGDiscoverMuliPostData()
{
    NSMutableDictionary *postdic;
    JQIndicatorView  *indicator;
}
@end
@implementation PGDiscoverMuliPostData
- (void)postWithView :(UIView *)view isShow :(BOOL)isShow acckey:(NSString *)acckey
{
    if (isShow) {
        indicator = [[JQIndicatorView alloc]initWithType:2 tintColor: [UIColor colorWithRed:9.00f/255.0f green:187.00f/255.0f blue:7.00f/255.0f alpha:1] size:CGSizeMake(70, 70)];
        indicator.center = view.center;
        [view addSubview:indicator];
        [indicator startAnimating];
    }
    NSMutableArray  *postArray = [NSMutableArray array];
    PGSignManager *manager = [PGSignManager shareManager];
    [manager createDatabase];
    if ([manager.dataBase open]) {
        NSString *sql =@"SELECT * FROM muliSignList";
        FMResultSet * rs = [manager.dataBase executeQuery:sql];
        while ([rs next])
        {
            postdic = [NSMutableDictionary dictionary];
            if ([rs intForColumn:@"post"] ==0) {
                [postdic setValue:[rs stringForColumn:@"vcode"] forKey:@"VCode"];
                [postdic setValue:[NSString stringWithFormat:@"%i",[rs intForColumn:@"signID"]] forKey:@"checkInid"];
                [postdic setValue:[rs stringForColumn:@"addTime"] forKey:@"CheckInTime"];
                [postArray addObject:postdic];
            }
        }
        [manager.dataBase close];
    }
    if (postArray.count == 0) {
        if (_updataBlock) {
            _updataBlock(1);
        }
        return;
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:postArray options:0 error:nil];
    NSString *jsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"jsonStr = %@",jsonStr);
    NSString *postStr =[NSString stringWithFormat:@"%@api/CheckIn/BatchCheckIn?accessKey=%@&checkInWay=6",zhundaoApi,acckey];
    postStr = [postStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [ZD_NetWorkM postDataWithMethod:postStr parameters:@{@"checkJson": jsonStr} succ:^(NSDictionary *obj) {
        NSLog(@"responseObject = %@",obj);
        if (isShow) [indicator stopAnimating];
        NSDictionary *msg = [NSDictionary dictionaryWithDictionary:obj];
        if ([msg[@"Msg"]integerValue] ==0) {
            PGSignManager *manager = [PGSignManager shareManager];
            [manager createDatabase];
            if ([manager.dataBase open]) {
                [manager.dataBase executeUpdate:@"DROP TABLE muliSignList"];
                [manager.dataBase close];
            }
            if (_updataBlock) {
                _updataBlock(1);
            }
        }
    } fail:^(NSError *error) {
        NSLog(@"error = %@",error);
        if (isShow) [indicator stopAnimating];
        [[PGSignManager shareManager] showNotHaveNet:view];
    }];
}
@end
