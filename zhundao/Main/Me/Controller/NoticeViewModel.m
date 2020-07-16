//
//  NoticeViewModel.m
//  zhundao
//
//  Created by zhundao on 2017/8/15.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "NoticeViewModel.h"
#import "Time.h"
@implementation NoticeViewModel

 // 获取通知列表
- (void)netWorkWithPage:(NSInteger)page Block :(allBlock)allBlock{
    NSString *str = [NSString stringWithFormat:@"%@api/ZDInfo/GetNoticeList",zhundaoApi];
    NSDictionary *postDic = @{@"pageSize" : @"10",
                          @"curPage"  : [NSString stringWithFormat:@"%li",page]};
    [ZD_NetWorkM postDataWithMethod:str parameters:postDic succ:^(NSDictionary *obj) {
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:obj];
        allBlock(dic[@"Data"]);
    } fail:^(NSError *error) {
        
    }];
}

 // 获取通知详情
- (void)getNoticeDetail:(NSInteger)ID successBlock:(kZDCommonSucc)successBlock failBlock:(kZDCommonFail)failBlock {
    NSString *str = [NSString stringWithFormat:@"%@api/ZDInfo/GetNoticeDetail?id=%li",zhundaoApi,ID];
    [ZD_NetWorkM getDataWithMethod:str parameters:nil succ:^(NSDictionary *obj) {
        _noticeModel = [NoticeModel yy_modelWithJSON:obj[@"Data"]];
        successBlock();
    } fail:^(NSError *error) {
        failBlock(error.description);
    }];
}

- (void)savaData:(NSArray *)array {
    ZDDBManager *manager = [ZDDBManager shareManager];
    [manager createDatabase];
    [manager createTable:[NSString stringWithFormat:@"create table if not exists noticeList( ID integer primary key , AddTime text , Detail text ,SortName text ,Title text ,isShow bool default false)"]];
    if ([manager.dataBase open]) {
                [manager.dataBase beginTransaction];
                BOOL isRollBack = NO;
                @try {
                    for (NoticeModel *model in array) {
                        NSString *insertSql = [NSString stringWithFormat:@"replace into noticeList(ID,AddTime,Detail,SortName,Title)values(%li,'%@','%@','%@','%@')",(long)model.ID,model.AddTime,model.Detail,model.SortName,model.Title];
                        BOOL res = [manager.dataBase executeUpdate:insertSql];
                        if (res) {
                            NSLog(@"数据表插入成功");
                        }
                        else
                        {
                            NSLog(@"数据表插入失败");
                        }
                    }
                }
                @catch (NSException *exception) {
                    isRollBack = YES;
                    // 事务回退
                    [manager.dataBase rollback];
                }
                @finally {
                    if (!isRollBack) {
                        //事务提交
                        [manager.dataBase commit];
                    }
                }
                [manager.dataBase close];
            }
}

- (void)sava :(NSArray *)array{
    /*! 创建plist  */
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"notice.plist"];
    NSLog(@"path = %@",path);
    NSFileManager *fm = [NSFileManager defaultManager];
    [fm createFileAtPath:path contents:nil attributes:nil];
    /*! 保存数据进plist */
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:array];
  BOOL isSuccess =   [data writeToFile:path atomically:YES];
    if (isSuccess) NSLog(@"保存成功");
     else NSLog(@"保存失败");
    
}

- (void)removeData {
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"notice.plist"];
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:path]) {
        [fm removeItemAtPath:path error:nil];
    }
}

- (NSArray *)getData {
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"notice.plist"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return array;
}

- (void)signIsReadWithID :(NSInteger)ID{
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"noticeState"]) {
        NSMutableArray *array = [[[NSUserDefaults standardUserDefaults]objectForKey:@"noticeState"] mutableCopy];
        if ([array containsObject:@(ID)]) {
            return;
        }else{
            [self savaState:array ID:ID];
        }
    }else{
        NSMutableArray *array = [NSMutableArray array];
        [self savaState:array ID:ID];
    }

}
- (void)savaState :(NSMutableArray *)savaArray ID :(NSInteger)ID{
    [savaArray addObject:@(ID)];
    [[NSUserDefaults standardUserDefaults]setObject:savaArray forKey:@"noticeState"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (void)saveTime :(NoticeModel *)model{
    Time *time = [Time bringWithTime:model.AddTime];
    [[NSUserDefaults standardUserDefaults]setObject:time.timeStr forKey:@"noticeTime"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}



@end
