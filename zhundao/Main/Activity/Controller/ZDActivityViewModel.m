//
//  ZDActivityViewModel.m
//  zhundao
//
//  Created by maj on 2019/6/30.
//  Copyright © 2019 zhundao. All rights reserved.
//

#import "ZDActivityViewModel.h"

@interface ZDActivityViewModel()
@property (nonatomic, assign) ZDActivityType activityType;

@end

@implementation ZDActivityViewModel

- (instancetype)initWithType:(ZDActivityType)activityType {
    if (self = [super init]) {
        self.activityType = activityType;
        switch (activityType) {
            case ZDActivityTypeAll:
                _allDataArray = [NSMutableArray array];
                _allSearchArray = [NSMutableArray array];
                _allTitleArray = [NSMutableArray array];
                break;
            case ZDActivityTypeOn:
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
- (void)getAllActivityListWithPageIndex:(NSInteger)pageIndex success:(ZDBlock_Arr)success failure:(ZDBlock_Void)failure {
    NSString *listurl = [NSString stringWithFormat:@"%@api/v2/activity/getActivities?token=%@",zhundaoApi,[[SignManager shareManager] getToken]];
    NSDictionary *dic = @{@"ActivityStatus":@(0),
                          @"pageSize":@"10",
                          @"pageIndex":@(pageIndex)};
    [ZD_NetWorkM postDataWithMethod:listurl parameters:dic succ:^(NSDictionary *obj) {
        NSMutableArray *tempArray = [NSMutableArray array];
        [_allDataArray removeAllObjects];
        [_allTitleArray removeAllObjects];
        if ([obj[@"errcode"] integerValue] == 0) {
            if (pageIndex == 1) {
                
            } else {
                [tempArray addObjectsFromArray:(NSArray *)[[ZDCache sharedCache] cacheForKey:@"ZDAllActivity"]];
            }
            [tempArray addObjectsFromArray:obj[@"data"]];
            [[ZDCache sharedCache] setCache:tempArray forKey:@"ZDAllActivity"];
            for (NSDictionary *dic in tempArray) {
                ActivityModel *model = [ActivityModel yy_modelWithJSON:dic];
                [_allDataArray addObject:model];
                [_allTitleArray addObject:model.Title];
            }
            success(obj[@"data"]);
        } else {
            failure();
        }
    } fail:^(NSError *error) {
        NSArray *array = (NSArray *)[[ZDCache sharedCache] cacheForKey:@"ZDAllActivity"];
        if (array.count) {
            [_allDataArray removeAllObjects];
            for (NSDictionary *dic in array) {
                ActivityModel *model = [ActivityModel yy_modelWithJSON:dic];
                [_allDataArray addObject:model];
            }
            success(_allDataArray);
        } else {
            failure();
        }
    }];
}

- (void)getOnActivityListWithPageIndex:(NSInteger)pageIndex success:(ZDBlock_Arr)success failure:(ZDBlock_Void)failure {
    NSString *listurl = [NSString stringWithFormat:@"%@api/v2/activity/getActivities?token=%@",zhundaoApi,[[SignManager shareManager] getToken]];
    NSDictionary *dic = @{@"ActivityStatus":@(1),
                          @"pageSize":@"10",
                          @"pageIndex":@(pageIndex)};
    [ZD_NetWorkM postDataWithMethod:listurl parameters:dic succ:^(NSDictionary *obj) {
        NSMutableArray *tempArray = [NSMutableArray array];
        [_onDataArray removeAllObjects];
        [_onTitleArray removeAllObjects];
        if ([obj[@"errcode"] integerValue] == 0) {
            if (pageIndex == 1) {
                
            } else {
                [tempArray addObjectsFromArray:(NSArray *)[[ZDCache sharedCache] cacheForKey:@"ZDOnActivity"]];
            }
            [tempArray addObjectsFromArray:obj[@"data"]];
            [[ZDCache sharedCache] setCache:tempArray forKey:@"ZDOnActivity"];
            for (NSDictionary *dic in tempArray) {
                ActivityModel *model = [ActivityModel yy_modelWithJSON:dic];
                [_onDataArray addObject:model];
                [_onTitleArray addObject:model.Title];
            }
            success(obj[@"data"]);
        } else {
            failure();
        }
    } fail:^(NSError *error) {
        NSArray *array = (NSArray *)[[ZDCache sharedCache] cacheForKey:@"ZDOnActivity"];
        if (array.count) {
            [_onDataArray removeAllObjects];
            for (NSDictionary *dic in array) {
                ActivityModel *model = [ActivityModel yy_modelWithJSON:dic];
                [_onDataArray addObject:model];
            }
            success(_onDataArray);
        } else {
            failure();
        }
    }];
}

- (void)getCloseActivityListWithPageIndex:(NSInteger)pageIndex success:(ZDBlock_Arr)success failure:(ZDBlock_Void)failure {
    NSString *listurl = [NSString stringWithFormat:@"%@api/v2/activity/getActivities?token=%@",zhundaoApi,[[SignManager shareManager] getToken]];
    NSDictionary *dic = @{@"ActivityStatus":@(2),
                          @"pageSize":@"10",
                          @"pageIndex":@(pageIndex)};
    [ZD_NetWorkM postDataWithMethod:listurl parameters:dic succ:^(NSDictionary *obj) {
        NSMutableArray *tempArray = [NSMutableArray array];
        [_closeDataArray removeAllObjects];
        [_closeTitleArray removeAllObjects];
        if ([obj[@"errcode"] integerValue] == 0) {
            if (pageIndex == 1) {
                
            } else {
                [tempArray addObjectsFromArray:(NSArray *)[[ZDCache sharedCache] cacheForKey:@"ZDCloseActivity"]];
            }
            [tempArray addObjectsFromArray:obj[@"data"]];
            [[ZDCache sharedCache] setCache:tempArray forKey:@"ZDCloseActivity"];
            for (NSDictionary *dic in tempArray) {
                ActivityModel *model = [ActivityModel yy_modelWithJSON:dic];
                [_closeDataArray addObject:model];
                [_closeTitleArray addObject:model.Title];
            }
            success(obj[@"data"]);
        } else {
            failure();
        }
    } fail:^(NSError *error) {
        NSArray *array = (NSArray *)[[ZDCache sharedCache] cacheForKey:@"ZDCloseActivity"];
        if (array.count) {
            [_closeDataArray removeAllObjects];
            for (NSDictionary *dic in array) {
                ActivityModel *model = [ActivityModel yy_modelWithJSON:dic];
                [_closeDataArray addObject:model];
            }
            success(_closeDataArray);
        } else {
            failure();
        }
    }];
}

// 检查是否可以发起活动
- (void)checkIsCanpost:(ZDBlock_ID)successBlock error:(ZDBlock_Error)errorBlock {
    NSString *str = [NSString stringWithFormat:@"%@api/PerActivity/GetActivityNumCurMonth?accessKey=%@",zhundaoApi,[[SignManager shareManager]getaccseekey]];
    [ZD_NetWorkM getDataWithMethod:str parameters:nil succ:^(NSDictionary *obj) {
        successBlock(obj);
    } fail:^(NSError *error) {
        errorBlock(error);
    }];
}


@end
