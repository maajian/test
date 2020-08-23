//
//  MoreAccountViewModel.m
//  zhundao
//
//  Created by xhkj on 2018/1/19.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import "MoreAccountViewModel.h"

@implementation MoreAccountViewModel

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
        MoreAccountModel *model = [MoreAccountModel yy_modelWithDictionary:userdic];
        [_userArray addObject:model];
    }
    successBlock();
}

/*! 退出登录清空数据 */
- (void)didLogout
{
    if ([[SignManager shareManager].dataBase open])
    {
        NSString *updateSql = [NSString stringWithFormat:@"DROP TABLE signList"];
        [[SignManager shareManager].dataBase executeUpdate:updateSql];
        NSString *updateSql1 = [NSString stringWithFormat:@"DROP TABLE muliSignList"];
        [[SignManager shareManager].dataBase executeUpdate:updateSql1];
        NSString *updateSql12 = [NSString stringWithFormat:@"DROP TABLE contact"];
        [[SignManager shareManager].dataBase executeUpdate:updateSql12];
        [[SignManager shareManager].dataBase close];
    }
}

@end
