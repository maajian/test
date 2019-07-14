//
//  GroupSendViewModel.m
//  zhundao
//
//  Created by zhundao on 2017/11/2.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "GroupSendViewModel.h"
#import "listModel.h"
@implementation GroupSendViewModel


#pragma mark ---- network
/*! 开通短信 */
//https://open.zhundao.net/api/App/InstallApp?accesskey={accesskey}&id=3&from=ios
- (void)openMessage:(ZDSuccessBlock)successBlock error:(ZDErrorBlock)errorBlock{
    NSString *str = [NSString stringWithFormat:@"%@api/App/InstallMessageApp?accesskey=%@&id=3&from=ios",zhundaoApi,[[SignManager shareManager]getaccseekey]];
    AFmanager *manager = [AFmanager shareManager];
    [manager GET:str parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error);
    }];
}

//api/CoreByAccessKey/adminInfo?accessKey={accessKey}
/*! 获取短信用户信息 这里获取签名*/
- (void)getAdminInfo:(ZDSuccessBlock)successBlock error:(ZDErrorBlock)errorBlock{
    NSString *str = [NSString stringWithFormat:@"%@api/CoreByAccessKey/adminInfo?accessKey=%@",zhundaoMessageApi,[[SignManager shareManager]getaccseekey]];
    AFmanager *manager = [AFmanager shareManager];
    [manager GET:str parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject = %@",responseObject );
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
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
            listModel *model = modelArray[indexPath.row];
            [strArray addObject:model.Mobile];
        }
    }
    NSString *string = [strArray componentsJoinedByString:@","];
    if (string.length==0) {
        return;
    }else{
        NSString *str = [NSString stringWithFormat:@"%@api/core/BatchSendSmsByTemplateNew",zhundaoMessageApi];
        AFmanager *manager = [AFmanager manager];
        NSDictionary *dic = @{@"esid" : @(esid),
                              @"activityId" : @(activityId),
                              @"template" : content,
                              @"phones" : string
                              };
        [manager POST:str parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            successBlock(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
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
    AFmanager *manager =[AFmanager shareManager];
    NSString *str = [NSString stringWithFormat:@"%@api/PerBase/TopUpSMS?accessKey=%@&payPwd=%@&chargeCount=%li",zhundaoApi,[[SignManager shareManager]getaccseekey],password,(long)count];
    [manager GET:str parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error);
    }];
}
- (void)getContent:(ZDSuccessBlock)successBlock
             error:(ZDErrorBlock)errorBlock{
    AFmanager *manager = [AFmanager shareManager];
    NSString *str = [NSString stringWithFormat:@"%@api/CoreByAccessKey/selectContent?accessKey=%@",zhundaoMessageApi,[[SignManager shareManager]getaccseekey]];
    [manager GET:str parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
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
