//
//  ListViewModel.m
//  zhundao
//
//  Created by zhundao on 2017/6/20.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ListViewModel.h"

@implementation ListViewModel

//api/PerActivity/DeleteActivityList/{id}?accessKey={accessKey}
- (void)deletePersonWithID:(NSInteger) personID 
{
    NSString *str = [NSString stringWithFormat:@"%@api/PerActivity/DeleteActivityList/%li?accessKey=%@",zhundaoApi,(long)personID,[[SignManager shareManager] getaccseekey]];
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

//POST api/PerActivity/UpdateExamine?accessKey={accessKey}&activityListId={activityListId}&status={status}
- (void)UpdateStatusActivityListId :(NSInteger)activityListId status :(BOOL)status  block :(deleteBlock)block{
    
    NSInteger pass = status? 0 : 3;
    NSString *str = [NSString stringWithFormat:@"%@api/PerActivity/UpdateExamine?accessKey=%@&activityListId=%li&status=%li",zhundaoApi,[[SignManager shareManager] getaccseekey],activityListId,pass];
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

//POST api/PerActivity/PayOffLine?accessKey={accessKey}&activityListId={activityListId}

- (void)PayOffLine :(NSInteger)activityListId block :(deleteBlock)block{
    NSString *str = [NSString stringWithFormat:@"%@api/PerActivity/PayOffLine?accessKey=%@&activityListId=%li",zhundaoApi,[[SignManager shareManager] getaccseekey],activityListId];
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
