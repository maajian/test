//
//  ZDMePromoteUserNumberViewModel.m
//  zhundao
//
//  Created by maj on 2020/1/19.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "ZDMePromoteUserNumberViewModel.h"

@implementation ZDMePromoteUserNumberViewModel

- (instancetype)init {
    if (self = [super init]) {
        self.dataArray = [NSMutableArray array];
    }
    return self;
}

// 获取扩展用户列表
- (void)getUserNumberSuccess:(ZDBlock_Void)success failure:(ZDBlock_Void)failure {
    NSString *url = [NSString stringWithFormat:@"%@api/v2/extra/getPartnerUserList?token=%@", zhundaoApi,[[ZDSignManager shareManager] getToken]];
    NSDictionary *params = @{@"pageSize": @(10000), @"pageIndex": @(1)};
    [ZD_NetWorkM postDataWithMethod:url parameters:params succ:^(NSDictionary *obj) {
        for (NSDictionary *dic in obj[@"data"]) {
            ZDMePromoteUserNumberModel *model = [ZDMePromoteUserNumberModel yy_modelWithJSON:dic];
            model.AddTime = [model.AddTime substringToIndex:model.AddTime.length - 3];
            [self.dataArray addObject:model];
        }
        ZDDo_Block_Safe_Main(success);
    } fail:^(NSError *error) {
        ZDDo_Block_Safe_Main(failure);
    }];
}

@end
