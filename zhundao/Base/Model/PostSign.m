//
//  PostSign.m
//  zhundao
//
//  Created by zhundao on 2017/3/10.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PostSign.h"
@interface PostSign()
{
    NSMutableDictionary *postdic;
}
@end
@implementation PostSign



- (void)postWithstr :(NSString *)str
{
        NSMutableArray  *postArray = [NSMutableArray array];
        SignManager *manager = [SignManager shareManager];
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
        NSString *postStr =[NSString stringWithFormat:@"%@api/CheckIn/BatchCheckIn?accessKey=%@&checkInWay=6",zhundaoApi,[[SignManager shareManager]getaccseekey ]];
        postStr = [postStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        AFmanager *afmanager = [AFmanager shareManager];
    
    [afmanager POST:postStr parameters:@{@"checkJson": jsonStr} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"responseObject = %@",responseObject);
            NSDictionary *msg = [NSDictionary dictionaryWithDictionary:responseObject];
            if ([msg[@"Msg"]integerValue] ==0) {
                SignManager *manager = [SignManager shareManager];
                [manager createDatabase];
                if ([manager.dataBase open]) {
                    [manager.dataBase executeUpdate:[NSString stringWithFormat:@"UPDATE '%@' SET  post = '1' where post ='0';",str]];
                    [manager.dataBase close];
                }
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error = %@",error);
        }];
        
        
        
        
   
}
@end
