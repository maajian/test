
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
    NSString *str = [NSString stringWithFormat:@"%@api/PerActivity/GetActivityFee?accessKey=%@&activityFeeId=%li",zhundaoApi,[[SignManager shareManager] getaccseekey],(long)feeID];
    [ZD_NetWorkM getDataWithMethod:str parameters:nil succ:^(NSDictionary *obj) {
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:obj];
        NSDictionary *dataDic = [dic[@"Data"] copy];
        NSInteger  Consume = [[dataDic objectForKey:@"Consume"] integerValue];
        if (Consume>0) {
            if (_feeBlock) _feeBlock (0);
        }
        if (Consume==0) {
            if (_feeBlock)  _feeBlock(1);
        }
    } fail:^(NSError *error) {
        DDLogVerbose(@"error = %@",error);
        if (_feeBlock) {
            _feeBlock(2);
        }
    }];
}

@end
