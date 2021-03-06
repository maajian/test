//
//  GroupMV.m
//  zhundao
//
//  Created by zhundao on 2017/5/24.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "GroupMV.h"

@implementation GroupMV
//api/Contact/PostContactGroup?accessKey={accessKey} //获取分组

//api/Contact/GetSingleContactGroup/{id}?accessKey={accessKey} 获取组里面的信息
- (void)netWorkWithStr :(NSString *)str
{
    [ZD_NetWorkM postDataWithMethod:str parameters:nil succ:^(NSDictionary *obj) {
        NSLog(@"responseObject = %@",obj);
        NSDictionary *dicionary = [NSDictionary dictionaryWithDictionary:obj];
        NSArray *dataArray = dicionary[@"Data"];
        if (_block) {
            _block(dataArray);
        }
    } fail:^(NSError *error) {
        
    }];
}

- (NSArray *)searchDatabaseFromID:(NSInteger )ID
{
    SignManager *manager = [SignManager shareManager];
    NSMutableArray *allArray = [NSMutableArray array];
    NSMutableArray *nameArray = [NSMutableArray array];
    NSMutableArray *imageArray = [NSMutableArray array];
    NSMutableArray *mobileArray = [NSMutableArray array];
    NSMutableArray *idArray = [NSMutableArray array];
    if ([manager.dataBase open]) {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM contact WHERE ContactGroupID = %li",(long)ID];
        FMResultSet *rs = [manager.dataBase executeQuery:sql];
        while ([rs next]) {
            [nameArray addObject:[rs stringForColumn:@"TrueName"]];
            [imageArray addObject:[rs stringForColumn:@"HeadImgurl"]];
            [mobileArray addObject:[rs stringForColumn:@"Mobile"]];
            [idArray addObject:[NSString stringWithFormat:@"%li",(long)[rs intForColumn:@"ID"]]];
        }
        
        [manager.dataBase close];
    }
    [allArray addObject:nameArray];
    [allArray addObject:imageArray];
    [allArray addObject:idArray];
    [allArray addObject:mobileArray];
    
    return allArray;
}
- (void)addPersonToGroupWithDic :(NSDictionary *)dic
{
    NSString *netstr = [NSString stringWithFormat:@"%@api/Contact/UpdateOrAddContact?accessKey=%@",zhundaoApi,[[SignManager shareManager] getaccseekey]];
    [ZD_NetWorkM postDataWithMethod:netstr parameters:dic succ:^(NSDictionary *obj) {
        NSLog(@"responseObject = %@",obj);
        NSDictionary *dicionary = [NSDictionary dictionaryWithDictionary:obj];
        
        if ([dicionary[@"Res"] integerValue] ==0) {
            if (_addPersonBlock) {
                _addPersonBlock(1);
            }
        }
    } fail:^(NSError *error) {
        NSLog(@"error = %@",error);
        if (_addPersonBlock) {
            _addPersonBlock(0);
        }
    }];
}
- (void)searchDatabaseFromID:(NSInteger )groupID GroupName :(NSString *)GroupName  ID:(NSInteger )ID
{
    SignManager *manager = [SignManager shareManager];
    if ([manager.dataBase open]) {
        NSString *sql = [NSString stringWithFormat:@"UPDATE contact SET ContactGroupID = %li WHERE ID = %li",(long)groupID,(long)ID];
         NSString *sql1 = [NSString stringWithFormat:@"UPDATE contact SET GroupName = '%@' WHERE ID = %li",GroupName,(long)ID];
        BOOL res = [manager.dataBase executeUpdate:sql];
        [manager.dataBase executeUpdate:sql1];
        if (res) {
            NSLog(@"数据表更新成功");
        }
        else
        {
            NSLog(@"数据表插入失败");
        }
        [manager.dataBase close];
    }


}
@end
