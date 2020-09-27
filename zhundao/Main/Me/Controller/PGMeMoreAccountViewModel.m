#import "PGMeMoreAccountViewModel.h"
@implementation PGMeMoreAccountViewModel
- (instancetype)init {
    if (self = [super init]) {
        _userArray = [NSMutableArray array];
    }
    return self;
}
- (void)getListData:(dispatch_block_t)successBlock  {
    [_userArray removeAllObjects];
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:@"userArray"];
    for (NSDictionary *userdic in array) {
        PGMeMoreAccountModel *model = [PGMeMoreAccountModel yy_modelWithDictionary:userdic];
        [_userArray addObject:model];
    }
    successBlock();
}
- (void)didLogout
{
    if ([[PGSignManager shareManager].dataBase open])
    {
        NSString *updateSql = [NSString stringWithFormat:@"DROP TABLE signList"];
        [[PGSignManager shareManager].dataBase executeUpdate:updateSql];
        NSString *updateSql1 = [NSString stringWithFormat:@"DROP TABLE muliSignList"];
        [[PGSignManager shareManager].dataBase executeUpdate:updateSql1];
        NSString *updateSql12 = [NSString stringWithFormat:@"DROP TABLE contact"];
        [[PGSignManager shareManager].dataBase executeUpdate:updateSql12];
        [[PGSignManager shareManager].dataBase close];
    }
}
@end
