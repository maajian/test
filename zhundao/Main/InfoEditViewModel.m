//
//  InfoEditViewModel.m
//  zhundao
//
//  Created by 罗程勇 on 2018/6/15.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import "InfoEditViewModel.h"

@implementation InfoEditViewModel

// 验证码注册登录
- (void)loginWirhCode:(NSString *)code phoneStr:(NSString *)phoneStr name:(NSString *)name passWord:(NSString *)passWord  successBlock:(kZDCommonSucc)successBlock failBlock:(kZDCommonFail)failBlock  {
    AFmanager *manager = [AFmanager shareManager];
    NSString *str = [NSString stringWithFormat:@"%@api/v2/login",zhundaoApi];
    NSDictionary *dic = @{@"userName":phoneStr,
                          @"code":code,
                          @"trueName":name,
                          @"passWord":passWord};
    [manager POST:str parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"token"]) {
            [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"token"] forKey:@"token"];
            [[NSUserDefaults standardUserDefaults]setObject:responseObject[@"accessKey"] forKey:AccessKey];
            [[NSUserDefaults standardUserDefaults]synchronize];
        } else {
            failBlock(@"完善信息");
        }
        successBlock();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failBlock(error.description);
    }];
}

@end
