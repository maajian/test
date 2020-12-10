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
            NSArray *list = [NSArray arrayWithArray:obj[@"data"][@"list"]];
            for (NSDictionary *dic in list) {
                ZDMessageMainModel *message = [ZDMessageMainModel yy_modelWithJSON:dic];
                if (![weakSelf.idArray containsObject:@(message.Id)]) {
                    [weakSelf.dataSource addObject:message];
                    [weakSelf.idArray addObject:@(message.Id)];
                }
            }
            weakSelf.isEmpty = weakSelf.dataSource.count == 0;
            weakSelf.isError = NO;
            ZDDo_Block_Safe_Main(success)
        } else {
            weakSelf.isError = YES;
            weakSelf.isEmpty = NO;
            ZDDo_Block_Safe1(failure, obj[@"errmsg"])
        }
    } fail:^(NSError *error) {
        weakSelf.isError = YES;
        weakSelf.isEmpty = NO;
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

@end
