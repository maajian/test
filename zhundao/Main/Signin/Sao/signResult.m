//
//  signResult.m
//  zhundao
//
//  Created by zhundao on 2017/3/6.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "signResult.h"
#import "Time.h"
@interface signResult()
{
    MBProgressHUD *hud;
    NSMutableArray *array;
    NSMutableArray *array1;
    NSMutableArray *array2;
    NSMutableArray *dataarr;
    NSMutableArray *dataarr1;
    NSMutableArray *dataarr2;
    BOOL flag;
}
@end
@implementation signResult
- (void)showallWithFMResultSet:(FMResultSet *)rs  withdic:(NSDictionary *)acdic actionWithTitle1:(NSString *)title1 actionWithTitle2:(NSString *)title2  withAction1:(UIAlert)action1 withAction2:(UIAlert)action2 otherSign:(BOOL)otherSign withCtr:(UIViewController *)Ctr
{
    NSString *str = nil;
    if (  [[acdic valueForKey:@"Status"]integerValue]==0) {
        str = @"签到成功";
    }
    
    if ( [[acdic valueForKey:@"Status"]integerValue]==1) {
        str = @"该用户已经签到";
    }
    NSString *name = [acdic valueForKey:@"TrueName"];
    NSString *phone = nil;
    NSString *Mobile =[acdic valueForKey:@"Mobile"];
    if (Mobile.length>7) {
        phone = [Mobile stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    }
    else
    {
        NSMutableString *substr = [[NSMutableString alloc]initWithString:Mobile];
        [substr insertString:@"0000" atIndex:0];
        phone = [substr stringByReplacingCharactersInRange:NSMakeRange(1, 4) withString:@"****"];

    }
    NSString *adminStr = [rs stringForColumn:@"AdminRemark"];
    NSLog(@"adminStr = %@",adminStr);
    
    NSString *feeName = [rs stringForColumn:@"FeeName"];
    NSLog(@"FeeName = %@",[rs stringForColumn:@"FeeName"]);
    double fee = [rs doubleForColumn:@"Fee"];
    NSLog(@"fee = %f", [rs doubleForColumn:@"Fee"]);
    if (![adminStr isEqualToString:@"(null)"]&&![feeName isEqualToString:@"(null)"]) {
        if (otherSign==NO) {
             [[SignManager shareManager]showAlertWithTitle:@"签到结果" WithMessage:[NSString stringWithFormat:@"%@\n姓名 : %@\n手机 : %@\n备注 : %@\n费用名称 : %@\n费用 : %.2f",str,name,phone,adminStr,feeName,fee] WithTitleOne:title1 WithActionOne:action1 WithAlertStyle:TYAlertActionStyleDefault WithTitleTwo:title2 WithActionTwo:action2 WithCTR:Ctr];
        }
        if (otherSign==YES) {
             [[SignManager shareManager]showAlertWithTitle:@"签到结果" WithMessage:[NSString stringWithFormat:@"%@\n姓名 : %@\n手机 : %@\n备注 : %@\n费用名称 : %@\n费用 : %.2f",str,name,phone,adminStr,feeName,fee] WithTitleOne:title1 WithActionOne:action1 WithAlertStyle:TYAlertActionStyleDefault WithCTR:Ctr];
        }
    }
    if ([adminStr isEqualToString:@"(null)"]&&![feeName isEqualToString:@"(null)"]) {
         if (otherSign==NO) {
        
             [[SignManager shareManager]showAlertWithTitle:@"签到结果" WithMessage:[NSString stringWithFormat:@"%@\n姓名 : %@\n手机 : %@\n费用名称 : %@\n费用 : %.2f",str,name,phone,feeName,fee] WithTitleOne:title1 WithActionOne:action1 WithAlertStyle:TYAlertActionStyleDefault WithTitleTwo:title2 WithActionTwo:action2 WithCTR:Ctr];}
        if (otherSign==YES) {
            [[SignManager shareManager]showAlertWithTitle:@"签到结果" WithMessage:[NSString stringWithFormat:@"%@\n姓名 : %@\n手机 : %@\n费用名称 : %@\n费用 : %.2f",str,name,phone,feeName,fee] WithTitleOne:title1 WithActionOne:action1 WithAlertStyle:TYAlertActionStyleDefault  WithCTR:Ctr];
        }
    }
    if (![adminStr isEqualToString:@"(null)"]&&[feeName isEqualToString:@"(null)"]) {
         if (otherSign==NO) {
              [[SignManager shareManager]showAlertWithTitle:@"签到结果" WithMessage:[NSString stringWithFormat:@"%@\n姓名 : %@\n手机 : %@\n备注 : %@",str,name,phone,adminStr] WithTitleOne:title1 WithActionOne:action1 WithAlertStyle:TYAlertActionStyleDefault WithTitleTwo:title2 WithActionTwo:action2 WithCTR:Ctr];
         }
        if (otherSign==YES) {
             [[SignManager shareManager]showAlertWithTitle:@"签到结果" WithMessage:[NSString stringWithFormat:@"%@\n姓名 : %@\n手机 : %@\n备注 : %@",str,name,phone,adminStr] WithTitleOne:title1 WithActionOne:action1 WithAlertStyle:TYAlertActionStyleDefault  WithCTR:Ctr];
        }

    }
    if ([adminStr isEqualToString:@"(null)"]&&[feeName isEqualToString:@"(null)"]) {
        if (otherSign==NO) {
             [[SignManager shareManager]showAlertWithTitle:@"签到结果" WithMessage:[NSString stringWithFormat:@"%@\n姓名 : %@\n手机 : %@",str,name,phone] WithTitleOne:title1 WithActionOne:action1 WithAlertStyle:TYAlertActionStyleDefault WithTitleTwo:title2 WithActionTwo:action2 WithCTR:Ctr];
        }
        if (otherSign==YES) {
             [[SignManager shareManager]showAlertWithTitle:@"签到结果" WithMessage:[NSString stringWithFormat:@"%@\n姓名 : %@\n手机 : %@",str,name,phone] WithTitleOne:title1 WithActionOne:action1 WithAlertStyle:TYAlertActionStyleDefault  WithCTR:Ctr];
        }
    }
    
}

-(void)getDataWithData:(NSDictionary *)Data  WithStringValue:(NSString *)stringValue withID:(NSInteger)signID WithSignBool:(BOOL)signbool withSigncheckInWay:(NSInteger)checkInWay WithPhone:(NSString *)phone Withtitle1 :(NSString *)title1 Withtitle2 :(NSString *)title2 WithAction1 :(UIAlert)action3 WithAction1 :(UIAlert)action4 otherSign:(BOOL)otherSign WithCtr :(UIViewController *)Ctr
{
    NSString *signstr = nil;
    if (signbool==YES) {
        signstr = @"签到成功";
    }
    else
    {
        signstr = @"该用户已经签到";
    }
//    UIAlertController *myAlert = nil;
    NSString *timeStr = [[Time alloc]nextDateWithNumber:0];
    SignManager *manager = [SignManager shareManager];
    [manager createDatabase];
    if ([manager.dataBase open]) {
        if (checkInWay==6) {
            [manager.dataBase executeUpdate:[NSString stringWithFormat:@"UPDATE signList SET Status = '1'  where VCode = '%@' AND signID = %li",stringValue,(long)signID]];   //更新数据库的vcode
            [manager.dataBase executeUpdate:[NSString stringWithFormat:@"UPDATE signList SET post = '1'  where VCode = '%@' AND signID = %li",stringValue,(long)signID]];
            [manager.dataBase executeUpdate:[NSString stringWithFormat:@"UPDATE signList SET addTime = '%@'  where VCode = '%@' AND signID = %li",timeStr,stringValue,(long)signID]];
        }
        if (checkInWay==11) {
            [manager.dataBase executeUpdate:[NSString stringWithFormat:@"UPDATE signList SET Status = '1'  where phone = '%@' AND signID = %li",stringValue,(long)signID]];   //更新数据库的vcode
            [manager.dataBase executeUpdate:[NSString stringWithFormat:@"UPDATE signList SET post = '1'  where phone = '%@' AND signID = %li",stringValue,(long)signID]];
            [ manager.dataBase executeUpdate:[NSString stringWithFormat:@"UPDATE signList SET addTime = '%@'  where phone = '%@' AND signID = %li",timeStr,stringValue,(long)signID]];
        }
        
    }
    if (![[Data valueForKey:@"AdminRemark"] isEqualToString:@""]&&![[Data valueForKey:@"FeeName"] isEqualToString:@""]) {
        if (otherSign==NO) {
         [[SignManager shareManager]showAlertWithTitle:@"签到结果" WithMessage:[NSString stringWithFormat:@"%@\n姓名 : %@\n手机 : %@\n备注 : %@\n费用名称 : %@\n费用 :%.2f",signstr,Data[@"Name"],phone,Data[@"AdminRemark"],Data[@"FeeName"],[Data[@"Fee"] doubleValue]] WithTitleOne:title1 WithActionOne:action3 WithAlertStyle:TYAlertActionStyleDefault WithTitleTwo:title2 WithActionTwo:action4 WithCTR:Ctr];
        }
        if (otherSign ==YES) {
             [[SignManager shareManager]showAlertWithTitle:@"签到结果" WithMessage:[NSString stringWithFormat:@"%@\n姓名 : %@\n手机 : %@\n备注 : %@\n费用名称 : %@\n费用 :%.2f",signstr,Data[@"Name"],phone,Data[@"AdminRemark"],Data[@"FeeName"],[Data[@"Fee"] doubleValue]] WithTitleOne:title1 WithActionOne:action3 WithAlertStyle:TYAlertActionStyleDefault  WithCTR:Ctr];
        }
    }
    if ([[Data valueForKey:@"AdminRemark"] isEqualToString:@""]&&![[Data valueForKey:@"FeeName"] isEqualToString:@""])
    {
        if (otherSign==NO) {
             [[SignManager shareManager]showAlertWithTitle:@"签到结果" WithMessage:[NSString stringWithFormat:@"%@\n姓名 : %@\n手机 : %@\n费用名称 : %@\n费用 : %.2f",signstr,Data[@"Name"],phone,Data[@"FeeName"],[Data[@"Fee"] doubleValue]] WithTitleOne:title1 WithActionOne:action3 WithAlertStyle:TYAlertActionStyleDefault WithTitleTwo:title2 WithActionTwo:action4 WithCTR:Ctr];
        }
        if (otherSign==YES) {
             [[SignManager shareManager]showAlertWithTitle:@"签到结果" WithMessage:[NSString stringWithFormat:@"%@\n姓名 : %@\n手机 : %@\n费用名称 : %@\n费用 : %.2f",signstr,Data[@"Name"],phone,Data[@"FeeName"],[Data[@"Fee"] doubleValue]] WithTitleOne:title1 WithActionOne:action3 WithAlertStyle:TYAlertActionStyleDefault  WithCTR:Ctr];
        }
}
    if (![[Data valueForKey:@"AdminRemark"] isEqualToString:@""]&&[[Data valueForKey:@"FeeName"] isEqualToString:@""])
    {
        if (otherSign==NO) {
            [[SignManager shareManager]showAlertWithTitle:@"签到结果" WithMessage:[NSString stringWithFormat:@"%@\n姓名 : %@\n手机 : %@\n备注 : %@",signstr,Data[@"Name"],phone,Data[@"AdminRemark"]] WithTitleOne:title1 WithActionOne:action3 WithAlertStyle:TYAlertActionStyleDefault WithTitleTwo:title2 WithActionTwo:action4 WithCTR:Ctr];
        }
        if (otherSign==YES) {
            [[SignManager shareManager]showAlertWithTitle:@"签到结果" WithMessage:[NSString stringWithFormat:@"%@\n姓名 : %@\n手机 : %@\n备注 : %@",signstr,Data[@"Name"],phone,Data[@"AdminRemark"]] WithTitleOne:title1 WithActionOne:action3 WithAlertStyle:TYAlertActionStyleDefault  WithCTR:Ctr];
        }
    }
    if ([[Data valueForKey:@"AdminRemark"] isEqualToString:@""]&&[[Data valueForKey:@"FeeName"] isEqualToString:@""])
    {
        if (otherSign==NO) {
            [[SignManager shareManager]showAlertWithTitle:@"签到结果" WithMessage:[NSString stringWithFormat:@"%@\n姓名 : %@\n手机 : %@",signstr,Data[@"Name"],phone] WithTitleOne:title1 WithActionOne:action3 WithAlertStyle:TYAlertActionStyleDefault WithTitleTwo:title2 WithActionTwo:action4 WithCTR:Ctr];
        }
        if (otherSign==YES) {
            [[SignManager shareManager]showAlertWithTitle:@"签到结果" WithMessage:[NSString stringWithFormat:@"%@\n姓名 : %@\n手机 : %@",signstr,Data[@"Name"],phone] WithTitleOne:title1 WithActionOne:action3 WithAlertStyle:TYAlertActionStyleDefault  WithCTR:Ctr];
        }

    }
    
    }





- (void)sureSignWithphoneStr:(NSString *)phoneStr WithView :(UIView*)view WithSignId :(NSInteger)signid WithCtr :(UIViewController *)Ctr WithMaskLabelBool :(BOOL)MaskLabel WithTYaction1:(UIAlert)WillSignAction WithTYaction2:(UIAlert)SignedAction WithTYActionNotNet1:(UIAlert)WillSignAction1 WithTYActionNotNet2:(UIAlert)SignedAction2 maskBlock :(maskBlock)maskBlock
{
   Reachability *r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    array = [[[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"all%li",(long)signid]] mutableCopy];
    array1 = [[[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"sign%li",(long)signid]] mutableCopy];
    array2 = [[[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"signed%li",(long)signid]]mutableCopy];
    if ([r currentReachabilityStatus] ==NotReachable) {
        [self NotReachableWithSignID:signid WithphoneStr:phoneStr WithCtr:Ctr WithMaskLabelBool :(BOOL)MaskLabel WithTYActionNotNet1:WillSignAction1 WithTYActionNotNet2:SignedAction2 maskBlock :maskBlock];
    }
    else 
    {
        hud = [MyHud initWithAnimationType:MBProgressHUDAnimationFade showAnimated:YES UIView:view];
        [self haveNet:signid WithphoneStr:phoneStr WithMaskLabelBool :(BOOL)MaskLabel WithCtr:Ctr WithTYaction1:SignedAction WithTYaction2:WillSignAction maskBlock :maskBlock];
    }
}
- (void)NotReachableWithSignID:(NSInteger)signid WithphoneStr :(NSString *)phoneStr WithCtr :(UIViewController *)Ctr WithMaskLabelBool :(BOOL)MaskLabel WithTYActionNotNet1:(UIAlert)WillSignAction1 WithTYActionNotNet2:(UIAlert)SignedAction2 maskBlock :(maskBlock)maskBlock
{
    NSLog(@"没网");
    FMResultSet *rs =[self searchFMResultSetWithSignID:signid];

    while ([rs next]) {
        if ([[rs stringForColumn:@"phone"] isEqualToString:phoneStr]) {
            flag = 1;
            [self updatapost:signid WithphoneStr:phoneStr];
            
            [self signinwithRs:rs WithphoneStr:phoneStr  WithMaskLabelBool :MaskLabel WithTYActionNotNet1:WillSignAction1 WithTYActionNotNet2:SignedAction2 WithCtr:Ctr maskBlock :maskBlock];
            [self removeObjectWithphoneStr:phoneStr];
        }
        dataarr = [array copy];
        dataarr1 = [array1 copy];
        dataarr2 = [array2 copy];
    }
    if (flag==NO) {
        [self signLost:Ctr WithMaskLabelBool:MaskLabel];
    }
    [[SignManager shareManager].dataBase close];
    [[NSUserDefaults standardUserDefaults]setObject:dataarr forKey:[NSString stringWithFormat:@"all%li",(long)signid]];

    [[NSUserDefaults standardUserDefaults]setObject:dataarr1 forKey:[NSString stringWithFormat:@"sign%li",(long)signid]];
    [[NSUserDefaults standardUserDefaults]setObject:dataarr2 forKey:[NSString stringWithFormat:@"signed%li",(long)signid]];
    [[NSUserDefaults standardUserDefaults]synchronize];
    maskBlock(1);
}
- (void)createmaskLabelWithctr: (UIViewController *)ctr WithTitle: (NSString *)titlestr
{
    maskLabel *label = [[maskLabel alloc]initWithTitle:titlestr];
    [ctr.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(ctr.view);
        make.size.mas_equalTo(CGSizeMake(150, 35));
    }];
    [UIView animateWithDuration:1.5 animations:^{
        label.alpha =0;
    } completion:^(BOOL finished) {
        [label removeFromSuperview];
    }];
}
- (void)xiugaibendiWithphoneStr :(NSString *)phoneStr WithSignID:(NSInteger)signid
{
    for (int j=0; j<array.count; j++) {
        NSDictionary *acdic = [array objectAtIndex:j];
        NSMutableDictionary *e =  [acdic mutableCopy];
        for (NSString *keystr in acdic.allKeys) {
            if ([keystr isEqualToString:@"Mobile"]) {
                NSLog(@"status = %@",[acdic valueForKey:@"Status"]);
                if ([[acdic valueForKey:keystr] isEqualToString:phoneStr]) {
                    if ([[acdic valueForKey:@"Status"]integerValue]==0) {
                        [e  setValue:@"1" forKey:@"Status"];
                        [array removeObjectAtIndex:j];
                        [array insertObject:e atIndex:array2.count];
                        [array2 addObject:e];  //array2   已经签到
                    }
                }
                
            }
        }
    }
    [self removeObjectWithphoneStr:phoneStr];
    dataarr = [array copy];
    dataarr1 = [array1 copy];
    dataarr2 = [array2 copy];
    [[NSUserDefaults standardUserDefaults]setObject:dataarr forKey:[NSString stringWithFormat:@"all%li",(long)signid]];
    
    [[NSUserDefaults standardUserDefaults]setObject:dataarr1 forKey:[NSString stringWithFormat:@"sign%li",(long)signid]];
    [[NSUserDefaults standardUserDefaults]setObject:dataarr2 forKey:[NSString stringWithFormat:@"signed%li",(long)signid]];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}
- (void)signinwithRs:( FMResultSet *)rs WithphoneStr:(NSString *)phoneStr WithMaskLabelBool :(BOOL)MaskLabel WithTYActionNotNet1:(UIAlert)WillSignAction1 WithTYActionNotNet2:(UIAlert)SignedAction2 WithCtr:(UIViewController *)Ctr maskBlock :(maskBlock)maskBlock;
{
    for (int j=0; j<array.count; j++) {
        NSDictionary *acdic = [array objectAtIndex:j];

        NSMutableDictionary *e =  [acdic mutableCopy];

        for (NSString *keystr in acdic.allKeys) {

            if ([keystr isEqualToString:@"Mobile"]) {
                if ([[acdic valueForKey:keystr] isEqualToString:phoneStr]) {

                    if ([[acdic valueForKey:@"Status"]integerValue]==0) {
                        [e  setValue:@"1" forKey:@"Status"];
                        [array removeObjectAtIndex:j];
                        [array insertObject:e atIndex:array2.count];
                        [array2 addObject:e];  //array2   已经签到
                        //                        _sign++;
                        if (MaskLabel) {
                            [self createmaskLabelWithctr:Ctr WithTitle:@"签到成功!"];
                        }
                        else
                        {
                        [self showallWithFMResultSet:rs withdic:acdic actionWithTitle1:@"确定" actionWithTitle2:nil withAction1:WillSignAction1 withAction2:nil otherSign:YES withCtr:Ctr];
                        }
                    }
                    if ([[acdic valueForKey:@"Status"]integerValue]==1) {
                        if (MaskLabel) {
                            [self createmaskLabelWithctr:Ctr WithTitle:@"该用户已经签到!"];
                        }
                        else{
                        [self showallWithFMResultSet:rs withdic:acdic actionWithTitle1:@"确定" actionWithTitle2:nil withAction1:SignedAction2 withAction2:nil otherSign:YES withCtr:Ctr];
                        }
                    }
                }

            }

        }


    }


}
-(void)haveNet:(NSInteger)signid WithphoneStr :(NSString *)phoneStr WithMaskLabelBool :(BOOL)MaskLabel WithCtr:(UIViewController *)Ctr WithTYaction1:(UIAlert)WillSignAction WithTYaction2:(UIAlert)SignedAction maskBlock :(maskBlock)maskBlock
{

    NSString *urlstr = [NSString stringWithFormat:@"%@api/CheckIn/AddCheckInListByPhone?accessKey=%@&phone=%@&checkInId=%li&checkInWay=11",zhundaoApi,[[SignManager shareManager] getaccseekey],phoneStr,(long)signid];
    
    [ZD_NetWorkM getDataWithMethod:urlstr parameters:nil succ:^(NSDictionary *obj) {
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:obj];
        NSLog(@"[[SignManager shareManager] getaccseekey] = %@",[[SignManager shareManager] getaccseekey]);
        NSString *Url = dic[@"Url"];
        NSString *Res = dic[@"Res"];
        NSMutableDictionary *Data = nil;
        if ( ! [dic[@"Data"] isEqual:[NSNull null]]){
            Data =[dic[@"Data"] mutableCopy];
            for (NSString *keystr in Data.allKeys) {
                if ([[Data valueForKey:keystr] isEqual:[NSNull null]]) {
                    [Data setObject:@"" forKey:keystr];
                }
            }
        }
        NSString *phone = nil;
        NSString *Mobile =Data[@"Phone"];
        if (Mobile.length>7) {
            phone = [Mobile stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        }
        [hud hideAnimated:YES];
        if ([Url isEqualToString:@"101"]&&[Res integerValue]==1) {
            if (MaskLabel) {
                [self createmaskLabelWithctr:Ctr WithTitle:@"该用户已经签到!"];
            }
            else{
                [self getDataWithData:Data WithStringValue:phoneStr withID:signid WithSignBool:0 withSigncheckInWay:11 WithPhone:phone Withtitle1:@"确定" Withtitle2:nil WithAction1:SignedAction WithAction1:^(TYAlertAction *action1) {
                    nil;
                } otherSign:YES WithCtr:Ctr];
            }
        }
        else  if ([Url isEqualToString:@"100"]&&[Res integerValue]==0) {
            if (MaskLabel) {
                [self createmaskLabelWithctr:Ctr WithTitle:@"签到成功!"];
                [self xiugaibendiWithphoneStr:phoneStr WithSignID:signid];
                maskBlock(1);
            }
            else{
                [self getDataWithData:Data WithStringValue:phoneStr withID:signid WithSignBool:1 withSigncheckInWay:11 WithPhone:phone Withtitle1:@"确定" Withtitle2:nil WithAction1:WillSignAction WithAction1:^(TYAlertAction *action1) {
                    nil;
                } otherSign:YES WithCtr:Ctr];
                [self xiugaibendiWithphoneStr:phoneStr WithSignID:signid];
            }
        }
        else {
            if (MaskLabel) {
                [self createmaskLabelWithctr:Ctr WithTitle:@"签到失败 凭证码无效"];
            }
            else{
                [[SignManager shareManager]showAlertWithTitle:@"提醒" WithMessage:dic[@"Msg"]  WithTitleOne:@"确定" WithActionOne:^(TYAlertAction *action1) {
                    
                } WithAlertStyle:TYAlertActionStyleDefault  WithCTR:Ctr];
            }
        }
    } fail:^(NSError *error) {
        if (hud) {
            [hud hideAnimated: YES];
        }
        NSLog(@"error = %@",error);
    }];
}

- (void)removeObjectWithphoneStr :(NSString *)phoneStr
{
    for (int j=0; j<array1.count; j++) {
        NSDictionary *acdic = [array1 objectAtIndex:j];

        for (NSString *keystr in acdic.allKeys) {

            if ([keystr isEqualToString:@"Mobile"]) {
                if ([[acdic valueForKey:keystr] isEqualToString:phoneStr])  {

                    [array1 removeObjectAtIndex:j];
                    break;
                }
            }
        }


    }
}
- (void)signLost :(UIViewController *)Ctr WithMaskLabelBool :(BOOL)MaskLabel
{
    if (MaskLabel) {
        [self createmaskLabelWithctr:Ctr WithTitle:@"签到失败 凭证码无效"];
    }
    else{
    [[SignManager shareManager]showAlertWithTitle:@"提醒" WithMessage:@"签到失败 凭证码无效" WithTitleOne:@"确定" WithActionOne:^(TYAlertAction *action1) {
        nil;
    } WithAlertStyle:TYAlertActionStyleDefault WithTitleTwo:nil WithActionTwo:nil WithCTR:Ctr];
    }
}
- (void)updatapost :(NSInteger)_signid WithphoneStr  :(NSString *)phoneStr
{
    NSString *timeStr = [[Time alloc]nextDateWithNumber:0];
    [ [SignManager shareManager].dataBase executeUpdate:[NSString stringWithFormat:@"UPDATE signList SET Status = '1'  where phone = '%@' AND signID = %li",phoneStr,(long)_signid]];   //更新数据库的vcode
    [ [SignManager shareManager].dataBase executeUpdate:[NSString stringWithFormat:@"UPDATE signList SET post = '0'  where phone = '%@' AND signID = %li",phoneStr,(long)_signid]];
    [ [SignManager shareManager].dataBase executeUpdate:[NSString stringWithFormat:@"UPDATE signList SET addTime = '%@'  where phone = '%@' AND signID = %li",timeStr,phoneStr,(long)_signid]];
}

- (FMResultSet *)searchFMResultSetWithSignID:(NSInteger)_signid
{
    SignManager *manager = [SignManager shareManager];
    FMResultSet * rs = nil;
    [manager createDatabase];
    if ([manager.dataBase open]) {

        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM signList WHERE signID = %li",(long)_signid];
        rs = [manager.dataBase executeQuery:sql];
    }
    return rs;
}
@end
