//
//  ZDActivitySignListViewModel.m
//  zhundao
//
//  Created by zhundao on 2017/6/20.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ZDActivitySignListViewModel.h"

@implementation ZDActivitySignListViewModel


- (NSMutableArray *)getRightArray:(NSDictionary *)datadic array :(NSArray *)array
{
    NSMutableArray *result = [NSMutableArray array];
    NSArray *allEngArray  = nil;
    if (datadic[@"UserName"]) {
        allEngArray = @[@"UserName",@"Mobile",@"Sex",@"Company",@"Depart",@"Duty",@"IDcard",@"Industry",@"Email",@"Address",@"Remark",@"FaceImg"];
    }
    else{
        allEngArray = @[@"TrueName",@"Mobile",@"Sex",@"Company",@"Depart",@"Duty",@"IDcard",@"Industry",@"Email",@"Address",@"Remark",@"FaceImg"];
    }
    NSArray *arr =  @[@"姓名",@"手机",@"性别",@"单位",@"部门",@"职务",@"身份证",@"行业",@"邮箱",@"地址",@"备注",@"人脸照片"];
    for (NSString *str  in array) {
        [result addObject:[datadic objectForKey:[allEngArray objectAtIndex:[arr indexOfObject:str]]]];
        if ([str isEqualToString:@"性别"]) {
            [result removeLastObject];
            if ([[datadic objectForKey:[allEngArray objectAtIndex:[arr indexOfObject:str]]] integerValue]==1) {
                [result addObject:@"男"];
            }else [result addObject:@"女"];
        }
    }
    return result;
}

- (NSMutableArray *)getLastPostArray :(NSArray *)array
{
    NSArray *engArray = @[@"UserName",@"Mobile",@"Sex",@"Company",@"Depart",@"Duty",@"IDcard",@"Industry",@"Email",@"Address",@"Remark",@"FaceImg"];
    NSArray *arr=  @[@"100",@"101",@"102",@"103",@"104",@"105",@"110",@"106",@"107",@"111",@"109",@"112"];
    NSMutableArray *lastArray = [NSMutableArray array];
    @autoreleasepool {
        for (NSString *numberStr in array) {
            NSString *str = [engArray objectAtIndex:[arr indexOfObject:numberStr]];
            [lastArray addObject:str];
        }
    }
    
    return lastArray;
}

- (void)removeNone:(NSMutableArray *)array
{
    for (int i = 0 ; i <array.count; i++) {
        if ([array[i] isKindOfClass:[NSString class]]) {
            if ([array[i] isEqualToString:@"未填写"]||[array[i] isEqualToString:@"未填写*"]) {
                [array replaceObjectAtIndex:i withObject:@""];
            }
        }
    }
}

- (void)payMent : (NSInteger)payment title :(NSString *)title array :(NSMutableArray *)array{
    switch (payment) {
        case 0:
            [array addObject:[NSString stringWithFormat:@"%@ (微信支付)",title]];
            break;
        case 1:
            [array addObject:[NSString stringWithFormat:@"%@ (线下支付)",title]];
            break;
        case 2:
            [array addObject:[NSString stringWithFormat:@"%@ (支付宝)",title]];
            break;
        case 3:
            [array addObject:[NSString stringWithFormat:@"%@ 微信支付(直联)",title]];
            break;
        case 4:
            [array addObject:[NSString stringWithFormat:@"%@ 微信原生支付",title]];
            break;
        default:
            break;
    }
}


- (void)addADMark :(NSString *)adMark personID :(NSInteger)personID UserName :(NSString *)UserName Mobile :(NSString *)Mobile markBlock:(markBlock)markBlock{
    NSString *str = [NSString stringWithFormat:@"%@api/PerActivity/UpdateActivityList?accessKey=%@",zhundaoApi,[[ZDSignManager shareManager] getaccseekey]];
    NSDictionary *dic = @{@"UserName" : UserName,
                          @"Mobile" : Mobile,
                          @"ID" : @(personID),
                          @"AdminRemark":adMark};
    [ZD_NetWorkM postDataWithMethod:str parameters:dic succ:^(NSDictionary *obj) {
        NSDictionary *dic1 = [NSDictionary dictionaryWithDictionary:obj];
        if ([dic1[@"Res"] integerValue]==0) {
            markBlock(1);
        }else{
            markBlock(0);
        }
    } fail:^(NSError *error) {
        markBlock(0);
        NSLog(@"error = %@",error);
    }];
}



@end
