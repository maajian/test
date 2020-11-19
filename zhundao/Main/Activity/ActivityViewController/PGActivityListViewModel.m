#import "PGActivityListViewModel.h"
@implementation PGActivityListViewModel
- (void)deletePersonWithID:(NSInteger) personID 
{
    NSString *str = [NSString stringWithFormat:@"%@api/PerActivity/DeleteActivityList/%li?accessKey=%@",zhundaoApi,(long)personID,[[PGSignManager shareManager] getaccseekey]];
    [ZD_NetWorkM getDataWithMethod:str parameters:nil succ:^(NSDictionary *obj) {
        NSLog(@"responseObject = %@",obj);
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:obj];
        if ([dic[@"Res"] integerValue]==0) {
            if (_deleteBlock) _deleteBlock(1);
        }
        else
        {
            if (_deleteBlock) _deleteBlock(2);
        }
    } fail:^(NSError *error) {
        NSLog(@"error = %@",error);
        if (_deleteBlock) _deleteBlock(0);
    }];
}
- (void)UpdateStatusActivityListId :(NSInteger)activityListId status :(BOOL)status  block :(deleteBlock)block{
    NSInteger pass = status? 0 : 3;
    NSString *str = [NSString stringWithFormat:@"%@api/v2/activity/updateExamine?token=%@&activityListId=%li&status=%li",zhundaoApi,[[PGSignManager shareManager] getToken],activityListId,pass];
    [ZD_NetWorkM postDataWithMethod:str parameters:nil succ:^(NSDictionary *obj) {
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:obj];
        if ([dic[@"errcode"]integerValue]==0) {
            block(1);
        }else{
            block(0);
        }
    } fail:^(NSError *error) {
        
    }];
}
- (void)PayOffLine :(NSInteger)activityListId block :(deleteBlock)block{
    NSString *str = [NSString stringWithFormat:@"%@api/PerActivity/PayOffLine?accessKey=%@&activityListId=%li",zhundaoApi,[[PGSignManager shareManager] getaccseekey],activityListId];
    [ZD_NetWorkM postDataWithMethod:str parameters:nil succ:^(NSDictionary *obj) {
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:obj];
        if ([dic[@"Res"]integerValue]==0) {
            block(1);
        }else{
            block(0);
        }
    } fail:^(NSError *error) {
    }];
}
@end
