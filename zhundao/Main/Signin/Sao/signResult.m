//
//  signResult.m
//  zhundao
//
//  Created by zhundao on 2017/3/6.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "signResult.h"
#import "Time.h"

#import <AudioToolbox/AudioToolbox.h>

#import "LoadallsignModel.h"

@interface signResult()

@end

@implementation signResult

- (void)dealPhoneSignWithSignID:(NSInteger)signID phone:(NSString *)phone Ctr:(UIViewController *)Ctr title1:(NSString *)title1 title2 :(NSString *)title2 action1:(UIAlert)action1 action2 :(UIAlert)action2  {
    [self dealDataWithSignID:signID content:phone signType:ZDSignTypePhone Ctr:Ctr title1:title1 title2:title2 action1:action1 action2:action2];
}
- (void)dealAdminSignWithSignID:(NSInteger)signID phone:(NSString *)phone Ctr:(UIViewController *)Ctr title1:(NSString *)title1 action1:(UIAlert)action1 {
    [self dealDataWithSignID:signID content:phone signType:ZDSignTypeAdmin Ctr:Ctr title1:title1 title2:nil action1:action1 action2:nil];
}
- (void)dealCodeSignWithSignID:(NSInteger)signID vcode:(NSString *)vcode Ctr:(UIViewController *)Ctr title1:(NSString *)title1 title2 :(NSString *)title2 action1:(UIAlert)action1 action2 :(UIAlert)action2  {
    [self dealDataWithSignID:signID content:vcode signType:ZDSignTypeCode Ctr:Ctr title1:title1 title2:title2 action1:action1 action2:action2];
}

- (void)dealDataWithSignID:(NSInteger)signID content:(NSString *)content signType:(ZDSignType)signType Ctr:(UIViewController *)Ctr title1:(NSString *)title1 title2 :(NSString *)title2 action1:(UIAlert)action1 action2 :(UIAlert)action2 {
    // 数据处理
    NSMutableArray *dataArray = ((NSArray *)[ZDCache.sharedCache cacheForKey:[NSString stringWithFormat:@"%@%li", ZDCacheSign_One_List, signID]]).mutableCopy;
    NSArray *signArray = [self saveSignStatusWithData:dataArray content:content type:signType];
    BOOL hasSearch = [signArray.firstObject boolValue];
    BOOL alreadySign = [signArray[1] boolValue];
    LoadallsignModel *model = signArray.lastObject;
    if (!hasSearch) {
        NSString *urlStr = [NSString stringWithFormat:@"%@api/v2/checkIn/checkIn?token=%@", zhundaoApi, [[SignManager shareManager] getToken]];
//        checkInTime
        NSDictionary *params = @{@"content": content, @"type": signType == ZDSignTypeCode ? @(0) : @(1) , @"checkInId": @(signID), @"checkInWay": @(11)};
        [ZD_NetWorkM postDataWithMethod:urlStr parameters:params succ:^(NSDictionary *obj) {
            SystemSoundID soundID = 1102;
            AudioServicesPlaySystemSound(soundID);
            NSDictionary *data;
            if ( ![obj[@"data"] isEqual:[NSNull null]]){
                data = obj[@"data"];
            } else {
                data = [NSDictionary dictionary];
            }
            if (![obj[@"data"] isEqual:[NSNull null]]) {
                [self showSuccessAlertWithSignType:signType data:data title:obj[@"errmsg"] Ctr:Ctr title1:title1 title2:title2 action1:action1 action2:action2];
            } else {
                [self showErrorAlertWithSignType:signType message:obj[@"errmsg"] Ctr:Ctr action1:action1 action2:action2];
            }
            
        } fail:^(NSError *error) {
            [[SignManager shareManager] showNotHaveNet:Ctr.view];
        }];
    } else {
        SystemSoundID soundID = 1102;
        AudioServicesPlaySystemSound(soundID);
        NSDictionary *dic = @{@"name": ZD_SafeStringValue(model.TrueName),
                              @"phone": ZD_SafeStringValue(model.Mobile),
                              @"adminRemark": ZD_SafeStringValue(model.AdminRemark),
                              @"fee": @(model.Fee),
                              @"feeName": ZD_SafeStringValue(model.FeeName)};
        [ZDCache.sharedCache setCache:dataArray forKey:[NSString stringWithFormat:@"%@%li", ZDCacheSign_One_List, signID]];
        [self showSuccessAlertWithSignType:signType data:dic title:alreadySign ? @"重复签到" : @"签到成功" Ctr:Ctr title1:title1 title2:title2 action1:action1 action2:action2];
        [ZD_UserM markLocalSign:signID];
        [self postLocalDataWithSignID:signID success:nil fail:nil];
    }
}

// 保持签到状态本地
- (NSArray *)saveSignStatusWithData:(NSMutableArray *)dataArray content:(NSString *)content type:(ZDSignType)type{
    __block BOOL hasSearch = NO;  // 本地能否搜索到
    __block BOOL alreadySign = NO; // 本地是否已经签过
    __block LoadallsignModel *model = nil;;
    [dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (type == ZDSignTypeCode && [obj[@"VCode"] isEqualToString: content]) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:obj];
            alreadySign = [dic[@"Status"] integerValue] == 1;
            dic[@"Status"] = @(1);
            dic[@"SignTime"] = NSDate.getCurrentDayStr;
            if (!alreadySign) dic[@"needPost"] = @"1";
            [dataArray replaceObjectAtIndex:idx withObject:dic];
            model = [LoadallsignModel yy_modelWithDictionary:dic];
            hasSearch = YES;
            *stop = YES;
        } else if (type != ZDSignTypeCode && [obj[@"Mobile"] isEqualToString: content]) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:obj];
            alreadySign = [dic[@"Status"] integerValue] == 1;
            dic[@"Status"] = @(1);
            dic[@"SignTime"] = NSDate.getCurrentDayStr;
            if (!alreadySign) dic[@"needPost"] = @"1";
            [dataArray replaceObjectAtIndex:idx withObject:dic];
            model = [LoadallsignModel yy_modelWithDictionary:dic];
            hasSearch = YES;
            *stop = YES;
        }
    }];
    return @[@(hasSearch), @(alreadySign), model ? model : [LoadallsignModel new]];
}

- (void)showSuccessAlertWithSignType:(ZDSignType)signType data:(NSDictionary *)data title:(NSString *)title Ctr:(UIViewController *)Ctr title1:(NSString *)title1 title2 :(NSString *)title2 action1:(UIAlert)action1 action2 :(UIAlert)action2 {
    NSString *message = [NSString stringWithFormat:@"%@\n姓名 : %@\n手机 : %@\n", title ,data[@"name"],data[@"phone"]];
    if (ZD_SafeStringValue(data[@"adminRemark"]).length) {
        message = [message stringByAppendingString:[NSString stringWithFormat:@"备注 : %@\n", data[@"adminRemark"]]];
    }
    if (![data[@"feeName"] isEqual:[NSNull null]]) {
        if (ZD_SafeStringValue(data[@"feeName"]).length) {
            message = [message stringByAppendingString:[NSString stringWithFormat:@"费用名称 : %@\n费用 :%.2f", data[@"feeName"],[data[@"fee"] doubleValue]]];
        }
    }
    if (!action2) {
         [[SignManager shareManager]showAlertWithTitle:@"签到结果" WithMessage:message WithTitleOne:title1 WithActionOne:action1 WithAlertStyle:TYAlertActionStyleDefault  WithCTR:Ctr];
    } else {
        if (signType == ZDSignTypeAdmin) {
            [[SignManager shareManager]showAlertWithTitle:@"签到结果" WithMessage:message  WithTitleOne:title1 WithActionOne:action1 WithAlertStyle:(TYAlertActionStyleDefault) WithCTR:Ctr];
        } else {
            [[SignManager shareManager]showAlertWithTitle:@"签到结果" WithMessage:message WithTitleOne:title1 WithActionOne:action1 WithAlertStyle:TYAlertActionStyleDefault WithTitleTwo:title2 WithActionTwo:action2 WithCTR:Ctr];
        }
    }
}

- (void)showErrorAlertWithSignType:(ZDSignType)signType message:(NSString *)message Ctr:(UIViewController *)Ctr action1:(UIAlert)action1 action2 :(UIAlert)action2 {
    if (signType == ZDSignTypeCode) {
        [[SignManager shareManager] showAlertWithTitle:@"提示" WithMessage:message WithTitleOne:@"返回主界面" WithActionOne:action1 WithAlertStyle:(TYAlertActionStyleDefault) WithTitleTwo:@"继续扫码" WithActionTwo:action2 WithCTR:Ctr];
    } else {
        [[SignManager shareManager]showAlertWithTitle:@"提醒" WithMessage:message  WithTitleOne:@"确定" WithActionOne:action1 WithAlertStyle:(TYAlertActionStyleDefault) WithCTR:Ctr];
    }
}
        
- (void)postLocalDataWithSignID:(NSInteger)signID success:(ZDBlock_Void)success fail:(ZDBlock_Void)fail {
    NSMutableArray *dataArray = ((NSArray *)[ZDCache.sharedCache cacheForKey:[NSString stringWithFormat:@"%@%li", ZDCacheSign_One_List, signID]]).mutableCopy;
    
    NSMutableArray *postArray = [NSMutableArray array];
    [dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([ZD_SafeStringValue(obj[@"needPost"])isEqualToString:@"1"]) {
            NSMutableDictionary *postdic = [NSMutableDictionary dictionary];
            [postdic setValue:obj[@"VCode"] forKey:@"VCode"];
            [postdic setValue:obj[@"SignTime"] forKey:@"CheckInTime"];
            [postdic setValue:@"6" forKey:@"CheckInWay"];
            [postArray addObject:postdic];
        }
    }];
    
    NSString *url = [[NSString stringWithFormat:@"%@api/v2/checkIn/batchCheckIn?token=%@&checkId=%li",zhundaoApi, [[SignManager shareManager] getToken], signID] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    if (!postArray.count) {
        ZDDo_Block_Safe_Main(success)
        return;
    }
    NSDictionary *dic = @{@"Data": postArray};
    [ZD_NetWorkM postDataWithMethod:url parameters:dic succ:^(NSDictionary *obj) {
        [ZD_UserM removeLocalSign:signID];
        ZDDo_Block_Safe_Main(success)
    } fail:^(NSError *error) {
        ZDDo_Block_Safe_Main(fail)
    }];
}

@end
