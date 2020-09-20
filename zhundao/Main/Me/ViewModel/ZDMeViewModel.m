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
    NSString *urlString = [NSString stringWithFormat:@"%@zhundao2all?token=%@", zhundaoLogApi,[[ZDSignManager shareManager] getToken]];
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
        }
        ZDDo_Block_Safe_Main(success);
    } fail:^(NSError *error) {
        ZDDo_Block_Safe_Main(failure);
    }];
}

@end
