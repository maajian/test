#import "PGDiscoverCustomApplyViewModel.h"
@implementation PGDiscoverCustomApplyViewModel
- (instancetype)init {
    if (self = [super init]) {
        self.dataArray = [NSMutableArray array];
    }
    return self;
}
#pragma mark --- network
- (void)getCustomApplyList:(kZDCommonSucc)success fail:(kZDCommonFail)fail {
    [_dataArray removeAllObjects];
    NSString *urlStr = [NSString stringWithFormat:@"%@api/v2/activity/getActivityOptionList?token=%@",zhundaoApi,[[PGSignManager shareManager] getToken]];
    NSMutableArray *hiddenArray = [NSMutableArray array];
    NSMutableArray *showArray = [NSMutableArray array];
    __weak typeof(self) weakSelf = self;
    [ZD_NetWorkM getDataWithMethod:urlStr parameters:nil succ:^(NSDictionary *obj) {
        [weakSelf.allTitleArray removeAllObjects];
        for (NSDictionary *dic in obj[@"data"]) {
            PGDiscoverCustomApplyModel *model = [[PGDiscoverCustomApplyModel alloc] initWithDic:dic];;
            if (model.hidden) {
                [hiddenArray addObject:model];
            } else {
                [showArray addObject:model];
            }
        }
        [_dataArray addObjectsFromArray:showArray];
        [_dataArray addObjectsFromArray:hiddenArray];
        for (PGDiscoverCustomApplyModel *applyModel in _dataArray) {
            [weakSelf.allTitleArray addObject:applyModel.title];
        }
        [PGCache.sharedCache setCache:obj forKey:@"customApply"];
        success();
    } fail:^(NSError *error) {
        if ([PGCache.sharedCache cacheForKey:@"customApply"]) {
            id json = [PGCache.sharedCache cacheForKey:@"customApply"];
            for (NSDictionary *dic in json[@"data"]) {
                PGDiscoverCustomApplyModel *model = [[PGDiscoverCustomApplyModel alloc] initWithDic:dic];;
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
- (void)hideOrShowList:(BOOL)hidden ID:(NSInteger)ID success:(kZDCommonSucc)success fail:(kZDCommonFail)fail {
    NSString *str = [NSString stringWithFormat:@"%@api/v2/activity/updateActivityOption?token=%@",zhundaoApi,[[PGSignManager shareManager] getToken]];
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
#pragma mark --- lazyload
- (NSMutableArray<PGDiscoverCustomApplyModel *> *)titleArray {
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
