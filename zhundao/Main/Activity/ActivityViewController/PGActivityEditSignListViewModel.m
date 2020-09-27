#import "PGActivityEditSignListViewModel.h"
@implementation PGActivityEditSignListViewModel
#pragma 网络
- (void)postDataWithDic :(NSDictionary *)dic {
    NSString *str = [NSString stringWithFormat:@"%@api/PerActivity/UpdateActivityList?accessKey=%@",zhundaoApi,[[PGSignManager shareManager] getaccseekey]];
    [ZD_NetWorkM postDataWithMethod:str parameters:dic succ:^(NSDictionary *obj) {
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:obj];
        if ([dic[@"Res"] integerValue]==0) {
            _postBlock(1);
        }
        else
        {
            _postBlock(0);
        }
    } fail:^(NSError *error) {
        _postBlock(0);
    }];
}
#pragma 逻辑
- (NSMutableArray *)getMustArrayFromArray :(NSArray *)baseArray customArray :(NSArray *)customArray
{
    NSMutableArray *array = [NSMutableArray array];
    [array addObjectsFromArray:baseArray];
    for (NSDictionary *dic in customArray) {
            [array addObject:dic[@"Title"]];
    }
    return array;
}
- (NSMutableArray *)getLeftChooseArrayFromCustomArray :(NSArray *)customArray
{
      NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in customArray) {
        if ([dic[@"Required"]integerValue]==1) {
        }
        else [array addObject:dic[@"Title"]];
    }
    return array;
}
- (NSMutableArray *)getRightMustArray :(NSArray *)baseArray allOptionArray :(NSArray *)allOptionArray dic :(NSDictionary *)optionDic
{
    NSMutableArray *array = [NSMutableArray array];
    NSMutableArray *resultArray = [NSMutableArray array];
    [resultArray addObjectsFromArray:baseArray];
    for (NSDictionary *dic in allOptionArray) {
        if ([dic[@"Required"]integerValue]==1) {
            [array addObject:dic[@"Title"]];
            [resultArray addObject:@"未填写*"];
        }else
        {
            [array addObject:dic[@"Title"]];
            [resultArray addObject:@"未填写"];
        }
    }
    for (int i = 0; i<array.count; i++) {
        for (NSString *keyStr in optionDic.allKeys) {
            if ([keyStr isEqualToString:array[i]]) {
                if ([[optionDic objectForKey:keyStr] isEqualToString:@""]) {
                    [resultArray replaceObjectAtIndex:i+baseArray.count withObject:@"未填写"];
                }else{
                     [resultArray replaceObjectAtIndex:i+baseArray.count withObject:[optionDic objectForKey:keyStr]];
                }
                break;
            }
        }
    }
    return resultArray;
}
- (NSMutableArray *)getRequiredArray :(NSArray *)baseArray allOptionArray :(NSArray *)allOptionArray
{
    NSMutableArray *resultArray = [NSMutableArray array];
    for (int i = 0; i<baseArray.count; i++) {
        [resultArray addObject:@"1"];
    }
    @autoreleasepool {
        for (int i = 0; i<allOptionArray.count; i++) {
            NSDictionary *dic = [allOptionArray[i] copy];
            [resultArray addObject:dic[@"Required"]];
        }
    }
    return resultArray;
}
- (NSMutableArray *)getRightChooseAllOptionArray :(NSArray *)allOptionArray dic :(NSDictionary *)optionDic
{
    NSMutableArray *array = [NSMutableArray array];
    NSMutableArray *resultArray = [NSMutableArray array];
    for (NSDictionary *dic in allOptionArray) {
            [array addObject:dic[@"Title"]];
            [resultArray addObject:@"未填写*"];
    }
    for (int i = 0; i<array.count; i++) {
        for (NSString *keyStr in optionDic.allKeys) {
            if ([keyStr isEqualToString:array[i]]) {
                [resultArray replaceObjectAtIndex:i withObject:[optionDic objectForKey:keyStr]];
                break;
            }
        }
    }
    return resultArray;
}
- (NSDictionary *)getDicWithStr :(NSString *)jsonStr
{
    NSData *data =  [jsonStr dataUsingEncoding:NSUTF8StringEncoding];;
    NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    NSLog(@"dic = %@",dic);
    return dic;
}
-(NSMutableArray *)getMustInputTypeFromArray :(NSArray *)baseNameArray customArray :(NSArray *)customArray
{
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *nameStr in baseNameArray) {
        if ([nameStr isEqualToString:@"手机"]) {
            [array addObject:@(7)];
        }else if ([nameStr isEqualToString:@"性别"])
        {
            [array addObject:@(5)];
        }
        else if ([nameStr isEqualToString:@"备注"])
        {
            [array addObject:@(1)];
        }else if ([nameStr isEqualToString:@"人脸照片"])
        {
            [array addObject:@(4)];
        }
        else
        {
            [array addObject:@(0)];
        }
    }
    for (NSDictionary *dic in customArray) {
            [array addObject:dic[@"InputType"]];
    }
    return array;
}
-(NSMutableArray *)getChooseInputTypeFromCustomArray :(NSArray *)customArray
{
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in customArray) {
        if ([dic[@"Required"]integerValue]==1) {
        }else  {
         [array addObject:dic[@"InputType"]];
        }
    }
    return array;
}
- (NSMutableAttributedString *)setAttrbriteStrWithText:(NSString *)text  
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:text];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:137.0f/256.0f green:137.0f/256.0f blue:137.0f/256.0f alpha:1] range:NSMakeRange(0, 3)];
    if ([text isEqualToString:@"未填写*"]) {
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:230.0f/256.0f green:67.0f/256.0f blue:64.0f/256.0f alpha:1] range:NSMakeRange(3, 1)];
    }
    [str addAttribute:NSFontAttributeName value:KweixinFont(14) range:NSMakeRange(0, text.length)];
    return  str;
}
- (NSArray *)getAllChooseArrayWithStr :(NSString *)titleStr customArray:(NSArray *)customArray
{
    NSMutableArray *array = [NSMutableArray array];
    if ([titleStr isEqualToString:@"性别"]) {
        [array addObject:@"男"];
        [array addObject:@"女"];
    }else{
        for (NSDictionary *dic in customArray) {
            if ([[dic objectForKey:@"Title"] isEqualToString:titleStr]) {
                NSString *str = [dic objectForKey:@"Option"];
                NSArray *comArray = [str componentsSeparatedByString:@"|"];
                array = [comArray mutableCopy];
            }
        }
    }
    return [array copy];
}
- (NSArray *)getNowChooseArrayWithStr :(NSString *)titleStr
{
    NSArray *array = [titleStr componentsSeparatedByString:@"|"];
    return array;
}
- (NSDictionary *)SaveWithRightMustArray :(NSMutableArray *)rightMustArray
                           leftMustArray :(NSMutableArray *)_leftMustArray
                               baseArray :(NSArray *)baseArray
                                    view :(UIView *)view
{
    NSMutableArray *array = [rightMustArray mutableCopy];
    [array removeObject:@""];
    [array removeObject:@"未填写*"];
    int baseCount = (int)baseArray.count;
    if (array.count==_leftMustArray.count) {
        NSLog(@"必填项填写完成");
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        for (int i = baseCount;  i < array.count; i ++) {
            if (![_leftMustArray[i] isEqualToString:@"费用选择"]&&![rightMustArray[i] isEqualToString:@"未填写"]) {
                 [dic setObject:array[i] forKey:_leftMustArray[i]];
            }
        }
        return dic;
    }else
    {
        PGMaskLabel *label = [[PGMaskLabel alloc]initWithTitle:@"请完成必填项"];
        [label labelAnimationWithViewlong:view];
        return nil;
    }
}
- (void)setKeyboardTypeWithtextf : (UITextField *)textf type :(NSInteger) type
{
    if (type==0||type==1) {
        textf.keyboardType = UIKeyboardTypeDefault;
    }else{
        textf.keyboardType = UIKeyboardTypeNumberPad;
    }
}
- (NSMutableArray *)getLastPostArray :(NSArray *)array
{
    NSArray *engArray = @[@"UserName",@"Mobile",@"Sex",@"Company",@"Depart",@"Duty",@"IDcard",@"Industry",@"Email",@"Address",@"Remark",@"FaceImg"];
    NSArray *arr =  @[@"姓名",@"手机",@"性别",@"单位",@"部门",@"职务",@"身份证",@"行业",@"邮箱",@"地址",@"备注",@"人脸照片"];
    NSMutableArray *lastArray = [NSMutableArray array];
    @autoreleasepool {
        for (NSString *numberStr in array) {
            NSString *str = [engArray objectAtIndex:[arr indexOfObject:numberStr]];
            [lastArray addObject:str];
        }
    }
    return lastArray;
}
- (NSInteger )getSexSelectStr :(NSString *)sexStr
{
        if ([sexStr isEqualToString:@"男"]) {
            return 1;
        }else{
            return 2;
        }
}
- (NSMutableArray *)getBaseRightArray :(NSArray *)allRight count :(NSInteger )count
{
    NSMutableArray *lastArray = [NSMutableArray array];
    for (int i = 0; i<count; i++) {
        [lastArray addObject:allRight[i]];
    }
    return lastArray;
}
@end
