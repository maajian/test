//
//  FaceDetailViewModel.m
//  zhundao
//
//  Created by zhundao on 2017/7/27.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "FaceDetailViewModel.h"

@implementation FaceDetailViewModel


- (void)activityListDataWithBlock:(activityBlock)activityBlock
{
    
     NSString *listUrl =[NSString stringWithFormat:@"%@api/Uface/PostActivityList?accessKey=%@",zhundaoApi,[[SignManager shareManager]getaccseekey]];
     AFmanager *manager = [AFmanager shareManager];
    NSDictionary *dic = @{@"Type":@"1",
                          @"pageSize":@"1000",
                          @"curPage":@"1"};
    [manager POST:listUrl parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *result = [NSDictionary dictionaryWithDictionary:responseObject];
        NSArray *array1 = result[@"Data"];
        NSMutableArray *muarray = [NSMutableArray array];
        NSMutableArray *muarray1 = [NSMutableArray array];
        for (NSDictionary *acdic in array1) {
            
            [muarray addObject:[acdic objectForKey:@"Title"]];
            [ muarray1 addObject:[acdic objectForKey:@"ID"]];
        }
        activityBlock(muarray,muarray1);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
}

- (void)signListDataWithdic :(NSDictionary *)dic   Block:(signBlock)signBlock
{
    NSString *url =  [NSString stringWithFormat:@"%@api/CheckIn/PostCheckIn?accessKey=%@",zhundaoApi,[[SignManager shareManager]getaccseekey]];
    AFmanager *manager = [AFmanager shareManager];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *result = [NSDictionary dictionaryWithDictionary:responseObject];
        NSArray *array1 = result[@"Data"];
        signBlock(array1);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
        signBlock(@[@""]);
    }];

}


- (void)BindDeviceWithID :(NSString *)checkInId deviceKey:(NSString *)deviceKey  bindBlock:(bindBlock)bindBlock
{
    
    NSString *url  = [NSString stringWithFormat:@"https://face.zhundao.net/api/Core/BindDevice?accessKey=%@&deviceKey=%@&checkInId=%@",[[SignManager shareManager] getaccseekey],deviceKey,checkInId];
     AFmanager *manager = [AFmanager shareManager];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 120.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        bindBlock(1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
        bindBlock(0);
    }];
}

- (void)getProgressWithDeviceKey:(NSString *)deviceKey  progressBlock:(progressBlock)progressBlock
{
    NSString *url  = [NSString stringWithFormat:@"https://face.zhundao.net//api/Core/GetProcess?accessKey=%@&deviceKey=%@",[[SignManager shareManager] getaccseekey],deviceKey];
    AFmanager *manager = [AFmanager shareManager];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 120.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *jsonString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSArray *array = [jsonString componentsSeparatedByString:@":"];
        NSLog(@"array.firstObject = %@",array.firstObject);
        if ([array.firstObject isEqualToString:@""]) {
            progressBlock(1,1);
        }else{
            NSInteger a = [[array[1] stringByTrimmingCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]] integerValue];
            NSInteger b = [[array[2] stringByTrimmingCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]] integerValue];
            progressBlock(a,b);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
        
    }];
}


- (void)addNewWithDeviceKey:(NSString *)deviceKey addNewBlock:(addNewBlock)addNewBlock
{
    NSString *url = [NSString stringWithFormat:@"https://face.zhundao.net/api/Core/SyncNewPerson?accessKey=%@&deviceKey=%@",[[SignManager shareManager] getaccseekey],deviceKey];
    AFmanager *manager = [AFmanager shareManager];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 60.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseObject];
        addNewBlock(dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
        addNewBlock(@{});
    }];
}




@end
