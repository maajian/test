//
//  PGMeAddAccountViewModel.m
//  zhundao
//
//  Created by zhundao on 2017/9/19.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PGMeAddAccountViewModel.h"

@implementation PGMeAddAccountViewModel
//api/PerBase/AddCreadCards?accessKey={accessKey}

/*! 添加提现账号 */
- (void)AddCreadCards :(NSDictionary *)dic  AddAccountBlock:(AddAccountBlock)AddAccountBlock{
    NSString *str = [NSString stringWithFormat:@"%@api/PerBase/AddCreadCards?accessKey=%@",zhundaoApi,[[PGSignManager shareManager]getaccseekey]];
    [ZD_NetWorkM postDataWithMethod:str parameters:dic succ:^(NSDictionary *obj) {
        NSDictionary *result = [NSDictionary dictionaryWithDictionary:obj];
        NSLog(@"result = %@",result);
        if ([result[@"Res"] integerValue]==0) {
            AddAccountBlock(1);
        }else{
            AddAccountBlock(0);
        }
    } fail:^(NSError *error) {
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
