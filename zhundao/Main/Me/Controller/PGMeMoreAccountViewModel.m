//
//  PGMeMoreAccountViewModel.m
//  zhundao
//
//  Created by xhkj on 2018/1/19.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import "PGMeMoreAccountViewModel.h"

@implementation PGMeMoreAccountViewModel

- (instancetype)init {
    if (self = [super init]) {
        _userArray = [NSMutableArray array];
    }
    return self;
}

/*! 获取列表数据 */
- (void)getListData:(dispatch_block_t)successBlock  {
    [_userArray removeAllObjects];
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:@"userArray"];
    for (NSDictionary *userdic in array) {
        PGMeMoreAccountModel *model = [PGMeMoreAccountModel yy_modelWithDictionary:userdic];
        [_userArray addObject:model];
    }
    successBlock();
}

/*! 退出登录清空数据 */
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
