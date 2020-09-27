#import "PGOrganizeListRequset.h"
#import "PGActivityViewModel.h"
#import "PGMeMessageModel.h"
@interface PGActivityViewModel()
@property (nonatomic, assign) PGActivityType activityType;
@end
@implementation PGActivityViewModel
- (instancetype)initWithType:(PGActivityType)activityType {
    if (self = [super init]) {
        self.activityType = activityType;
        switch (activityType) {
            case PGActivityTypeAll:
                _allDataArray = [NSMutableArray array];
                _allSearchArray = [NSMutableArray array];
                _allTitleArray = [NSMutableArray array];
                break;
            case PGActivityTypeOn:
                _onDataArray = [NSMutableArray array];
                _onTitleArray = [NSMutableArray array];
                _onSearchArray = [NSMutableArray array];
            default:
                _closeDataArray = [NSMutableArray array];
                _closeTitleArray = [NSMutableArray array];
                _closeSearchArray = [NSMutableArray array];
                break;
        }
    }
    return self;
}
#pragma mark --- network
- (void)getAllActivityListWithPageIndex:(NSInteger)pageIndex success:(ZDBlock_Arr)success failure:(ZDBlock_Str)failure {
    ZDBlock_Dic callBlock = ^(NSDictionary *obj) {
        NSMutableArray *tempArray = [NSMutableArray array];
        [_allDataArray removeAllObjects];
        [_allTitleArray removeAllObjects];
        if ([obj[@"errcode"] integerValue] == 0) {
            if (pageIndex == 1) {
            } else {
                [tempArray addObjectsFromArray:(NSArray *)[[PGCache sharedCache] cacheForKey:@"ZDAllActivity"]];
            }
            if (ZD_UserM.isAdmin) {
                [tempArray addObjectsFromArray:obj[@"data"]];
            } else {
                [tempArray addObjectsFromArray:obj[@"data"][@"list"]];
            }
            [[PGCache sharedCache] setCache:tempArray forKey:@"ZDAllActivity"];
            for (NSDictionary *dic in tempArray) {
                ActivityModel *model = [ActivityModel yy_modelWithJSON:dic];
                [_allDataArray addObject:model];
                [_allTitleArray addObject:model.Title];
            }
            if (ZD_UserM.isAdmin) {
                success(obj[@"data"]);
            } else {
                success(obj[@"data"][@"list"]);
            }
        } else {
            ZDDo_Block_Safe_Main1(failure, obj[@"errmsg"])
        }
    };
    ZDBlock_Str failBlock = ^(NSString *str) {
        NSArray *array = (NSArray *)[[PGCache sharedCache] cacheForKey:@"ZDAllActivity"];
        if (array.count) {
            [_allDataArray removeAllObjects];
            for (NSDictionary *dic in array) {
                ActivityModel *model = [ActivityModel yy_modelWithJSON:dic];
                [_allDataArray addObject:model];
            }
            success(_allDataArray);
        } else {
            ZDDo_Block_Safe_Main1(failure, str)
        }
    };
    if (ZD_UserM.isAdmin) {
        NSString *listurl = [NSString stringWithFormat:@"%@api/v2/activity/getActivities?token=%@",zhundaoApi,[[PGSignManager shareManager] getToken]];
        NSDictionary *dic = @{@"ActivityStatus":@(0),
                              @"pageSize":@"10",
                              @"pageIndex":@(pageIndex)};
        [ZD_NetWorkM postDataWithMethod:listurl parameters:dic succ:^(NSDictionary *obj) {
            callBlock(obj);
        } fail:^(NSError *error) {
            failBlock(error.domain);
        }];
    } else {
        NSString *url = [NSString stringWithFormat:@"%@jinTaData?token=%@", zhundaoLogApi, ZD_UserM.token];
        NSDictionary *dic = @{@"BusinessCode": @"GetDataPersonActivityList",
                              @"Data" : @{
                                      @"PageIndex": @(pageIndex),
                                      @"PageSize": @(10),
                                      @"ActivityStatus": @(0)
                             }
        };
        [ZD_NetWorkM postDataWithMethod:url parameters:dic succ:^(NSDictionary *obj) {
            callBlock(obj);
        } fail:^(NSError *error) {
            failBlock(error.domain);
        }];
    }
}
- (void)getOnActivityListWithPageIndex:(NSInteger)pageIndex success:(ZDBlock_Arr)success failure:(ZDBlock_Str)failure {
    ZDBlock_Dic callBlock = ^(NSDictionary *obj) {
        NSMutableArray *tempArray = [NSMutableArray array];
        [_onDataArray removeAllObjects];
        [_onTitleArray removeAllObjects];
        if ([obj[@"errcode"] integerValue] == 0) {
            if (pageIndex == 1) {
            } else {
                [tempArray addObjectsFromArray:(NSArray *)[[PGCache sharedCache] cacheForKey:@"ZDOnActivity"]];
            }
            if (ZD_UserM.isAdmin) {
                [tempArray addObjectsFromArray:obj[@"data"]];
            } else {
                [tempArray addObjectsFromArray:obj[@"data"][@"list"]];
            }
            [[PGCache sharedCache] setCache:tempArray forKey:@"ZDOnActivity"];
            for (NSDictionary *dic in tempArray) {
                ActivityModel *model = [ActivityModel yy_modelWithJSON:dic];
                [_onDataArray addObject:model];
                [_onTitleArray addObject:model.Title];
            }
            if (ZD_UserM.isAdmin) {
                success(obj[@"data"]);
            } else {
                success(obj[@"data"][@"list"]);
            }
        } else {
            ZDDo_Block_Safe_Main1(failure, obj[@"errmsg"])
        }
    };
    ZDBlock_Str failBlock = ^(NSString *str) {
        NSArray *array = (NSArray *)[[PGCache sharedCache] cacheForKey:@"ZDOnActivity"];
        if (array.count) {
            [_onDataArray removeAllObjects];
            for (NSDictionary *dic in array) {
                ActivityModel *model = [ActivityModel yy_modelWithJSON:dic];
                [_onDataArray addObject:model];
            }
            success(_onDataArray);
        } else {
            ZDDo_Block_Safe_Main1(failure, str)
        }
    };
    if (ZD_UserM.isAdmin) {
        NSString *listurl = [NSString stringWithFormat:@"%@api/v2/activity/getActivities?token=%@",zhundaoApi,[[PGSignManager shareManager] getToken]];
        NSDictionary *dic = @{@"ActivityStatus":@(1),
                              @"pageSize":@"10",
                              @"pageIndex":@(pageIndex)};
        [ZD_NetWorkM postDataWithMethod:listurl parameters:dic succ:^(NSDictionary *obj) {
            callBlock(obj);
        } fail:^(NSError *error) {
            failBlock(error.domain);
        }];
    } else {
        NSString *url = [NSString stringWithFormat:@"%@jinTaData?token=%@", zhundaoLogApi, ZD_UserM.token];
        NSDictionary *dic = @{@"BusinessCode": @"GetDataPersonActivityList",
                              @"Data" : @{
                                      @"PageIndex": @(pageIndex),
                                      @"PageSize": @(10),
                                      @"ActivityStatus": @(1)
                             }
        };
        [ZD_NetWorkM postDataWithMethod:url parameters:dic succ:^(NSDictionary *obj) {
            callBlock(obj);
        } fail:^(NSError *error) {
            failBlock(error.domain);
        }];
    }
}
- (void)getCloseActivityListWithPageIndex:(NSInteger)pageIndex success:(ZDBlock_Arr)success failure:(ZDBlock_Str)failure {
    ZDBlock_Dic callBlock = ^(NSDictionary *obj) {
        NSMutableArray *tempArray = [NSMutableArray array];
        [_closeDataArray removeAllObjects];
        [_closeTitleArray removeAllObjects];
        if ([obj[@"errcode"] integerValue] == 0) {
            if (pageIndex == 1) {
            } else {
                [tempArray addObjectsFromArray:(NSArray *)[[PGCache sharedCache] cacheForKey:@"ZDCloseActivity"]];
            }
            if (ZD_UserM.isAdmin) {
                [tempArray addObjectsFromArray:obj[@"data"]];
            } else {
                [tempArray addObjectsFromArray:obj[@"data"][@"list"]];
            }
            [[PGCache sharedCache] setCache:tempArray forKey:@"ZDCloseActivity"];
            for (NSDictionary *dic in tempArray) {
                ActivityModel *model = [ActivityModel yy_modelWithJSON:dic];
                [_closeDataArray addObject:model];
                [_closeTitleArray addObject:model.Title];
            }
            if (ZD_UserM.isAdmin) {
                success(obj[@"data"]);
            } else {
                success(obj[@"data"][@"list"]);
            }
        } else {
            ZDDo_Block_Safe_Main1(failure, obj[@"errmsg"])
        }
    };
    ZDBlock_Str failBlock = ^(NSString *str) {
        NSArray *array = (NSArray *)[[PGCache sharedCache] cacheForKey:@"ZDCloseActivity"];
        if (array.count) {
            [_closeDataArray removeAllObjects];
            for (NSDictionary *dic in array) {
                ActivityModel *model = [ActivityModel yy_modelWithJSON:dic];
                [_closeDataArray addObject:model];
            }
            success(_closeDataArray);
        } else {
            ZDDo_Block_Safe_Main1(failure, str)
        }
    };
    if (ZD_UserM.isAdmin) {
        NSString *listurl = [NSString stringWithFormat:@"%@api/v2/activity/getActivities?token=%@",zhundaoApi,[[PGSignManager shareManager] getToken]];
        NSDictionary *dic = @{@"ActivityStatus":@(2),
                              @"pageSize":@"10",
                              @"pageIndex":@(pageIndex)};
        [ZD_NetWorkM postDataWithMethod:listurl parameters:dic succ:^(NSDictionary *obj) {
            callBlock(obj);
        } fail:^(NSError *error) {
            failBlock(error.domain);
        }];
    } else {
        NSString *url = [NSString stringWithFormat:@"%@jinTaData?token=%@", zhundaoLogApi, ZD_UserM.token];
        NSDictionary *dic = @{@"BusinessCode": @"GetDataPersonActivityList",
                              @"Data" : @{
                                      @"PageIndex": @(pageIndex),
                                      @"PageSize": @(10),
                                      @"ActivityStatus": @(2)
                             }
        };
        [ZD_NetWorkM postDataWithMethod:url parameters:dic succ:^(NSDictionary *obj) {
            callBlock(obj);
        } fail:^(NSError *error) {
            failBlock(error.domain);
        }];
    }
}
- (void)checkIsCanpost:(ZDBlock_ID)successBlock error:(ZDBlock_Error)errorBlock {
    NSString *str = [NSString stringWithFormat:@"%@api/PerActivity/GetActivityNumCurMonth?accessKey=%@",zhundaoApi,[[PGSignManager shareManager]getaccseekey]];
    [ZD_NetWorkM getDataWithMethod:str parameters:nil succ:^(NSDictionary *obj) {
        successBlock(obj);
    } fail:^(NSError *error) {
        errorBlock(error);
    }];
}
- (void)getMeMessageListSuccess:(ZDBlock_Int)success failure:(ZDBlock_Error_Str)failure {
    NSString *url = [NSString stringWithFormat:@"%@jinTaData?token=%@", zhundaoLogApi,ZD_UserM.token];
    NSDictionary *dic = @{@"BusinessCode": @"GetMessageListForApp",
                          @"Data" : @{
                                  @"PageIndex":@(1),
                                  @"PageSize":@(1000),
                         }
    };
    __block int count = 0;
    [ZD_NetWorkM postDataWithMethod:url parameters:dic succ:^(NSDictionary *obj) {
        if (obj[@"data"]) {
            NSArray *array = [NSArray arrayWithArray:obj[@"data"][@"list"]];
            for (NSDictionary *dic in array) {
                PGMeMessageModel *model = [PGMeMessageModel yy_modelWithJSON:dic];
                if (!model.IsRead) {
                    count += 1;
                }
            }
            ZDDo_Block_Safe_Main1(success, count)
        } else {
            ZDDo_Block_Safe1(failure, obj[@"errmsg"])
        }
    } fail:^(NSError *error) {
        ZDDo_Block_Safe1(failure, error.domain)
    }];
}
@end
