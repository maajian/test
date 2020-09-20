//
//  ZDActivityGroupSendViewModel.m
//  zhundao
//
//  Created by zhundao on 2017/11/2.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ZDActivityGroupSendViewModel.h"
#import "ZDActivityListModel.h"
@implementation ZDActivityGroupSendViewModel


#pragma mark ---- network
/*! 开通短信 */
//https://open.zhundao.net/api/App/InstallApp?accesskey={accesskey}&id=3&from=ios
- (void)openMessage:(ZDSuccessBlock)successBlock error:(ZDErrorBlock)errorBlock{
    NSString *str = [NSString stringWithFormat:@"%@api/App/InstallMessageApp?accesskey=%@&id=3&from=ios",zhundaoApi,[[ZDSignManager shareManager]getaccseekey]];
    [ZD_NetWorkM getDataWithMethod:str parameters:nil succ:^(NSDictionary *obj) {
        successBlock(obj);
    } fail:^(NSError *error) {
        errorBlock(error);
    }];
}

//api/CoreByAccessKey/adminInfo?accessKey={accessKey}
/*! 获取短信用户信息 这里获取签名*/
- (void)getAdminInfo:(ZDSuccessBlock)successBlock error:(ZDErrorBlock)errorBlock{
    NSString *str = [NSString stringWithFormat:@"%@api/CoreByAccessKey/GetAdminInfo?token=%@",zhundaoMessageApi,[[ZDSignManager shareManager] getToken]];
    [ZD_NetWorkM getDataWithMethod:str parameters:nil succ:^(NSDictionary *obj) {
        NSLog(@"responseObject = %@",obj );
        successBlock(obj);
    } fail:^(NSError *error) {
        errorBlock(error);
    }];
}
/*! 发送 */
- (void)sendWithSelectArray :(NSArray *)selectArray
                 modelArray :(NSArray *)modelArray
                        esid:(NSInteger)esid
                  activityId:(NSInteger)activityId
                    content :(NSString *)content
                successBlock:(ZDSuccessBlock)successBlock
                       error:(ZDErrorBlock)errorBlock {
    NSMutableArray *strArray = [NSMutableArray array];
    for (int i = 0; i<selectArray.count; i++) {
        @autoreleasepool{
            NSIndexPath *indexPath = selectArray[i];
            ZDActivityListModel *model = modelArray[indexPath.row];
            [strArray addObject:model.Mobile];
        }
    }
    NSString *string = [strArray componentsJoinedByString:@","];
    if (string.length==0) {
        return;
    }else{
        NSString *str = [NSString stringWithFormat:@"%@api/core/BatchSendSmsByTemplateNew",zhundaoMessageApi];
        NSDictionary *dic = @{@"esid" : @(esid),
                              @"activityId" : @(activityId),
                              @"template" : content,
                              @"phones" : string
                              };
        
        [ZD_NetWorkM postDataWithMethod:str parameters:dic succ:^(NSDictionary *obj) {
            successBlock(obj);
        } fail:^(NSError *error) {
            errorBlock(error);
        }];
    }
}



/*! 短信充值 */
//api/PerBase/TopUpSMS?accessKey={accessKey}&payPwd={payPwd}&chargeCount={chargeCount}

- (void)topUpSMS :(NSString *)password
           count :(NSInteger)count
     successBlock:(ZDSuccessBlock)successBlock
            error:(ZDErrorBlock)errorBlock{
    NSString *str = [NSString stringWithFormat:@"%@api/PerBase/TopUpSMS?accessKey=%@&payPwd=%@&chargeCount=%li",zhundaoApi,[[ZDSignManager shareManager]getaccseekey],password,(long)count];
    [ZD_NetWorkM getDataWithMethod:str parameters:nil succ:^(NSDictionary *obj) {
        successBlock(obj);
    } fail:^(NSError *error) {
        errorBlock(error);
    }];
}
- (void)getContent:(ZDSuccessBlock)successBlock
             error:(ZDErrorBlock)errorBlock{
    NSString *str = [NSString stringWithFormat:@"%@api/CoreByAccessKey/selectContent?accessKey=%@",zhundaoMessageApi,[[ZDSignManager shareManager]getaccseekey]];
    [ZD_NetWorkM getDataWithMethod:str parameters:nil succ:^(NSDictionary *obj) {
        successBlock(obj);
    } fail:^(NSError *error) {
        errorBlock(error);
    }];
}

#pragma mark --- tableView
/*! row */
- (NSInteger)numberOfRowsInSection:(NSInteger)section{
    if (section==2) {
        return 4;
    }else{
        return 1;
    }
}
/*! 底部高度 */
- (NSInteger)heightForFooterInSection:(NSInteger)section{
    if (section ==2) {
        return 150;
    }else{
        return 1;
    }
}
/*! 头部高度 */
- (NSInteger)heightForHeaderInSection:(NSInteger)section{
    if (section==2) {
        return 30;
    }else{
        return 10;
    }
}

- (NSInteger)heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        return 150;
    }else {
        return 44;
    }
}



@end
