//
//  ZDMeMessageViewModel.m
//  zhundao
//
//  Created by maj on 2020/12/6.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "ZDMessageMainViewModel.h"

@implementation ZDMessageMainViewModel

- (instancetype)init {
    if (self = [super init]) {
        _dataSource = [NSMutableArray array];
        _idArray = [NSMutableArray array];
    }
    return self;
}
#pragma mark --- network
- (void)getMeMessageListWithPage:(NSInteger)page Success:(ZDBlock_Void)success failure:(ZDBlock_Error_Str)failure {
    NSString *url = [NSString stringWithFormat:@"%@jinTaData?token=%@", zhundaoLogApi, [[SignManager shareManager] getToken]];
    NSDictionary *dic = @{@"BusinessCode": @"GetMessageListForApp",
                          @"Data" : @{
                                  @"PageIndex":@(page),
                                  @"PageSize":@(1000),
                         }
    };
    ZD_WeakSelf
    [ZD_NetWorkM postDataWithMethod:url parameters:dic succ:^(NSDictionary *obj) {
        if (page == 1) {
            [weakSelf.dataSource removeAllObjects];
            [weakSelf.idArray removeAllObjects];
        }
        if (obj[@"data"]) {
            NSArray *list = [NSArray arrayWithArray:obj[@"data"][@"list"]];
            NSInteger count = 0;
            for (NSDictionary *dic in list) {
                ZDMessageMainModel *message = [ZDMessageMainModel yy_modelWithJSON:dic];
                if (![weakSelf.idArray containsObject:@(message.Id)]) {
                    [weakSelf.dataSource addObject:message];
                    [weakSelf.idArray addObject:@(message.Id)];
                }
                if (!message.IsRead) {
                    count = count + 1;
                }
            }
            ZD_UserM.unreadMessage = count;
            weakSelf.isEmpty = weakSelf.dataSource.count == 0;
            weakSelf.isError = NO;
            ZDDo_Block_Safe_Main(success)
        } else {
            ZD_UserM.unreadMessage = ZD_UserM.unreadMessage;
            weakSelf.isError = YES;
            weakSelf.isEmpty = NO;
            ZDDo_Block_Safe1(failure, obj[@"errmsg"])
        }
    } fail:^(NSError *error) {
        weakSelf.isError = YES;
        weakSelf.isEmpty = NO;
        ZD_UserM.unreadMessage = ZD_UserM.unreadMessage;
        ZDDo_Block_Safe1(failure, error.domain)
    }];
}
- (void)setReadMessageWithID:(NSInteger)Id success:(ZDBlock_Void)success failure:(ZDBlock_Error_Str)failure {
    NSString *url = [NSString stringWithFormat:@"%@jinTaData?token=%@", zhundaoLogApi, [[SignManager shareManager] getToken]];
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
// 清除所有未读
- (void)clearAllReadMessageSuccess:(ZDBlock_Void)success failure:(ZDBlock_Error_Str)failure {
    NSString *url = [NSString stringWithFormat:@"%@jinTaData?token=%@", zhundaoLogApi, [[SignManager shareManager] getToken]];
    NSDictionary *dic = @{@"BusinessCode": @"ClearUnReadMessageForApp",
                          @"Data" : @{}
    };
    ZD_WeakSelf
    [ZD_NetWorkM postDataWithMethod:url parameters:dic succ:^(NSDictionary *obj) {
        if ([obj[@"res"] boolValue]) {
            ZD_UserM.unreadMessage = 0;
            [weakSelf.dataSource enumerateObjectsUsingBlock:^(ZDMessageMainModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                obj.IsRead = YES;
            }];
            ZDDo_Block_Safe_Main(success)
        } else {
            ZDDo_Block_Safe_Main1(failure, obj[@"errmsg"])
        }
    } fail:^(NSError *error) {
        ZDDo_Block_Safe_Main1(failure, error.domain)
    }];
}

// 删除消息
- (void)deleteMessageMessageWithID:(NSInteger)Id success:(ZDBlock_Void)success failure:(ZDBlock_Error_Str)failure {
    NSString *url = [NSString stringWithFormat:@"%@jinTaData?token=%@", zhundaoLogApi, [[SignManager shareManager] getToken]];
    NSDictionary *dic = @{@"BusinessCode": @"DeleteMessageForApp",
                          @"Data" : @{
                              @"id":@(Id)
                          }
    };
    ZD_WeakSelf
    [ZD_NetWorkM postDataWithMethod:url parameters:dic succ:^(NSDictionary *obj) {
        if ([obj[@"res"] boolValue]) {
            ZD_UserM.unreadMessage -= 1;
            [weakSelf.dataSource enumerateObjectsUsingBlock:^(ZDMessageMainModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (obj.Id == Id) {
                    [weakSelf.dataSource removeObjectAtIndex:idx];
                    *stop = YES;
                }
            }];
            ZDDo_Block_Safe_Main(success)
        } else {
            ZDDo_Block_Safe_Main1(failure, obj[@"errmsg"])
        }
    } fail:^(NSError *error) {
        ZDDo_Block_Safe_Main1(failure, error.domain)
    }];
}

@end
