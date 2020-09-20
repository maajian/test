//
//  ZDActivityNewPersonViewModel.m
//  zhundao
//
//  Created by zhundao on 2017/7/10.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ZDActivityNewPersonViewModel.h"

@implementation ZDActivityNewPersonViewModel



//100,101
- (NSMutableArray *)getBaseName :(NSString *)str
{
    NSArray *idArray=  @[@"100",@"101",@"102",@"103",@"104",@"105",@"110",@"106",@"107",@"111",@"109",@"112"];

    NSArray *arr =  @[@"姓名",@"手机",@"性别",@"单位",@"部门",@"职务",@"身份证",@"行业",@"邮箱",@"地址",@"备注",@"人脸照片"];
    
    NSArray *comArray = [str componentsSeparatedByString:@","];
    
    NSMutableArray *lastArray = [NSMutableArray array];
    @autoreleasepool {
        for (NSString *numberStr in comArray) {
            NSString *str = [arr objectAtIndex:[idArray indexOfObject:numberStr]];
            [lastArray addObject:str];
        }
    }
    return lastArray;
}

- (NSMutableArray *)getRightArray :(NSArray *)baseArray allOptionArray:(NSArray *)allOptionArray
{
    NSMutableArray *lastArray = [NSMutableArray array];
    for (int i = 0; i<baseArray.count ; i++) {
        [lastArray addObject:@"未填写*"];
    }
    for (NSDictionary *dic in allOptionArray) {
        if ([dic[@"Required"]integerValue]==1) {
        [lastArray addObject:@"未填写*"];
        }
        else{
        [lastArray addObject:@"未填写"];
                }
    }
    return lastArray;
}

//(
//{
//    ActivityID = 9276;
//    AddTime = "2017-03-20 14:42:16";
//    Amount = 0;
//    Consume = 4;
//    ID = 2747;
//    IsDeleted = 0;
//    Limit = 1000;
//    Title = "\U514d\U8d39\U7968";
//    UserID = 55;
//},
//{
//    ActivityID = 9276;
//    AddTime = "2017-03-20 14:42:16";
//    Amount = 100;
//    Consume = 0;
//    ID = 2748;
//    IsDeleted = 0;
//    Limit = 1000;
//    Title = "\U8d35\U5bbe\U7968";
//    UserID = 55;
//},
//{
//    ActivityID = 9276;
//    AddTime = "2017-05-26 23:47:03";
//    Amount = "0.01";
//    Consume = 1;
//    ID = 5991;
//    IsDeleted = 0;
//    Limit = 10;
//    Title = "\U4f4e\U4ef7\U7968";
//    UserID = 55;
//}
//)

- (NSMutableArray *)getFeeArray :(NSArray *)feeArray
{
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in feeArray) {
        [array addObject:dic[@"Title"]];
    }
    return array;
}

- (NSMutableArray *)getBaseRightArray :(NSArray *)allRight count :(NSInteger )count
{
    NSMutableArray *lastArray = [NSMutableArray array];
    for (int i = 0; i<count; i++) {
        [lastArray addObject:allRight[i]];
    }
    return lastArray;
}

//api/PerActivity/AddActivityList?accessKey={accessKey}&activityFeeid={activityFeeid}
- (void)addPersonNetWork :(NSDictionary *)dic feeid :(NSInteger)feeid
{
    if (ZD_UserM.isAdmin) {
        NSString *postStr = [NSString stringWithFormat:@"%@api/PerActivity/AddActivityList?accessKey=%@&activityFeeid=%li",zhundaoApi,[[ZDSignManager shareManager] getaccseekey],(long)feeid];
        [ZD_NetWorkM postDataWithMethod:postStr parameters:dic succ:^(NSDictionary *obj) {
            NSDictionary *dic = [NSDictionary dictionaryWithDictionary:obj];
            if ([dic[@"Res"] integerValue]==0) {
                _blcok(1);
            }
            else
            {
                _blcok(2);
            }
        } fail:^(NSError *error) {
            _blcok(0);
        }];
    } else {
        NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:dic];
        [param setValue:@(feeid) forKey:@"activityFeeId"];
        NSString *url = [NSString stringWithFormat:@"%@jinTaData?token=%@", zhundaoLogApi, ZD_UserM.token];
        NSDictionary *dic = @{@"BusinessCode": @"AddActivityList",
                              @"Data" : param
        };
        [ZD_NetWorkM postDataWithMethod:url parameters:dic succ:^(NSDictionary *obj) {
            if ([obj[@"res"] boolValue]) {
                _blcok(1);
            } else {
                _blcok(2);
            }
        } fail:^(NSError *error) {
            _blcok(0);
        }];
    }
}

//Printing description of ((__NSDictionaryI *)0x00006000003a39c0):
//{
//    ActivityID = 9276;
//    AddTime = "2017-03-20 14:42:16";
//    Amount = 0;
//    Consume = 4;
//    ID = 2747;
//    IsDeleted = 0;
//    Limit = 1000;
//    Title = "\U514d\U8d39\U7968";
//    UserID = 55;
//}

- (void)getFeeidFromArray :(NSArray *)feeArray selectStr :(NSString *)str feeidBlock : (feeBlock) feeBlock
{
    NSInteger a = 0;
    for (NSDictionary *dic in feeArray) {
        if ([dic[@"Title"] isEqualToString:str]) {
            a = [dic[@"ID"] integerValue];
            feeBlock(a);
            break;
        }
    }
}
@end
