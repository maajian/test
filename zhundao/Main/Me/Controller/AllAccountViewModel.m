//
//  AllAccountViewModel.m
//  zhundao
//
//  Created by zhundao on 2017/9/18.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "AllAccountViewModel.h"

@implementation AllAccountViewModel

//api/PerBase/GetCreditCards?accessKey={accessKey}

- (void)GetCreditCards :(allAccountBlock)allAccountBlock{
    NSString *url = [NSString stringWithFormat:@"%@api/PerBase/GetCreditCards?accessKey=%@",zhundaoApi,[[SignManager shareManager] getaccseekey]];
    AFmanager *manager = [AFmanager shareManager];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       NSDictionary *result = [NSDictionary dictionaryWithDictionary:responseObject];
        NSLog( @"dic = %@",result );
        if ([result[@"Res"]integerValue]==0) {
            NSMutableArray *array = [NSMutableArray array];
            for (NSDictionary *dic in result[@"Data"]) {
                NSMutableDictionary *datadic = [NSMutableDictionary dictionary];
                [datadic setObject:dic[@"Account"] forKey:@"Account"];
                [datadic setObject:dic[@"BankName"] forKey:@"BankName"];
                [datadic setObject:dic[@"ID"] forKey:@"ID"];
                [array addObject:datadic];
            }
            allAccountBlock(1,array);
        }else{
            allAccountBlock(0,@[]);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        allAccountBlock(0,@[]);
    }];
}


//api/PerBase/DeleteCreadCard/{id}?accessKey={accessKey}
- (void)deleteCreadCard :(NSInteger)ID successBlock:(ZDSuccessBlock)successBlock{
    NSString *str = [NSString stringWithFormat:@"%@api/PerBase/DeleteCreadCard/%li?accessKey=%@",zhundaoApi,ID,[[SignManager shareManager]getaccseekey]];
    AFmanager *manager = [AFmanager shareManager];
    [manager GET:str parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseObject];
        successBlock(dic);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


@end
