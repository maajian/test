//
//  ZDMePromoteOrderViewModel.m
//  zhundao
//
//  Created by maj on 2020/1/19.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "ZDMePromoteOrderViewModel.h"

@implementation ZDMePromoteOrderViewModel

- (instancetype)init {
    if (self = [super init]) {
        _dataArray = [NSMutableArray array];
    }
    return self;
}

- (void)getOrderSuccess:(ZDBlock_Void)success failure:(ZDBlock_Void)failure {
    NSString *url = [NSString stringWithFormat:@"%@api/v2/extra/getPartnerOrderList?token=%@", zhundaoApi,[[ZDDataManager shareManager] getToken]];
    NSDictionary *params = @{@"pageSize": @(10000), @"pageIndex": @(1)};
    [ZD_NetWorkM postDataWithMethod:url parameters:params succ:^(NSDictionary *obj) {
        for (NSDictionary *dic in obj[@"data"]) {
            ZDMePromoteOrderModel *model = [ZDMePromoteOrderModel yy_modelWithJSON:dic];
            [_dataArray addObject:model];
        }
        ZDDo_Block_Safe_Main(success);
    } fail:^(NSError *error) {
        ZDDo_Block_Safe_Main(failure);
    }];
}

@end
