#import "PGMePromoteCustomContactViewModel.h"
@implementation PGMePromoteCustomContactViewModel
- (instancetype)init {
    if (self = [super init]) {
        self.dataArray = [NSMutableArray array];
        self.noticeArray = [NSMutableArray array];
        _zhundaoBi = 0;
    }
    return self;
}
- (void)getPromoteCustomContactSuccess:(ZDBlock_Void)success failure:(ZDBlock_Void)failure {
    NSString *url = [NSString stringWithFormat:@"%@api/v2/extra/getPartnerHomeData?token=%@",zhundaoApi,[[PGSignManager shareManager] getToken]];
    [ZD_NetWorkM getDataWithMethod:url parameters:nil succ:^(NSDictionary *obj) {
        PGMePromoteCustomContactModel *incomeModel = [PGMePromoteCustomContactModel incomeModelWithDic:obj[@"data"]];
        PGMePromoteCustomContactModel *userNumberModel = [PGMePromoteCustomContactModel userNumberModelWithDic:obj[@"data"]];
        PGMePromoteCustomContactModel *orderModel = [PGMePromoteCustomContactModel orderModelWithDic:obj[@"data"]];
        [self.dataArray addObject:incomeModel];
        [self.dataArray addObject:userNumberModel];
        [self.dataArray addObject:orderModel];
        ZDDo_Block_Safe_Main(success);
    } fail:^(NSError *error) {
        ZDDo_Block_Safe_Main(failure);
    }];
}
- (void)getZDBiSuccess:(ZDBlock_Void)success failure:(ZDBlock_Void)failure {
    NSString *url = [NSString stringWithFormat:@"%@api/v2/user/getUserCoin?token=%@",zhundaoApi,[[PGSignManager shareManager] getToken]];
    [ZD_NetWorkM getDataWithMethod:url parameters:nil succ:^(NSDictionary *obj) {
        if ([obj[@"res"] boolValue]) {
            _zhundaoBi = ZD_SafeIntValue(obj[@"data"][@"Balance"]);
        } else {
            _zhundaoBi = 0;
        }
        ZDDo_Block_Safe_Main(success);
    } fail:^(NSError *error) {
        ZDDo_Block_Safe_Main(failure);
    }];
}
- (void)getNoticeSuccess:(ZDBlock_Void)success failure:(ZDBlock_Void)failure {
    NSString *url = [NSString stringWithFormat:@"%@api/v2/extra/getPartnerNotice?token=%@",zhundaoApi,[[PGSignManager shareManager] getToken]];
    NSDictionary *params = @{@"pageSize": @(3), @"pageIndex": @(1)};
    [ZD_NetWorkM postDataWithMethod:url parameters:params succ:^(NSDictionary *obj) {
        for (NSDictionary *dic in obj[@"data"]) {
            PGMePromoteNoticeModel *model = [PGMePromoteNoticeModel yy_modelWithJSON:dic];
            [self.noticeArray addObject:model];
        }
        ZDDo_Block_Safe_Main(success);
    } fail:^(NSError *error) {
        ZDDo_Block_Safe_Main(failure);
    }];
}
@end
