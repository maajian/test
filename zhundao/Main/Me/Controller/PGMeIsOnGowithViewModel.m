//
//  PGMeIsOnGowithViewModel.m
//  zhundao
//
//  Created by zhundao on 2017/9/20.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PGMeIsOnGowithViewModel.h"

@implementation PGMeIsOnGowithViewModel

//api/PerBase/Withdraw?accessKey={accessKey}&amount={amount}&accountId={accountId}

- (void)Withdraw :(NSString *)amount accountId :(NSInteger)accountId isonGowithBlock:(isonGowithBlock)isonGowithBlock{
    NSString *str = [NSString stringWithFormat:@"%@api/v2/user/withdraw?token=%@&amount=%@&accountId=%li",zhundaoApi,[[PGSignManager shareManager] getToken],amount,accountId];
    PGAFmanager *manager = [PGAFmanager manager];
    [manager GET:str parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *result = [NSDictionary dictionaryWithDictionary:responseObject];
        if ([result[@"errcode"] integerValue]==0) {
             isonGowithBlock(@"提现成功");
        }else{
             isonGowithBlock(result[@"errmsg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         isonGowithBlock(error.description);
    }];
}



@end
