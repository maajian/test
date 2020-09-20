//
//  PGSignInViewModel.m
//  zhundao
//
//  Created by maj on 2019/7/28.
//  Copyright © 2019 zhundao. All rights reserved.
//

#import "PGSignInViewModel.h"
#import "PGSignInModel.h"
#import "PGSignResult.h"

@interface PGSignInViewModel()
@property (nonatomic, assign) PGSignype signType;

@end

@implementation PGSignInViewModel

- (instancetype)initWithType:(PGSignype)signType {
    if (self = [super init]) {
        self.signType = signType;
        switch (signType) {
            case PGSignypeAll:
                _allDataArray = [NSMutableArray array];
                _allSearchArray = [NSMutableArray array];
                _allTitleArray = [NSMutableArray array];
                break;
            case PGSignypeOn:
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
- (void)getAllSignListWithPageIndex:(NSInteger)pageIndex success:(ZDBlock_Arr)success failure:(ZDBlock_Void)failure {
    NSString *listUrl = [NSString stringWithFormat:@"%@api/v2/checkIn/getCheckIns?token=%@",zhundaoApi,[[PGSignManager shareManager] getToken]];
    NSDictionary *dic = @{@"Type":@"0",
                          @"pageSize":@"10",
                          @"pageIndex":@(pageIndex)};
    [PGNetWorkManager shareHTTPSessionManager].responseSerializer = [AFJSONResponseSerializer serializer];
    [ZD_NetWorkM postDataWithMethod:listUrl parameters:dic succ:^(NSDictionary *obj) {
        NSMutableArray *tempArray = [NSMutableArray array];
        [_allDataArray removeAllObjects];
        [_allTitleArray removeAllObjects];
        if ([obj[@"errcode"] integerValue] == 0) {
            if (pageIndex == 1) {
                
            } else {
                [tempArray addObjectsFromArray:(NSArray *)[[PGCache sharedCache] cacheForKey:@"ZDAllSign"]];
            }
            [tempArray addObjectsFromArray:obj[@"data"]];
            [[PGCache sharedCache] setCache:tempArray forKey:@"ZDAllSign"];
            for (NSDictionary *dic in tempArray) {
                PGSignInModel *model = [PGSignInModel yy_modelWithJSON:dic];
                [_allDataArray addObject:model];
                [_allTitleArray addObject:model.Name];
                [self postDataWithSignID:model.ID];
            }
            success(obj[@"data"]);
        } else {
            failure();
        }
    } fail:^(NSError *error) {
        NSArray *array = (NSArray *)[[PGCache sharedCache] cacheForKey:@"ZDAllSign"];
        if (array.count) {
            [_allDataArray removeAllObjects];
            for (NSDictionary *dic in array) {
                PGSignInModel *model = [PGSignInModel yy_modelWithJSON:dic];
                [_allDataArray addObject:model];
            }
            success(_allDataArray);
        } else {
            failure();
        }
    }];
}
- (void)getOnSignListWithPageIndex:(NSInteger)pageIndex success:(ZDBlock_Arr)success failure:(ZDBlock_Void)failure {
    NSString *listUrl = [NSString stringWithFormat:@"%@api/v2/checkIn/getCheckIns?token=%@",zhundaoApi,[[PGSignManager shareManager] getToken]];
    NSDictionary *dic = @{@"Type":@"1",
                          @"pageSize":@"10",
                          @"pageIndex":@(pageIndex)};
    [PGNetWorkManager shareHTTPSessionManager].responseSerializer = [AFJSONResponseSerializer serializer];
    [ZD_NetWorkM postDataWithMethod:listUrl parameters:dic succ:^(NSDictionary *obj) {
        NSMutableArray *tempArray = [NSMutableArray array];
        [_onDataArray removeAllObjects];
        [_onTitleArray removeAllObjects];
        if ([obj[@"errcode"] integerValue] == 0) {
            if (pageIndex == 1) {
                
            } else {
                [tempArray addObjectsFromArray:(NSArray *)[[PGCache sharedCache] cacheForKey:@"ZDOnSign"]];
            }
            [tempArray addObjectsFromArray:obj[@"data"]];
            [[PGCache sharedCache] setCache:tempArray forKey:@"ZDOnSign"];
            for (NSDictionary *dic in tempArray) {
                PGSignInModel *model = [PGSignInModel yy_modelWithJSON:dic];
                [_onDataArray addObject:model];
                [_onTitleArray addObject:model.Name];
                [self postDataWithSignID:model.ID];
            }
            success(obj[@"data"]);
        } else {
            failure();
        }
    } fail:^(NSError *error) {
        NSArray *array = (NSArray *)[[PGCache sharedCache] cacheForKey:@"ZDOnSign"];
        if (array.count) {
            [_onDataArray removeAllObjects];
            for (NSDictionary *dic in array) {
                PGSignInModel *model = [PGSignInModel yy_modelWithJSON:dic];
                [_onDataArray addObject:model];
            }
            success(_onDataArray);
        } else {
            failure();
        }
    }];
}
- (void)getCloseSignListWithPageIndex:(NSInteger)pageIndex success:(ZDBlock_Arr)success failure:(ZDBlock_Void)failure {
    NSString *listUrl = [NSString stringWithFormat:@"%@api/v2/checkIn/getCheckIns?token=%@",zhundaoApi,[[PGSignManager shareManager] getToken]];
    NSDictionary *dic = @{@"Type":@"2",
                          @"pageSize":@"10",
                          @"pageIndex":@(pageIndex)};
    [PGNetWorkManager shareHTTPSessionManager].responseSerializer = [AFJSONResponseSerializer serializer];
    [ZD_NetWorkM postDataWithMethod:listUrl parameters:dic succ:^(NSDictionary *obj) {
        NSMutableArray *tempArray = [NSMutableArray array];
        [_closeDataArray removeAllObjects];
        [_closeTitleArray removeAllObjects];
        if ([obj[@"errcode"] integerValue] == 0) {
            if (pageIndex == 1) {
                
            } else {
                [tempArray addObjectsFromArray:(NSArray *)[[PGCache sharedCache] cacheForKey:@"ZDCloseSign"]];
            }
            [tempArray addObjectsFromArray:obj[@"data"]];
            [[PGCache sharedCache] setCache:tempArray forKey:@"ZDCloseSign"];
            for (NSDictionary *dic in tempArray) {
                PGSignInModel *model = [PGSignInModel yy_modelWithJSON:dic];
                [_closeDataArray addObject:model];
                [_closeTitleArray addObject:model.Name];
                [self postDataWithSignID:model.ID];
            }
            success(obj[@"data"]);
        } else {
            failure();
        }
    } fail:^(NSError *error) {
        NSArray *array = (NSArray *)[[PGCache sharedCache] cacheForKey:@"ZDCloseSign"];
        if (array.count) {
            [_closeDataArray removeAllObjects];
            for (NSDictionary *dic in array) {
                PGSignInModel *model = [PGSignInModel yy_modelWithJSON:dic];
                [_closeDataArray addObject:model];
            }
            success(_closeDataArray);
        } else {
            failure();
        }
    }];
}

- (void)postDataWithSignID:(NSInteger)signID {
    if ([ZD_UserM hasLocalSign:signID]) {
        [[PGSignResult alloc] postLocalDataWithSignID:signID success:^{
            
        } fail:nil];
    }
}

@end
