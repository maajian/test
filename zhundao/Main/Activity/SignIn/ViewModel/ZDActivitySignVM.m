//
//  ZDActivitySignVM.m
//  zhundao
//
//  Created by maj on 2021/5/12.
//  Copyright © 2021 zhundao. All rights reserved.
//

#import "ZDActivitySignVM.h"

#import "signResult.h"

@implementation ZDActivitySignVM
ZDGetter_MutableArray(dataSource)

- (void)getSignListWithPage:(NSInteger)page activityID:(NSInteger)activityID success:(ZDBlock_Void)success failure:(ZDBlock_Void)failure {
    NSString *url = [NSString stringWithFormat:@"%@api/v2/checkIn/getCheckIns?token=%@",zhundaoApi,[[SignManager shareManager] getToken]];
    NSDictionary *dic = @{@"Type":@"0",
                          @"pageSize":@"20",
                          @"pageIndex":@(page),
                          @"ActivityId":@(activityID)
    };
    ZD_WeakSelf
    [ZD_NetWorkM postDataWithMethod:url parameters:dic succ:^(NSDictionary *obj) {
        if (page == 1) {
            [weakSelf.dataSource removeAllObjects];
        }
        if ([obj[@"errcode"] integerValue] == 0) {
            for (NSDictionary *dic in obj[@"data"]) {
                ZDSignInModel *model = [ZDSignInModel yy_modelWithJSON:dic];
                [self postDataWithSignID:model.ID];
                [weakSelf.dataSource addObject:model];
            }
            [weakSelf saveDataWithActivityID:activityID];
            success();
        } else {
            [self readDataWithActivityID:activityID];
            success();
        }
    } fail:^(NSError *error) {
        [self readDataWithActivityID:activityID];
        success();
    }];
}

- (void)saveDataWithActivityID:(NSInteger)activityID {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.dataSource];
    if (data) {
        [ZD_UserDefaults setObject:data forKey:[NSString stringWithFormat:@"%@ %li", ZDUserDefault_SignList, (long)activityID]];
    }
}
- (void)readDataWithActivityID:(NSInteger)activityID {
    NSData *data = [ZD_UserDefaults objectForKey:[NSString stringWithFormat:@"%@ %li", ZDUserDefault_SignList, (long)activityID]];
    if (data) {
        self.dataSource = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
}
- (void)postDataWithSignID:(NSInteger)signID {
    if ([ZD_UserM hasLocalSign:signID]) {
        [[signResult alloc] postLocalDataWithSignID:signID success:^{
            
        } fail:nil];
    }
}

@end
