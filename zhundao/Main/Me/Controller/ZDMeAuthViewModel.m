//
//  ZDMeAuthViewModel.m
//  zhundao
//
//  Created by zhundao on 2017/9/19.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ZDMeAuthViewModel.h"

@implementation ZDMeAuthViewModel

//api/PerBase/PstAuthentication?accessKey={accessKey}

- (void)postAuthentication :(NSDictionary *)dic authBlock :(authBlock)authBlock{
    NSString *str = [NSString stringWithFormat:@"%@api/PerBase/PstAuthentication?accessKey=%@",zhundaoApi,[[ZDSignManager shareManager]getaccseekey]];
    [ZD_NetWorkM postDataWithMethod:str parameters:dic succ:^(NSDictionary *obj) {
        NSDictionary *result = [NSDictionary dictionaryWithDictionary:obj];
        NSLog(@"result = %@",result);
        if ([result[@"Res"] integerValue]==0) {
            authBlock(1);
        }else{
            authBlock(0);
        }
    } fail:^(NSError *error) {
        NSLog(@"error = %@",error);
        authBlock(0);
    }];
}

//api/PerBase/GetAuthorInfo?accessKey={accessKey} 获取省份认证信息
- (void)GetAuthorInfo {
    NSString *str = [NSString stringWithFormat:@"%@api/PerBase/GetAuthorInfo?accessKey=%@",zhundaoApi,[[ZDSignManager shareManager]getaccseekey]];
    [ZD_NetWorkM getDataWithMethod:str parameters:nil succ:^(NSDictionary *obj) {
        NSDictionary *result = [NSDictionary dictionaryWithDictionary:obj];
        NSLog(@"result = %@",result);
    } fail:^(NSError *error) {
        
    }];
}


@end
