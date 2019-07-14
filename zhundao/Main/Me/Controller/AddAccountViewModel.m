//
//  AddAccountViewModel.m
//  zhundao
//
//  Created by zhundao on 2017/9/19.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "AddAccountViewModel.h"

@implementation AddAccountViewModel
//api/PerBase/AddCreadCards?accessKey={accessKey}

/*! 添加提现账号 */
- (void)AddCreadCards :(NSDictionary *)dic  AddAccountBlock:(AddAccountBlock)AddAccountBlock{
    NSString *str = [NSString stringWithFormat:@"%@api/PerBase/AddCreadCards?accessKey=%@",zhundaoApi,[[SignManager shareManager]getaccseekey]];
    AFmanager *manager= [AFmanager shareManager];
    [manager POST:str parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *result = [NSDictionary dictionaryWithDictionary:responseObject];
        NSLog(@"result = %@",result);
        if ([result[@"Res"] integerValue]==0) {
            AddAccountBlock(1);
        }else{
            AddAccountBlock(0);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        AddAccountBlock(0);
    }];
    
}

- (BOOL)isCanPost :(NSDictionary *)postdic{
    if (postdic.count==2) {
        return NO;
    }else if ([[postdic objectForKey:@"Account"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0){
        return NO;
    }else{
        return YES;
    }
}

@end
