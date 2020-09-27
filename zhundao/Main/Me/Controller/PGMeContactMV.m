#import "PGMeContactMV.h"
#import "NSString+ChangeToPinyin.h"
#import "PGMeContactModel.h"
@implementation PGMeContactMV
- (void)netWorkWithStr:(NSString *)str  
{
    NSDictionary *dic = @{
                          @"contactGroupID":@"-1",
                          @"curPage":@"1",
                          @"pageSize":@"10000"
                          };
    [ZD_NetWorkM postDataWithMethod:str parameters:dic succ:^(NSDictionary *obj) {
        NSDictionary *dictionary = [NSDictionary dictionaryWithDictionary:obj];
        NSArray *array =dictionary[@"Data"];
        NSMutableArray *dataarray = [array mutableCopy];
        @autoreleasepool {
            for (NSDictionary *dic in array) {
                if ([dic[@"TrueName"] isEqualToString:@""]) {
                    [dataarray removeObject:dic];
                }
            }
        }
        if (_block) {
            _block(dataarray);
        }
    } fail:^(NSError *error) {
    }];
}
- (void)netWorkGroupSave
{
    NSString *str = [NSString stringWithFormat:@"%@api/Contact/PostContactGroup?accessKey=%@",zhundaoApi,[[PGSignManager shareManager] getaccseekey]];
    [ZD_NetWorkM postDataWithMethod:str parameters:nil succ:^(NSDictionary *obj) {
        NSLog(@"responseObject = %@",obj);
        NSDictionary *dicionary = [NSDictionary dictionaryWithDictionary:obj];
        NSArray *dataArray = dicionary[@"Data"];
        NSMutableArray *array1 = [NSMutableArray array];
        NSMutableArray *array2 = [NSMutableArray array];
        for (NSDictionary *dic in dataArray) {
            [array1 addObject:dic[@"GroupName"]];
            [array2 addObject:dic[@"ID"]];
        }
        [[NSUserDefaults standardUserDefaults]setObject:array1 forKey:@"GroupName"];
        [[NSUserDefaults standardUserDefaults]setObject:array2 forKey:@"GroupID"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    } fail:^(NSError *error) {
    }];
}
-(NSDictionary *)getdicWithArray:(NSArray *)dataarray isHaveNet :(BOOL) isHave
{
    NSDate* Start = [NSDate date];
    NSMutableArray *array = [NSMutableArray array];  
    NSMutableArray *nameArray = [NSMutableArray array];
    NSMutableArray *pinyinArray = [NSMutableArray array];
    NSMutableArray *phoneArray = [NSMutableArray array];
    NSMutableArray *companyArray =[NSMutableArray array];
    NSMutableDictionary *backDic = [NSMutableDictionary dictionary]; 
    for (int i = 0 ;i<dataarray.count;i++) {
        NSDictionary *dic1 =[NSDictionary dictionaryWithDictionary:dataarray[i]];
        NSString *nameStr = dic1[@"TrueName"];
        [nameArray addObject:nameStr];
        [phoneArray addObject:dic1[@"Mobile"]];
        if (dic1[@"Company"]) {
            [companyArray addObject:dic1[@"Company"]];
        }
        NSString *pinyinStr = nil;
        pinyinStr = [[NSString alloc]changeToPinyinWithStr:nameStr]; 
        [pinyinArray addObject:pinyinStr];
        [array addObject:[[pinyinStr substringToIndex:1] uppercaseString]];  
    }
    if (_searchBlcok) _searchBlcok(nameArray,phoneArray,pinyinArray,companyArray);
    NSMutableArray*dataArray1 = [NSMutableArray array];
    for (NSDictionary *modeldic in dataarray) {
        PGMeContactModel *model = [PGMeContactModel yy_modelWithDictionary:modeldic];
        [dataArray1 addObject:model];
    }
    if (isHave) {
        if ([[PGSignManager shareManager].dataBase open]) {
            [self PG_insertSignListWithArray:dataArray1];
            [[PGSignManager shareManager].dataBase close];
        }
    }
    NSSet *set = [NSSet setWithArray:array];
    NSArray *array1 = [set allObjects];
    for (int i=0; i<array1.count; i++) {
        NSMutableArray *dicarray = [NSMutableArray array];
        for (int j=0; j<array.count; j++) {
            if ([array[j] isEqualToString:array1[i]]) {
                [dicarray addObject:dataArray1[j]];
            }
        }
        if (dicarray.count>0) {
            [backDic setObject:dicarray forKey:array1[i]];
        }
    }
    double deltaTime = [[NSDate date] timeIntervalSinceDate:Start];
    NSLog(@"time = %f", deltaTime);
    return backDic;
}
- (NSArray *)sortWithArray:(NSArray *)sortArray
{
    NSArray *resultArray = [sortArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    return resultArray;
}
- (void)createSignList
{
    PGSignManager *manager = [PGSignManager shareManager];
    [manager createDatabase];
    if ([manager.dataBase open]) {
        bool result = [manager.dataBase executeUpdate:@"CREATE TABLE IF NOT EXISTS contact(ID INTEGER PRIMARY KEY NOT NULL ,Sex INTEGER,HeadImgurl TEXT,GroupName TEXT,ContactGroupID INTEGER,TrueName TEXT NOT NULL,Address TEXT,Company TEXT,Duty TEXT,Email TEXT,Remark TEXT,SerialNo TEXT,IDcard TEXT,Mobile TEXT NOT NULL);"];
        if (result) {
            NSLog(@"成功创建table");
        }
        else
        {
            NSLog(@"创建table失败");
        }
        [manager.dataBase close];
    }
}
-(void)PG_insertSignListWithArray :(NSArray *)array1 {
    [[PGSignManager shareManager].dataBase beginTransaction];
    BOOL isRollBack = NO;
    @try {
        for (PGMeContactModel *model in array1) {
            NSString *insertSql =[NSString stringWithFormat:@"replace INTO contact(ID,GroupName,Sex, HeadImgurl,ContactGroupID,TrueName,Address,Company,Duty,Email,Remark,SerialNo,IDcard,Mobile)VALUES(%li,'%@',%li,'%@',%li,'%@','%@','%@','%@','%@','%@','%@','%@','%@')",(long)model.ID,model.GroupName,(long)model.Sex,model.HeadImgurl,(long)model.ContactGroupID,model.TrueName,model.Address,model.Company,model.Duty,model.Email,model.Remark,model.SerialNo,model.IDcard,model.Mobile];
            BOOL res = [[PGSignManager shareManager].dataBase executeUpdate:insertSql];
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
        [[PGSignManager shareManager].dataBase rollback];
    }
    @finally {
        if (!isRollBack) {
            [[PGSignManager shareManager].dataBase commit];
        }
    }
}
- (void)deleteDataWithModel :(NSInteger)personID
{
    PGSignManager *manager = [PGSignManager shareManager];
    if ([manager.dataBase open]) {
        NSString *insertSql =[NSString stringWithFormat:@"DELETE FROM contact WHERE ID = '%ld'",(long)personID];
        BOOL res = [manager.dataBase executeUpdate:insertSql];
        if (res) {
            NSLog(@"数据表插入成功");
        }
        else
        {
            NSLog(@"数据表插入失败");
        }
        [manager.dataBase close];
    }
}
- (void)deleteDataHaveNetWithStr:(NSString *)str
{
    [ZD_NetWorkM getDataWithMethod:str parameters:nil succ:^(NSDictionary *obj) {
        NSDictionary *dictionary = [NSDictionary dictionaryWithDictionary:obj];
        NSArray *dataarray =dictionary[@"Data"];
        NSLog(@"%@",dataarray);
    } fail:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];
}
- (NSArray *)searchDatabaseFromID:(NSInteger )ID
{
    PGSignManager *manager = [PGSignManager shareManager];
    NSMutableArray *allArray = [NSMutableArray array];
    NSMutableArray *firArray =[NSMutableArray array];
    if ([manager.dataBase open]) {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM contact WHERE ID = %li",(long)ID];
        FMResultSet *rs = [manager.dataBase executeQuery:sql];
        while ([rs next]) {
            [firArray addObject:[rs stringForColumn:@"TrueName"]];
             [firArray addObject:[rs stringForColumn:@"HeadImgurl"]];
            [firArray addObject:[NSString stringWithFormat:@"%d",[rs intForColumn:@"Sex"]]];
            [allArray addObject:firArray];
            [allArray addObject:[rs stringForColumn:@"Mobile"]];
            [allArray addObject:[rs stringForColumn:@"GroupName"]];
            [allArray addObject:[rs stringForColumn:@"Address"]];
            [allArray addObject:[rs stringForColumn:@"Company"]];
            [allArray addObject:[rs stringForColumn:@"Duty"]];
            [allArray addObject:[rs stringForColumn:@"IDcard"]];
            [allArray addObject:[rs stringForColumn:@"Email"]];
            [allArray addObject:[rs stringForColumn:@"SerialNo"]];
              [allArray addObject:[rs stringForColumn:@"Remark"]];
        }
        if ([[allArray objectAtIndex:2] isEqualToString:@"(null)"]) {
            [allArray replaceObjectAtIndex:2 withObject:@"未分组"];
        }
        [manager.dataBase close];
    }
    return allArray;
}
- (NSMutableArray *)searchAllData
{
    PGSignManager *manager = [PGSignManager shareManager];
    NSMutableArray *array = [NSMutableArray array];
    if ([manager.dataBase open]) {
        NSString *sql = @"SELECT * FROM contact";
        FMResultSet *rs = [manager.dataBase executeQuery:sql];
        while ([rs next]) {
             NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:[rs stringForColumn:@"TrueName"] forKey:@"TrueName"];
            [dic setObject:[NSString stringWithFormat:@"%li",(long)[rs intForColumn:@"ID"]] forKey:@"ID"];
            [dic setObject:[rs stringForColumn:@"HeadImgurl"] forKey:@"HeadImgurl"];
            [dic setObject:[rs stringForColumn:@"Mobile"] forKey:@"Mobile"];
            [dic setObject:[rs stringForColumn:@"Company"] forKey:@"Company"];
            [array addObject:dic];
        }
    }
    return  array;
}
@end
