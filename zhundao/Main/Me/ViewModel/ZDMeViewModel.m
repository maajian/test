//
//  ZDMeViewModel.m
//  zhundao
//
//  Created by maj on 2020/1/31.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "ZDMeViewModel.h"

@implementation ZDMeViewModel

- (void)getPromoteSuccess:(ZDBlock_Void)success failure:(ZDBlock_Void)failure {
    NSString *urlString = [NSString stringWithFormat:@"%@zhundao2all?token=%@", zhundaoLogApi,[[SignManager shareManager] getToken]];
    NSDictionary *params = @{@"BusinessCode": @"Badge_Get", @"Data": @{}};
    ZDNetWorkManager.shareHTTPSessionManager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json",
    @"text/html",
    @"text/json",
    @"text/javascript",
    @"text/plain",@"application/octet-stream",
    nil];
    [ZD_NetWorkM postDataWithMethod:urlString parameters:params succ:^(NSDictionary *obj) {
        NSString *dataStr = obj[@"data"];
        NSDictionary *dataDic = dataStr.zd_jsonDictionary;
        for (NSDictionary *dic in dataDic[@"datas"]) {
            if (([dic[@"ID"] integerValue] == 1002 &&  [dic[@"Status"] integerValue] == 1) ||
                ([dic[@"ID"] integerValue] == 1003 &&  [dic[@"Status"] integerValue] == 1) ||
                ([dic[@"ID"] integerValue] == 1004 &&  [dic[@"Status"] integerValue] == 1) ) {
                self.allowPromote = YES;
            }
            if ([dic[@"ID"] integerValue] == 4001 &&  [dic[@"Status"] integerValue] == 1) {
                self.allowSupplier = YES;
            }
        }
        ZDDo_Block_Safe_Main(success);
    } fail:^(NSError *error) {
        ZDDo_Block_Safe_Main(failure);
    }];
}
- (void)networkGetNotifySuccess:(ZDMeADBlock)success failure:(ZDBlock_Error)failure {
    NSString *url = [NSString stringWithFormat:@"%@api/v2/agent/getAdsPop?token=%@&from=ios",zhundaoApi, [[SignManager shareManager] getToken]];
    [ZD_NetWorkM getDataWithMethod:url parameters:nil succ:^(NSDictionary *obj) {
        if ([obj[@"errcode"] integerValue] == 0) {
            ZDMeADModel *model = [ZDMeADModel yy_modelWithJSON:obj[@"data"]];
            ZDDo_Block_Safe_Main1(success, model);
        } else {
            ZDDo_Block_Safe_Main1(failure, [NSError errorWithDomain:obj[@"errmsg"] code:100 userInfo:nil]);
        }
    } fail:^(NSError *error) {
        ZDDo_Block_Safe_Main1(failure, error);
    }];
}
- (void)networForAdsPopRespond:(BOOL)respond AdsPopID:(NSInteger)AdsPopID {
    NSString *url = [NSString stringWithFormat:@"%@api/v2/agent/addAdsPopList?token=%@",zhundaoApi, [[SignManager shareManager] getToken]];
    NSDictionary *param = @{@"AdsPopID": @(AdsPopID),
                            @"Result": respond ? @(1) : @(0),
                            @"From": @"ios"};
    [ZD_NetWorkM postDataWithMethod:url parameters:param succ:nil fail:nil];
}

@end
