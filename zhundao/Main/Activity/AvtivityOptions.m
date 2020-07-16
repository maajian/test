//
//  AvtivityOptions.m
//  zhundao
//
//  Created by zhundao on 2017/4/13.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "AvtivityOptions.h"

@implementation AvtivityOptions

- (void)networkwithBlock :(netBlock)netBlock
{
    NSString *str = [NSString stringWithFormat:@"%@api/PerActivity/PostActivityOptions?accessKey=%@",zhundaoApi,[[ZDDataManager shareManager]getaccseekey]];
    _block = [netBlock copy];
    NSLog(@"str = %@",str);
    [ZD_NetWorkM getDataWithMethod:str parameters:nil succ:^(NSDictionary *obj) {
        NSMutableArray *dataArray = [NSMutableArray array];
        for (NSDictionary *dic in obj[@"Data"]) {
            if (![dic[@"Hidden"] boolValue]) {
                [dataArray addObject:dic];
            }
        }
        
        if (_block) {
            _block(dataArray);
        }
    } fail:^(NSError *error) {
        
    }];
}
@end
