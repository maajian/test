//
//  AuthViewModel.m
//  zhundao
//
//  Created by zhundao on 2017/9/19.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "AuthViewModel.h"

@implementation AuthViewModel

//api/PerBase/PstAuthentication?accessKey={accessKey}

- (void)postAuthentication :(NSDictionary *)dic authBlock :(authBlock)authBlock{
    NSString *str = [NSString stringWithFormat:@"%@api/PerBase/PstAuthentication?accessKey=%@",zhundaoApi,[[SignManager shareManager]getaccseekey]];
    AFmanager *manager = [AFmanager shareManager];
    [manager POST:str parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         NSDictionary *result = [NSDictionary dictionaryWithDictionary:responseObject];
        NSLog(@"result = %@",result);
        if ([result[@"Res"] integerValue]==0) {
            authBlock(1);
        }else{
            authBlock(0);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
        authBlock(0);
    }];
}

//api/PerBase/GetAuthorInfo?accessKey={accessKey} 获取省份认证信息
- (void)GetAuthorInfo {
    NSString *str = [NSString stringWithFormat:@"%@api/PerBase/GetAuthorInfo?accessKey=%@",zhundaoApi,[[SignManager shareManager]getaccseekey]];
    AFmanager *manager = [AFmanager shareManager];
    [manager GET:str parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *result = [NSDictionary dictionaryWithDictionary:responseObject];
        NSLog(@"result = %@",result);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


@end
