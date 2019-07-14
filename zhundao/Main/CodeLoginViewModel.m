//
//  CodeLoginViewModel.m
//  zhundao
//
//  Created by 罗程勇 on 2018/6/15.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import "CodeLoginViewModel.h"

@implementation CodeLoginViewModel

/**
 发送验证码

 @param phoneStr <#phoneStr description#>
 @param successBlock <#successBlock description#>
 @param failBlock <#failBlock description#>
 */
- (void)sendCode:(NSString *)phoneStr successBlock:(kZDCommonSucc)successBlock failBlock:(kZDCommonFail)failBlock {
    AFmanager *manager = [AFmanager shareManager];
    NSString *str = [NSString stringWithFormat:@"%@api/v2/senCode?phoneOrEmail=%@",zhundaoApi,phoneStr];
    [manager GET:str parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject = %@",responseObject);
        _sendCodeJson = [responseObject copy];
        successBlock();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failBlock(error.description);
    }];
}

 // 验证码登录 
- (void)loginWirhCode:(NSString *)code phoneStr:(NSString *)phoneStr successBlock:(kZDCommonSucc)successBlock failBlock:(kZDCommonFail)failBlock  {
    AFmanager *manager = [AFmanager shareManager];
    NSString *str = [NSString stringWithFormat:@"%@api/v2/login",zhundaoApi];
    NSDictionary *dic = @{@"userName":phoneStr,
                          @"code":code};
    [manager POST:str parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"token"]) {
            [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"token"] forKey:@"token"];
            [[NSUserDefaults standardUserDefaults]setObject:responseObject[@"accessKey"] forKey:AccessKey];
            [[NSUserDefaults standardUserDefaults]synchronize];
            successBlock();
        } else {
            failBlock(responseObject[@"errmsg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failBlock(error.description);
    }];
}

@end
