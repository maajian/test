//
//  ZDMePromoteCustomContactViewModel.m
//  zhundao
//
//  Created by maj on 2020/1/17.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "ZDMePromoteCustomContactViewModel.h"

@implementation ZDMePromoteCustomContactViewModel
- (instancetype)init {
    if (self = [super init]) {
        self.dataArray = [NSMutableArray array];
        self.noticeArray = [NSMutableArray array];
        _zhundaoBi = 0;
    }
    return self;
}
// 获取合伙人主页统计数据
- (void)getPromoteCustomContactSuccess:(ZDBlock_Void)success failure:(ZDBlock_Void)failure {
    NSString *url = [NSString stringWithFormat:@"%@api/v2/extra/getPartnerHomeData?token=%@",zhundaoApi,[[ZDSignManager shareManager] getToken]];
    [ZD_NetWorkM getDataWithMethod:url parameters:nil succ:^(NSDictionary *obj) {
        ZDMePromoteCustomContactModel *incomeModel = [ZDMePromoteCustomContactModel incomeModelWithDic:obj[@"data"]];
        ZDMePromoteCustomContactModel *userNumberModel = [ZDMePromoteCustomContactModel userNumberModelWithDic:obj[@"data"]];
        ZDMePromoteCustomContactModel *orderModel = [ZDMePromoteCustomContactModel orderModelWithDic:obj[@"data"]];
        [self.dataArray addObject:incomeModel];
        [self.dataArray addObject:userNumberModel];
        [self.dataArray addObject:orderModel];
        ZDDo_Block_Safe_Main(success);
    } fail:^(NSError *error) {
        ZDDo_Block_Safe_Main(failure);
    }];
}
- (void)getZDBiSuccess:(ZDBlock_Void)success failure:(ZDBlock_Void)failure {
    NSString *url = [NSString stringWithFormat:@"%@api/v2/user/getUserCoin?token=%@",zhundaoApi,[[ZDSignManager shareManager] getToken]];
    [ZD_NetWorkM getDataWithMethod:url parameters:nil succ:^(NSDictionary *obj) {
        if ([obj[@"res"] boolValue]) {
            _zhundaoBi = ZD_SafeIntValue(obj[@"data"][@"Balance"]);
        } else {
            _zhundaoBi = 0;
        }
        ZDDo_Block_Safe_Main(success);
    } fail:^(NSError *error) {
        ZDDo_Block_Safe_Main(failure);
    }];
}
- (void)getNoticeSuccess:(ZDBlock_Void)success failure:(ZDBlock_Void)failure {
    NSString *url = [NSString stringWithFormat:@"%@api/v2/extra/getPartnerNotice?token=%@",zhundaoApi,[[ZDSignManager shareManager] getToken]];
    NSDictionary *params = @{@"pageSize": @(3), @"pageIndex": @(1)};
    [ZD_NetWorkM postDataWithMethod:url parameters:params succ:^(NSDictionary *obj) {
        for (NSDictionary *dic in obj[@"data"]) {
            ZDMePromoteNoticeModel *model = [ZDMePromoteNoticeModel yy_modelWithJSON:dic];
            [self.noticeArray addObject:model];
        }
        ZDDo_Block_Safe_Main(success);
    } fail:^(NSError *error) {
        ZDDo_Block_Safe_Main(failure);
    }];
}

@end
