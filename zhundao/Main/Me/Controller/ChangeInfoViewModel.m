//
//  ChangeInfoViewModel.m
//  zhundao
//
//  Created by zhundao on 2017/11/1.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ChangeInfoViewModel.h"

@implementation ChangeInfoViewModel

//api/PerBase/UpdateUserInfo?accessKey={accessKey}

- (void)UpdateUserInfo :(NSDictionary *)dic
          successBlock :(ZDSuccessBlock)successBlock
            errorBlock : (ZDErrorBlock)errorBlock {
    AFmanager *manager = [AFmanager shareManager];
    NSString *str = [NSString stringWithFormat:@"%@api/v2/user/updateUser?token=%@",zhundaoApi,[[SignManager shareManager] getToken]];
    [manager POST:str parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error);
    }];
}

- (void)getUserInfo:(ZDSuccessBlock)successBlock
        errorBlock : (ZDErrorBlock)errorBlock{
    NSString *userstr = [NSString stringWithFormat:@"%@api/v2/user/getUserInfo?token=%@",zhundaoApi,[[SignManager shareManager] getToken]];
    AFmanager *manager = [AFmanager shareManager];
    [manager GET:userstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error);
    }];
}
    


@end
