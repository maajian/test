//
//  PGMeMessageViewModel.m
//  jingjing
//
//  Created by maj on 2020/8/10.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "PGMeMessageViewModel.h"

@implementation PGMeMessageViewModel
- (instancetype)init {
    if (self = [super init]) {
        _dataSource = [NSMutableArray array];
        _idArray = [NSMutableArray array];
    }
    return self;
}

#pragma mark --- network
// 获取消息列表
- (void)getMeMessageListWithPage:(NSInteger)page Success:(ZDBlock_Void)success failure:(ZDBlock_Error_Str)failure {
    NSString *url = [NSString stringWithFormat:@"%@jinTaData?token=%@", zhundaoLogApi,ZD_UserM.token];
    NSDictionary *dic = @{@"BusinessCode": @"GetMessageListForApp",
                          @"Data" : @{
                                  @"PageIndex":@(page),
                                  @"PageSize":@(10),
                         }
    };
    ZD_WeakSelf
    [ZD_NetWorkM postDataWithMethod:url parameters:dic succ:^(NSDictionary *obj) {
        if (page == 1) {
            [weakSelf.dataSource removeAllObjects];
            [weakSelf.idArray removeAllObjects];
        }
        if (obj[@"data"]) {
            for (NSDictionary *dic in obj[@"data"][@"list"]) {
                PGMeMessageModel *message = [PGMeMessageModel yy_modelWithJSON:dic];
                if (![weakSelf.idArray containsObject:@(message.Id)]) {
                    [weakSelf.dataSource addObject:message];
                    [weakSelf.idArray addObject:@(message.Id)];
                }
            }
            ZDDo_Block_Safe_Main(success)
        } else {
            ZDDo_Block_Safe1(failure, obj[@"errmsg"])
        }
    } fail:^(NSError *error) {
        ZDDo_Block_Safe1(failure, error.domain)
    }];
}
// 更新消息为已读（app端）
- (void)setReadMessageWithID:(NSInteger)Id success:(ZDBlock_Void)success failure:(ZDBlock_Error_Str)failure {
    NSString *url = [NSString stringWithFormat:@"%@jinTaData?token=%@", zhundaoLogApi, ZD_UserM.token];
    NSDictionary *dic = @{@"BusinessCode": @"UpdateMessageReadForApp",
                          @"Data" : @{
                                  @"id":@(Id),
                         }
    };
    [ZD_NetWorkM postDataWithMethod:url parameters:dic succ:^(NSDictionary *obj) {
        if ([obj[@"res"] boolValue]) {
            ZDDo_Block_Safe_Main(success)
        } else {
            ZDDo_Block_Safe_Main1(failure, obj[@"errmsg"])
        }
    } fail:^(NSError *error) {
        ZDDo_Block_Safe_Main1(failure, error.domain)
    }];
}

@end
