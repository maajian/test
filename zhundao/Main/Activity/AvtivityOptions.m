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
    NSString *str = [NSString stringWithFormat:@"%@api/PerActivity/PostActivityOptions?accessKey=%@",zhundaoApi,[[SignManager shareManager]getaccseekey]];
    _block = [netBlock copy];
    NSLog(@"str = %@",str);
    AFmanager *manager = [AFmanager shareManager];
    [manager GET:str parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableArray *dataArray = [NSMutableArray array];
        for (NSDictionary *dic in responseObject[@"Data"]) {
            if (![dic[@"Hidden"] boolValue]) {
                [dataArray addObject:dic];
            }
        }
        
        if (_block) {
            _block(dataArray);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
}
@end
