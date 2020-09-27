#import "PGActivityGroupSendViewModel.h"
#import "PGActivityListModel.h"
@implementation PGActivityGroupSendViewModel
#pragma mark ---- network
- (void)PG_openMessage:(ZDSuccessBlock)successBlock error:(ZDErrorBlock)errorBlock{
    NSString *str = [NSString stringWithFormat:@"%@api/App/InstallMessageApp?accesskey=%@&id=3&from=ios",zhundaoApi,[[PGSignManager shareManager]getaccseekey]];
    [ZD_NetWorkM getDataWithMethod:str parameters:nil succ:^(NSDictionary *obj) {
        successBlock(obj);
    } fail:^(NSError *error) {
        errorBlock(error);
    }];
}
- (void)PG_getAdminInfo:(ZDSuccessBlock)successBlock error:(ZDErrorBlock)errorBlock{
    NSString *str = [NSString stringWithFormat:@"%@api/CoreByAccessKey/GetAdminInfo?token=%@",zhundaoMessageApi,[[PGSignManager shareManager] getToken]];
    [ZD_NetWorkM getDataWithMethod:str parameters:nil succ:^(NSDictionary *obj) {
        NSLog(@"responseObject = %@",obj );
        successBlock(obj);
    } fail:^(NSError *error) {
        errorBlock(error);
    }];
}
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
            PGActivityListModel *model = modelArray[indexPath.row];
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
- (void)topUpSMS :(NSString *)password
           count :(NSInteger)count
     successBlock:(ZDSuccessBlock)successBlock
            error:(ZDErrorBlock)errorBlock{
    NSString *str = [NSString stringWithFormat:@"%@api/PerBase/TopUpSMS?accessKey=%@&payPwd=%@&chargeCount=%li",zhundaoApi,[[PGSignManager shareManager]getaccseekey],password,(long)count];
    [ZD_NetWorkM getDataWithMethod:str parameters:nil succ:^(NSDictionary *obj) {
        successBlock(obj);
    } fail:^(NSError *error) {
        errorBlock(error);
    }];
}
- (void)getContent:(ZDSuccessBlock)successBlock
             error:(ZDErrorBlock)errorBlock{
    NSString *str = [NSString stringWithFormat:@"%@api/CoreByAccessKey/selectContent?accessKey=%@",zhundaoMessageApi,[[PGSignManager shareManager]getaccseekey]];
    [ZD_NetWorkM getDataWithMethod:str parameters:nil succ:^(NSDictionary *obj) {
        successBlock(obj);
    } fail:^(NSError *error) {
        errorBlock(error);
    }];
}
#pragma mark --- tableView
- (NSInteger)numberOfRowsInSection:(NSInteger)section{
    if (section==2) {
        return 4;
    }else{
        return 1;
    }
}
- (NSInteger)heightForFooterInSection:(NSInteger)section{
    if (section ==2) {
        return 150;
    }else{
        return 1;
    }
}
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
