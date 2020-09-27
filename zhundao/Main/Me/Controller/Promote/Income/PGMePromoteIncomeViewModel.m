#import "PGMePromoteIncomeViewModel.h"
@implementation PGMePromoteIncomeViewModel
- (instancetype)init {
    if (self = [super init]) {
        _dataArray = [NSMutableArray array];
    }
    return self;
}
- (void)getIncomeSuccess:(ZDBlock_Void)success failure:(ZDBlock_Void)failure {
    NSString *url = [NSString stringWithFormat:@"%@api/v2/extra/getPartnerLogCoinList?token=%@", zhundaoApi,[[PGSignManager shareManager] getToken]];
    NSDictionary *params = @{@"pageSize": @(10000), @"pageIndex": @(1)};
    [ZD_NetWorkM postDataWithMethod:url parameters:params succ:^(NSDictionary *obj) {
        for (NSDictionary *dic in obj[@"data"]) {
            PGMePromoteIncomeModel *model = [PGMePromoteIncomeModel yy_modelWithJSON:dic];
            if (model.Type == 1) {
                model.typeStr = @"后台充值";
            } else if (model.Type == 2) {
                model.typeStr = @"自动充值";
            } else {
                model.typeStr = @"推广佣金";
            }
            [self.dataArray addObject:model];
        }
        ZDDo_Block_Safe_Main(success);
    } fail:^(NSError *error) {
        ZDDo_Block_Safe_Main(failure);
    }];
}
@end
