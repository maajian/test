//
//  ZDMePromoteNoticeViewModel.m
//  zhundao
//
//  Created by maj on 2020/1/7.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "ZDMePromoteNoticeViewModel.h"

@implementation ZDMePromoteNoticeViewModel

- (instancetype)init {
    if (self = [super init]) {
        self.dataArray = [NSMutableArray array];
    }
    return self;
}

- (void)getNoticeSuccess:(ZDBlock_Void)success failure:(ZDBlock_Void)failure {
    NSString *url = [NSString stringWithFormat:@"%@api/v2/extra/getPartnerNotice?token=%@", zhundaoApi,[[SignManager shareManager] getToken]];
    NSDictionary *params = @{@"pageSize": @(10000), @"pageIndex": @(1)};
    [ZD_NetWorkM postDataWithMethod:url parameters:params succ:^(NSDictionary *obj) {
        for (NSDictionary *dic in obj[@"data"]) {
            ZDMePromoteNoticeModel *model = [ZDMePromoteNoticeModel yy_modelWithJSON:dic];
            [self.dataArray addObject:model];
        }
        ZDDo_Block_Safe_Main(success);
    } fail:^(NSError *error) {
        ZDDo_Block_Safe_Main(failure);
    }];
}

@end
