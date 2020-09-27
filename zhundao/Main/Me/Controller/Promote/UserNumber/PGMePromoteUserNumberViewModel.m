#import "PGMePromoteUserNumberViewModel.h"
@implementation PGMePromoteUserNumberViewModel
- (instancetype)init {
    if (self = [super init]) {
        self.dataArray = [NSMutableArray array];
    }
    return self;
}
- (void)getUserNumberSuccess:(ZDBlock_Void)success failure:(ZDBlock_Void)failure {
    NSString *url = [NSString stringWithFormat:@"%@api/v2/extra/getPartnerUserList?token=%@", zhundaoApi,[[PGSignManager shareManager] getToken]];
    NSDictionary *params = @{@"pageSize": @(10000), @"pageIndex": @(1)};
    [ZD_NetWorkM postDataWithMethod:url parameters:params succ:^(NSDictionary *obj) {
        for (NSDictionary *dic in obj[@"data"]) {
            PGMePromoteUserNumberModel *model = [PGMePromoteUserNumberModel yy_modelWithJSON:dic];
            model.AddTime = [model.AddTime substringToIndex:model.AddTime.length - 3];
            [self.dataArray addObject:model];
        }
        ZDDo_Block_Safe_Main(success);
    } fail:^(NSError *error) {
        ZDDo_Block_Safe_Main(failure);
    }];
}
@end
