#import "PGMePersonMV.h"
@implementation PGMePersonMV
- (NSArray *)searchDatabaseFromID:(NSInteger )ID
{
    PGSignManager *manager = [PGSignManager shareManager];
    NSMutableArray *allArray = [NSMutableArray array];
    if ([manager.dataBase open]) {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM contact WHERE ID = %li",(long)ID];
        FMResultSet *rs = [manager.dataBase executeQuery:sql];
        while ([rs next]) {
            [allArray addObject:[rs stringForColumn:@"TrueName"]];
            [allArray addObject:[rs stringForColumn:@"Mobile"]];
            [allArray addObject:[rs stringForColumn:@"HeadImgurl"]];
            [allArray addObject:[NSString stringWithFormat:@"%d",[rs intForColumn:@"Sex"]]];
            [allArray addObject:[rs stringForColumn:@"GroupName"]];
            [allArray addObject:[rs stringForColumn:@"Address"]];
            [allArray addObject:[rs stringForColumn:@"Company"]];
            [allArray addObject:[rs stringForColumn:@"Duty"]];
            [allArray addObject:[rs stringForColumn:@"IDcard"]];
            [allArray addObject:[rs stringForColumn:@"Email"]];
            [allArray addObject:[rs stringForColumn:@"SerialNo"]];
            [allArray addObject:[rs stringForColumn:@"Remark"]];
        }
        [manager.dataBase close];
    }
    return allArray;
}
@end
