#import "PGCaseInsensitiveSearch.h"
#import "PGSignResult.h"
#import "Time.h"
#import <AudioToolbox/AudioToolbox.h>
#import "PGSignInLoadallsignModel.h"
#import "PGDiscoverPrintVM.h"
@interface PGSignResult() {
    BOOL _canPrint;
}
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) PGSignInLoadallsignModel *model;
@end
@implementation PGSignResult
- (void)dealPhoneSignWithSignID:(NSInteger)signID phone:(NSString *)phone action1:(ZDBlock_Void)action1  {
    [self PG_dealDataWithSignID:signID content:phone signType:PGSignTypePhone action1:action1];
}
- (void)dealAdminSignWithSignID:(NSInteger)signID phone:(NSString *)phone action1:(ZDBlock_Void)action1 {
dispatch_async(dispatch_get_main_queue(), ^{
    NSMutableArray *imagePickerControllerM8= [NSMutableArray arrayWithCapacity:0];
        UIImage *sectionHeaderHeightf1= [UIImage imageNamed:@""]; 
    PGCaseInsensitiveSearch *deliveryModeAutomatic= [[PGCaseInsensitiveSearch alloc] init];
[deliveryModeAutomatic reusablePhotoViewWithshrinkRightBottom:imagePickerControllerM8 levalInfoModel:sectionHeaderHeightf1 ];
});
    [self PG_dealDataWithSignID:signID content:phone signType:PGSignTypeAdmin action1:action1];
}
- (void)dealCodeSignWithSignID:(NSInteger)signID vcode:(NSString *)vcode action1:(ZDBlock_Void)action1 {
dispatch_async(dispatch_get_main_queue(), ^{
    NSMutableArray *statusBackgroundColorW0= [NSMutableArray array];
        UIImage *photoWidthSelectableL3= [UIImage imageNamed:@""]; 
    PGCaseInsensitiveSearch *trackTintColor= [[PGCaseInsensitiveSearch alloc] init];
[trackTintColor reusablePhotoViewWithshrinkRightBottom:statusBackgroundColorW0 levalInfoModel:photoWidthSelectableL3 ];
});
    [self PG_dealDataWithSignID:signID content:vcode signType:PGSignTypeCode action1:action1];
}
- (void)PG_dealDataWithSignID:(NSInteger)signID content:(NSString *)content signType:(PGSignType)signType action1:(ZDBlock_Void)action1 {
    _canPrint = [[[NSUserDefaults standardUserDefaults]objectForKey:@"GradeId"]integerValue]>=4&&[[NSUserDefaults standardUserDefaults]boolForKey:@"printFlag"];
    _dataArray = ((NSArray *)[PGCache.sharedCache cacheForKey:[NSString stringWithFormat:@"%@%li", PGCacheSign_One_List, signID]]).mutableCopy;
    NSArray *signArray = [self PG_saveSignStatusWithContent:content type:signType];
    BOOL hasSearch = [signArray.firstObject boolValue];
    BOOL alreadySign = [signArray[1] boolValue];
    _model = signArray.lastObject;
    if (!hasSearch) {
        NSString *urlStr = [NSString stringWithFormat:@"%@api/v2/checkIn/checkIn?token=%@", zhundaoApi, [[PGSignManager shareManager] getToken]];
        NSDictionary *params = @{@"content": content, @"type": signType == PGSignTypeCode ? @(0) : @(1) , @"checkInId": @(signID), @"checkInWay": @(11)};
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
                titleColor = [obj[@"errcode"] integerValue] == 0 ? ZDMainColor : ZDYellowColor;
                [self PG_showSuccessAlertWithSignType:signType data:data title:obj[@"errmsg"] titleColor:titleColor action1:action1];
            } else {
                [self PG_showErrorAlertWithSignType:signType message:obj[@"errmsg"] action1:action1];
            }
        } fail:^(NSError *error) {
            [[PGSignManager shareManager] showNotHaveNet:UIApplication.sharedApplication.keyWindow];
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
        [PGCache.sharedCache setCache:_dataArray forKey:[NSString stringWithFormat:@"%@%li", PGCacheSign_One_List, signID]];
        [self PG_showSuccessAlertWithSignType:signType data:dic title:alreadySign ? @"重复签到" : @"签到成功" titleColor:alreadySign ? ZDYellowColor: ZDMainColor action1:action1];
        [ZD_UserM markLocalSign:signID];
        [self postLocalDataWithSignID:signID success:nil fail:nil];
    }
}
- (NSArray *)PG_saveSignStatusWithContent:(NSString *)content type:(PGSignType)type{
    __block BOOL hasSearch = NO;  
    __block BOOL alreadySign = NO; 
    __block PGSignInLoadallsignModel *model = nil;;
    [_dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (type == PGSignTypeCode && [obj[@"VCode"] isEqualToString: content]) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:obj];
            alreadySign = [dic[@"Status"] integerValue] == 1;
            dic[@"Status"] = @(1);
            dic[@"checkInTime"] = NSDate.getCurrentDayStr;
            if (!alreadySign) dic[@"needPost"] = @"1";
            [_dataArray replaceObjectAtIndex:idx withObject:dic];
            model = [PGSignInLoadallsignModel yy_modelWithDictionary:dic];
            hasSearch = YES;
            *stop = YES;
        } else if (type != PGSignTypeCode && [obj[@"Mobile"] isEqualToString: content]) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:obj];
            alreadySign = [dic[@"Status"] integerValue] == 1;
            dic[@"Status"] = @(1);
            dic[@"checkInTime"] = NSDate.getCurrentDayStr;
            if (!alreadySign) dic[@"needPost"] = @"1";
            [_dataArray replaceObjectAtIndex:idx withObject:dic];
            model = [PGSignInLoadallsignModel yy_modelWithDictionary:dic];
            hasSearch = YES;
            *stop = YES;
        }
    }];
    return @[@(hasSearch), @(alreadySign), model ? model : [PGSignInLoadallsignModel new]];
}
- (void)PG_showSuccessAlertWithSignType:(PGSignType)signType data:(NSDictionary *)data title:(NSString *)title titleColor:(UIColor *)titleColor action1:(ZDBlock_Void)action1{
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
    [PGSignAlertView alertWithTitle:title titleColor:titleColor messageTitle:message cancelTitle:signType == PGSignTypeCode ? @"继续扫码" : @"确定" sureTitle:title2 cancelBlock:action1 sureBlock:^{
        [self PG_printWithDic:data];
        action1();
    }];
}
- (void)PG_showErrorAlertWithSignType:(PGSignType)signType message:(NSString *)message action1:(ZDBlock_Void)action1 {
dispatch_async(dispatch_get_main_queue(), ^{
    NSMutableArray *activityListWithZ4= [NSMutableArray arrayWithCapacity:0];
        UIImage *columnistCategoryModelP7= [UIImage imageNamed:@""]; 
    PGCaseInsensitiveSearch *settingTableView= [[PGCaseInsensitiveSearch alloc] init];
[settingTableView reusablePhotoViewWithshrinkRightBottom:activityListWithZ4 levalInfoModel:columnistCategoryModelP7 ];
});
    if (signType == PGSignTypeCode) {
       PGSignAlertView *alert = [PGSignAlertView alertWithTitle:@"凭证码无效" titleColor:ZDRedColor messageTitle:@"" cancelTitle:@"继续扫码" sureTitle:@"" cancelBlock:action1 sureBlock:^{
            action1();
        }];
        alert.messageAlignment = NSTextAlignmentCenter;
    } else {
        PGSignAlertView *alert = [PGSignAlertView alertWithTitle:@"凭证码无效" titleColor:ZDRedColor messageTitle:@"" cancelTitle:@"确定" sureTitle:@"" cancelBlock:action1 sureBlock:^{
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
    NSString *url = [[NSString stringWithFormat:@"%@api/v2/checkIn/batchCheckIn?token=%@&checkId=%li",zhundaoApi, [[PGSignManager shareManager] getToken], signID] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
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
- (void)PG_printWithDic:(NSDictionary *)dic {
    PGDiscoverPrintVM *printVM = [[PGDiscoverPrintVM alloc]init];
    NSArray *modelselArray = [printVM getModel];
    NSInteger index = [modelselArray indexOfObject:@"1"];
    int offsetx = [[[NSUserDefaults standardUserDefaults]objectForKey:@"printX"] intValue];
    int offsety = [[[NSUserDefaults standardUserDefaults]objectForKey:@"printY"] intValue];
    if (index ==0) {  
        [printVM printQRCode:dic[@"vCode"] ? dic[@"vCode"] : _model.VCode isPrint:YES offsetx:offsetx offsety:offsety];
    }else{  
        [printVM printQRCode:dic[@"vCode"] ? dic[@"vCode"] : _model.VCode name:dic[@"name"] isPrint:YES offsetx:offsetx offsety:offsety];
    }
    [self PG_postPrintLogWithDic:dic];
}
- (void)PG_postPrintLogWithDic:(NSDictionary *)dic {
    NSString *urlStr = [NSString stringWithFormat:@"%@zhundao2b?token=%@", zhundaoLogApi,[[PGSignManager shareManager] getToken]];
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
