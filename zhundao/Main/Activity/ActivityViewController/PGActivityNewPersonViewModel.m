#import "PGActivityNewPersonViewModel.h"
@implementation PGActivityNewPersonViewModel
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
- (void)addPersonNetWork :(NSDictionary *)dic feeid :(NSInteger)feeid
{
    if (ZD_UserM.isAdmin) {
        NSString *postStr = [NSString stringWithFormat:@"%@api/PerActivity/AddActivityList?accessKey=%@&activityFeeid=%li",zhundaoApi,[[PGSignManager shareManager] getaccseekey],(long)feeid];
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
