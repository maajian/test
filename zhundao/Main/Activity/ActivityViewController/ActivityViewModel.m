//
//  ActivityViewModel.m
//  zhundao
//
//  Created by zhundao on 2017/7/18.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ActivityViewModel.h"

@implementation ActivityViewModel

/*! 获取当前月的活动个数 */
//api/PerActivity/GetActivityNumCurMonth?accessKey={accessKey}
- (void)checkIsCanpost:(ZDSuccessBlock)successBlock error:(ZDErrorBlock)errorBlock {
    NSString *str = [NSString stringWithFormat:@"%@api/PerActivity/GetActivityNumCurMonth?accessKey=%@",zhundaoApi,[[ZDDataManager shareManager]getaccseekey]];
    [ZD_NetWorkM getDataWithMethod:str parameters:nil succ:^(NSDictionary *obj) {
        successBlock(obj);
    } fail:^(NSError *error) {
        errorBlock(error);
    }];
}
@end
