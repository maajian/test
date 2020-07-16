//
//  ZDMoreAccountViewModel.m
//  zhundao
//
//  Created by xhkj on 2018/1/19.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import "ZDMoreAccountViewModel.h"

@implementation ZDMoreAccountViewModel

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
        ZDMoreAccountModel *model = [ZDMoreAccountModel yy_modelWithDictionary:userdic];
        [_userArray addObject:model];
    }
    successBlock();
}

/*! 退出登录清空数据 */
- (void)didLogout
{
    /*! 清除本地数据 */
    NSDictionary *userArray = [[NSUserDefaults standardUserDefaults]objectForKey:@"userArray"];
    NSString *appDomain = [[NSBundle mainBundle]bundleIdentifier];
    [[NSUserDefaults standardUserDefaults]removePersistentDomainForName:appDomain];
    [[NSUserDefaults standardUserDefaults] setObject:userArray forKey:@"userArray"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if ([[ZDDataManager shareManager].dataBase open])
    {
        NSString *updateSql = [NSString stringWithFormat:@"DROP TABLE signList"];
        [[ZDDataManager shareManager].dataBase executeUpdate:updateSql];
        NSString *updateSql1 = [NSString stringWithFormat:@"DROP TABLE muliSignList"];
        [[ZDDataManager shareManager].dataBase executeUpdate:updateSql1];
        NSString *updateSql12 = [NSString stringWithFormat:@"DROP TABLE contact"];
        [[ZDDataManager shareManager].dataBase executeUpdate:updateSql12];
        [[ZDDataManager shareManager].dataBase close];
    }
}

@end
