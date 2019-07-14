//
//  MyWalletViewModel.m
//  zhundao
//
//  Created by zhundao on 2017/8/7.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "MyWalletViewModel.h"

@implementation MyWalletViewModel

- (void)getInfo :(moneyBlock)moneyBlock {
    NSString *url = [NSString stringWithFormat:@"%@api/PerBase/GetWithdrawStatus?accessKey=%@",zhundaoApi,[[SignManager shareManager] getaccseekey]];
    AFmanager *manager = [AFmanager shareManager];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 = [NSDictionary dictionaryWithDictionary:responseObject];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:dic1[@"Balance"] forKey:@"Balance"];  //全部金额
        [dic setValue:dic1[@"Status"] forKey:@"status"];   //是否在提现中
        /*! 提现中 */
        if ([dic1[@"Status"]integerValue ]==0) {
            NSArray *array = dic1[@"withdraw"];
            NSDictionary *detailDic = array.firstObject;
            for (NSString *keyStr in detailDic.allKeys) {
                /*! 提现金额 */
                if ([keyStr isEqualToString:@"Amount"]) {
                    [dic setObject:detailDic[@"Amount"] forKey:@"Amount"];
                    /*! 到账时间 */
                }else if ([keyStr isEqualToString:@"AddTime"]){
                    [dic setObject:detailDic[@"AddTime"] forKey:@"AddTime"];
                    /*! 银行名称 */
                }else if ([keyStr isEqualToString:@"BankName"]){
                    [dic setObject:detailDic[@"BankName"] forKey:@"BankName"];
                    /*! 账户 */
                }else if ([keyStr isEqualToString:@"Account"]){
                    [dic setObject:detailDic[@"Account"] forKey:@"Account"];
                }
            }
        }
        moneyBlock(dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
    
}

- (void)saveWithdraw :(NSDictionary *)dic{
    NSString *filepath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"withdraw.plist"];
  BOOL issuces =    [dic writeToFile:filepath atomically:YES];
    if (issuces) {
        NSLog(@"1");
    }
}

- (NSDictionary *)readWithdraw {
     NSString *filepath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"withdraw.plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filepath];
    return dic;
}
@end
