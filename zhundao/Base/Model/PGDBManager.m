#import "PGDBManager.h"
@implementation PGDBManager
+(PGDBManager *)shareManager
{
    static PGDBManager *dbManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dbManager = [[PGDBManager alloc]init];
    });
    return dbManager ;
}
- (void)createDatabase  
{ 
    NSString *path =NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)[0];
    path = [path stringByAppendingString:@"list.sqlite"];
    NSLog(@"path = %@",path);
    _dataBase = [FMDatabase databaseWithPath:path];
    BOOL open = [_dataBase open];
    if (open) {
        NSLog(@"数据库打开成功");
    }
    else
    {
        NSLog(@"数据库打开失败");
    }
}
- (void)createTable :(NSString *)sqlStr
{
    [self createDatabase];
    if ([self.dataBase open]) {
        bool result = [self.dataBase executeUpdate:sqlStr];
        if (result) {
            NSLog(@"成功创建table");
        }
        else
        {
            NSLog(@"创建table失败");
        }
        [self.dataBase close];
    }
}
- (void)deleteData:(NSString *)sqlStr
{
    if ([self.dataBase open]) {
        BOOL res = [self.dataBase executeUpdate:sqlStr];
        if (res) {
            NSLog(@"数据表插入成功");
        }
        else
        {
            NSLog(@"数据表插入失败");
        }
        [self.dataBase close];
    }
}
- (void)searchData:(NSString *)sqlStr
{
    if ([self.dataBase open]) {
        FMResultSet *rs = [self.dataBase executeQuery:sqlStr];
        while ([rs next]) {
            if (_searchBlock) {
                _searchBlock(YES);
            }
        }
        [self.dataBase close];
    }
}
@end
