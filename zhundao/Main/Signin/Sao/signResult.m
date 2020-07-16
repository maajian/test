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
#import "PrintVM.h"

@interface signResult() {
    BOOL _canPrint;
}
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) LoadallsignModel *model;

@end

@implementation signResult

- (void)dealPhoneSignWithSignID:(NSInteger)signID phone:(NSString *)phone action1:(ZDBlock_Void)action1  {
    [self dealDataWithSignID:signID content:phone signType:ZDSignTypePhone action1:action1];
}
- (void)dealAdminSignWithSignID:(NSInteger)signID phone:(NSString *)phone action1:(ZDBlock_Void)action1 {
    [self dealDataWithSignID:signID content:phone signType:ZDSignTypeAdmin action1:action1];
}
- (void)dealCodeSignWithSignID:(NSInteger)signID vcode:(NSString *)vcode action1:(ZDBlock_Void)action1 {
    [self dealDataWithSignID:signID content:vcode signType:ZDSignTypeCode action1:action1];
}

- (void)dealDataWithSignID:(NSInteger)signID content:(NSString *)content signType:(ZDSignType)signType action1:(ZDBlock_Void)action1 {
    // 数据处理
    _canPrint = [[[NSUserDefaults standardUserDefaults]objectForKey:@"GradeId"]integerValue]>=4&&[[NSUserDefaults standardUserDefaults]boolForKey:@"printFlag"];
    _dataArray = ((NSArray *)[ZDCache.sharedCache cacheForKey:[NSString stringWithFormat:@"%@%li", ZDCacheSign_One_List, signID]]).mutableCopy;
    NSArray *signArray = [self saveSignStatusWithContent:content type:signType];
    BOOL hasSearch = [signArray.firstObject boolValue];
    BOOL alreadySign = [signArray[1] boolValue];
    _model = signArray.lastObject;
    if (!hasSearch) {
        NSString *urlStr = [NSString stringWithFormat:@"%@api/v2/checkIn/checkIn?token=%@", zhundaoApi, [[ZDDataManager shareManager] getToken]];
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
            UIColor *titleColor = nil;
            
            if (![obj[@"data"] isEqual:[NSNull null]]) {
                titleColor = [obj[@"errcode"] integerValue] == 0 ? ZDGreenColor : ZDYellowColor;
                [self showSuccessAlertWithSignType:signType data:data title:obj[@"errmsg"] titleColor:titleColor action1:action1];
            } else {
                [self showErrorAlertWithSignType:signType message:obj[@"errmsg"] action1:action1];
            }
        } fail:^(NSError *error) {
            [[ZDDataManager shareManager] showNotHaveNet:UIApplication.sharedApplication.keyWindow];
        }];
    } else {
        SystemSoundID soundID = 1102;
        AudioServicesPlaySystemSound(soundID);
        NSDictionary *dic = @{@"name": ZD_SafeStringValue(_model.TrueName),
                              @"phone": ZD_SafeStringValue(_model.Mobile),
                              @"adminRemark": ZD_SafeStringValue(_model.AdminRemark),
                              @"fee": @(_model.Fee),
                              @"feeName": ZD_SafeStringValue(_model.FeeName),
                              @"vCode": ZD_SafeValue(_model.VCode),
                              @"checkInTime": NSDate.getCurrentDayStr
                              };
        [ZDCache.sharedCache setCache:_dataArray forKey:[NSString stringWithFormat:@"%@%li", ZDCacheSign_One_List, signID]];
        [self showSuccessAlertWithSignType:signType data:dic title:alreadySign ? @"重复签到" : @"签到成功" titleColor:alreadySign ? ZDYellowColor: ZDGreenColor action1:action1];
        [ZD_UserM markLocalSign:signID];
        [self postLocalDataWithSignID:signID success:nil fail:nil];
    }
}

// 保持签到状态本地
- (NSArray *)saveSignStatusWithContent:(NSString *)content type:(ZDSignType)type{
    __block BOOL hasSearch = NO;  // 本地能否搜索到
    __block BOOL alreadySign = NO; // 本地是否已经签过
    __block LoadallsignModel *model = nil;;
    [_dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (type == ZDSignTypeCode && [obj[@"VCode"] isEqualToString: content]) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:obj];
            alreadySign = [dic[@"Status"] integerValue] == 1;
            dic[@"Status"] = @(1);
            dic[@"checkInTime"] = NSDate.getCurrentDayStr;
            if (!alreadySign) dic[@"needPost"] = @"1";
            [_dataArray replaceObjectAtIndex:idx withObject:dic];
            model = [LoadallsignModel yy_modelWithDictionary:dic];
            hasSearch = YES;
            *stop = YES;
        } else if (type != ZDSignTypeCode && [obj[@"Mobile"] isEqualToString: content]) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:obj];
            alreadySign = [dic[@"Status"] integerValue] == 1;
            dic[@"Status"] = @(1);
            dic[@"checkInTime"] = NSDate.getCurrentDayStr;
            if (!alreadySign) dic[@"needPost"] = @"1";
            [_dataArray replaceObjectAtIndex:idx withObject:dic];
            model = [LoadallsignModel yy_modelWithDictionary:dic];
            hasSearch = YES;
            *stop = YES;
        }
    }];
    return @[@(hasSearch), @(alreadySign), model ? model : [LoadallsignModel new]];
}

- (void)showSuccessAlertWithSignType:(ZDSignType)signType data:(NSDictionary *)data title:(NSString *)title titleColor:(UIColor *)titleColor action1:(ZDBlock_Void)action1{
    NSString *message = [NSString stringWithFormat:@"姓名 : %@\n手机 : %@\n",data[@"name"],data[@"phone"]];
    if (ZD_SafeStringValue(data[@"adminRemark"]).length) {
        message = [message stringByAppendingString:[NSString stringWithFormat:@"备注 : %@\n", data[@"adminRemark"]]];
    }
    if (![data[@"feeName"] isEqual:[NSNull null]]) {
        if (ZD_SafeStringValue(data[@"feeName"]).length) {
            message = [message stringByAppendingString:[NSString stringWithFormat:@"费用名称 : %@\n费用 :%.2f", data[@"feeName"],[data[@"fee"] doubleValue]]];
        }
    }
    NSString *title2 = _canPrint ? @"蓝牙打印" : @"";
    [ZDSignAlertView alertWithTitle:title titleColor:titleColor messageTitle:message cancelTitle:signType == ZDSignTypeCode ? @"继续扫码" : @"确定" sureTitle:title2 cancelBlock:action1 sureBlock:^{
        [self printWithDic:data];
        action1();
    }];
}

- (void)showErrorAlertWithSignType:(ZDSignType)signType message:(NSString *)message action1:(ZDBlock_Void)action1 {
    if (signType == ZDSignTypeCode) {
       ZDSignAlertView *alert = [ZDSignAlertView alertWithTitle:@"凭证码无效" titleColor:ZDRedColor messageTitle:@"" cancelTitle:@"继续扫码" sureTitle:@"" cancelBlock:action1 sureBlock:^{
            action1();
        }];
        alert.messageAlignment = NSTextAlignmentCenter;
    } else {
        ZDSignAlertView *alert = [ZDSignAlertView alertWithTitle:@"凭证码无效" titleColor:ZDRedColor messageTitle:@"" cancelTitle:@"确定" sureTitle:@"" cancelBlock:action1 sureBlock:^{
            action1();
        }];
        alert.messageAlignment = NSTextAlignmentCenter;
    }
}
        
- (void)postLocalDataWithSignID:(NSInteger)signID success:(ZDBlock_Void)success fail:(ZDBlock_Void)fail {
    NSMutableArray *postArray = [NSMutableArray array];
    [_dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([ZD_SafeStringValue(obj[@"needPost"])isEqualToString:@"1"]) {
            NSMutableDictionary *postdic = [NSMutableDictionary dictionary];
            [postdic setValue:obj[@"VCode"] forKey:@"VCode"];
            [postdic setValue:obj[@"checkInTime"] forKey:@"CheckInTime"];
            [postdic setValue:@"6" forKey:@"CheckInWay"];
            [postArray addObject:postdic];
        }
    }];
    
    NSString *url = [[NSString stringWithFormat:@"%@api/v2/checkIn/batchCheckIn?token=%@&checkId=%li",zhundaoApi, [[ZDDataManager shareManager] getToken], signID] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
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

#pragma mark --- Print
- (void)printWithDic:(NSDictionary *)dic {
    PrintVM *printvm = [[PrintVM alloc]init];
    NSArray *modelselArray = [printvm getModel];
    NSInteger index = [modelselArray indexOfObject:@"1"];
    int offsetx = [[[NSUserDefaults standardUserDefaults]objectForKey:@"printX"] intValue];
    int offsety = [[[NSUserDefaults standardUserDefaults]objectForKey:@"printY"] intValue];
    if (index ==0) {  // 打印二维码
        [printvm printQRCode:dic[@"vCode"] ? dic[@"vCode"] : _model.VCode isPrint:YES offsetx:offsetx offsety:offsety];
    }else{  //打印二维码加姓名
        [printvm printQRCode:dic[@"vCode"] ? dic[@"vCode"] : _model.VCode name:dic[@"name"] isPrint:YES offsetx:offsetx offsety:offsety];
    }
    [self postPrintLogWithDic:dic];
}

- (void)postPrintLogWithDic:(NSDictionary *)dic {
    NSString *urlStr = [NSString stringWithFormat:@"%@zhundao2b?token=%@", zhundaoLogApi,[[ZDDataManager shareManager] getToken]];
    NSDictionary *params = @{@"BusinessCode": @"Log_InsertUserLog",
                             @"Data": @{
                                     @"ActivityId": @(_model.ActivityListID),
                                     @"AdminUserId": @(ZD_UserM.userID),
                                     @"UserId": @(_model.UserID),
                                     @"VCode": dic[@"vCode"] ? dic[@"vCode"] : _model.VCode,
                                     @"AddTime" : dic[@"checkInTime"] ? dic[@"checkInTime"] : _model.SignTime,
                                     @"From" : @"IOS"
                                     }
                             };
    [ZD_NetWorkM postDataWithMethod:urlStr parameters:params succ:^(NSDictionary *obj) {
        
        NSLog(@"succsss --- ");
    } fail:^(NSError *error) {
        NSLog(@"error --- ");
    }];
}

@end
