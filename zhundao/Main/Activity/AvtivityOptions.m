//
//  AvtivityOptions.m
//  zhundao
//
//  Created by zhundao on 2017/4/13.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "AvtivityOptions.h"

@implementation AvtivityOptions

- (void)networkWithActivityId:(NSInteger)activityId success:(optionBlock)success failure:(ZDBlock_Void)failure
{
    NSString *str = [NSString stringWithFormat:@"%@api/v2/activity/getActivityOptionList?token=%@&activityId=%li",zhundaoApi,[[SignManager shareManager] getToken], (long)activityId];
    DDLogVerbose(@"str = %@",str);
    NSMutableArray *extraInfoArray = [NSMutableArray array];
    NSMutableArray *userInfoArray = [NSMutableArray array];
    [ZD_NetWorkM getDataWithMethod:str parameters:nil succ:^(NSDictionary *obj) {
        for (NSDictionary *dic in obj[@"data"][@"extraInfo"]) {
            ZDActivityOptionModel *model = [ZDActivityOptionModel yy_modelWithDictionary:dic];
            [extraInfoArray addObject:model];
        }
        for (NSDictionary *dic in obj[@"data"][@"userInfo"]) {
            ZDActivityOptionModel *model = [ZDActivityOptionModel yy_modelWithDictionary:dic];
            [userInfoArray addObject:model];
        }
        success(userInfoArray, extraInfoArray);
    } fail:^(NSError *error) {
        failure();
    }];
}
@end
