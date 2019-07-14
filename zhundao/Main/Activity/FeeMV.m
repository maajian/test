
//
//  FeeMV.m
//  zhundao
//
//  Created by zhundao on 2017/6/15.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "FeeMV.h"

@implementation FeeMV
#pragma 网络判断 是否可以修改
- (void)netWorkWithID:(NSInteger)feeID
{
    AFmanager *manager = [AFmanager shareManager];
    NSString *str = [NSString stringWithFormat:@"%@api/PerActivity/GetActivityFee?accessKey=%@&activityFeeId=%li",zhundaoApi,[[SignManager shareManager] getaccseekey],(long)feeID];
    [manager GET:str parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseObject];
        NSDictionary *dataDic = [dic[@"Data"] copy];
        NSInteger  Consume = [[dataDic objectForKey:@"Consume"] integerValue];
        if (Consume>0) {
            if (_feeBlock) _feeBlock (0);
        }
        if (Consume==0) {
            if (_feeBlock)  _feeBlock(1);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
        if (_feeBlock) {
            _feeBlock(2);
        }
    }];
}

@end
