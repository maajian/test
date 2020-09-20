//
//  PGMeChangeInfoViewModel.m
//  zhundao
//
//  Created by zhundao on 2017/11/1.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PGMeChangeInfoViewModel.h"

@implementation PGMeChangeInfoViewModel

//api/PerBase/UpdateUserInfo?accessKey={accessKey}

- (void)UpdateUserInfo :(NSDictionary *)dic
          successBlock :(ZDSuccessBlock)successBlock
            errorBlock : (ZDErrorBlock)errorBlock {
    NSString *str = [NSString stringWithFormat:@"%@api/v2/user/updateUser?token=%@",zhundaoApi,[[PGSignManager shareManager] getToken]];
    [ZD_NetWorkM postDataWithMethod:str parameters:dic succ:^(NSDictionary *obj) {
        successBlock(obj);
    } fail:^(NSError *error) {
        errorBlock(error);
    }];
}

- (void)getUserInfo:(ZDSuccessBlock)successBlock
        errorBlock : (ZDErrorBlock)errorBlock{
    NSString *userstr = [NSString stringWithFormat:@"%@api/v2/user/getUserInfo?token=%@",zhundaoApi,[[PGSignManager shareManager] getToken]];
    [ZD_NetWorkM getDataWithMethod:userstr parameters:nil succ:^(NSDictionary *obj) {
        successBlock(obj);
    } fail:^(NSError *error) {
        errorBlock(error);
    }];
}
    


@end
