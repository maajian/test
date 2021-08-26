//
//  ZDDiscoverCustomApplyViewModel.m
//  zhundao
//
//  Created by maj on 2018/12/1.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import "ZDDiscoverCustomApplyViewModel.h"

@implementation ZDDiscoverCustomApplyViewModel

- (instancetype)init {
    if (self = [super init]) {
        self.dataArray = [NSMutableArray array];
    }
    return self;
}

#pragma mark --- network
// 获取自定义报名项列表
- (void)getCustomApplyList:(kZDCommonSucc)success fail:(kZDCommonFail)fail {
    [_dataArray removeAllObjects];
    NSString *urlStr = [NSString stringWithFormat:@"%@api/v2/activity/getActivityOptionList?token=%@",zhundaoApi,[[SignManager shareManager] getToken]];
    NSMutableArray *hiddenArray = [NSMutableArray array];
    NSMutableArray *showArray = [NSMutableArray array];
    __weak typeof(self) weakSelf = self;
    [ZD_NetWorkM getDataWithMethod:urlStr parameters:nil succ:^(NSDictionary *obj) {
        [weakSelf.allTitleArray removeAllObjects];
        for (NSDictionary *dic in obj[@"data"]) {
            ZDDiscoverCustomApplyModel *model = [[ZDDiscoverCustomApplyModel alloc] initWithDic:dic];;
            if (model.hidden) {
                [hiddenArray addObject:model];
            } else {
                [showArray addObject:model];
            }
        }
        [_dataArray addObjectsFromArray:showArray];
        [_dataArray addObjectsFromArray:hiddenArray];
        for (ZDDiscoverCustomApplyModel *applyModel in _dataArray) {
            [weakSelf.allTitleArray addObject:applyModel.title];
        }
        [ZDCache.sharedCache setCache:obj forKey:@"customApply"];
        success();
    } fail:^(NSError *error) {
        if ([ZDCache.sharedCache cacheForKey:@"customApply"]) {
            id json = [ZDCache.sharedCache cacheForKey:@"customApply"];
            for (NSDictionary *dic in json[@"data"]) {
                ZDDiscoverCustomApplyModel *model = [[ZDDiscoverCustomApplyModel alloc] initWithDic:dic];;
                if (model.hidden) {
                    [hiddenArray addObject:model];
                } else {
                    [showArray addObject:model];
                }
            }
            [_dataArray addObjectsFromArray:showArray];
            [_dataArray addObjectsFromArray:hiddenArray];
        }
        fail(error.description);
    }];
}

// 隐藏显示报名项
- (void)hideOrShowList:(BOOL)hidden ID:(NSInteger)ID success:(kZDCommonSucc)success fail:(kZDCommonFail)fail {
    NSString *str = [NSString stringWithFormat:@"%@api/v2/activity/updateActivityOption?token=%@",zhundaoApi,[[SignManager shareManager] getToken]];
    NSDictionary *dic = @{@"hidden" : hidden ? @(1): @(0),
                          @"id" : @(ID)};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
    NSString *jsonStr = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    [ZD_NetWorkM postDataWithMethod:str parameters:jsonStr succ:^(NSDictionary *obj) {
        success();
    } fail:^(NSError *error) {
        fail(error.description);
    }];
}
- (void)deleteItemWithID:(NSInteger)ID success:(kZDCommonSucc)success fail:(kZDCommonFail)fail {
    NSString *str = [NSString stringWithFormat:@"%@api/v2/activity/delActivityOption?token=%@&id=%li",zhundaoApi,[[SignManager shareManager] getToken], ID];
    [ZD_NetWorkM getDataWithMethod:str parameters:nil succ:^(NSDictionary *obj) {
        success();
    } fail:^(NSError *error) {
        fail(error.description);
    }];
}

#pragma mark --- lazyload
- (NSMutableArray<ZDDiscoverCustomApplyModel *> *)titleArray {
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}
- (NSMutableArray<NSString *> *)allTitleArray {
    if (!_allTitleArray) {
        _allTitleArray = [NSMutableArray array];
    }
    return _allTitleArray;
}

@end
