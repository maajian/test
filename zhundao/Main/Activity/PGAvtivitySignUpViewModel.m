#import "PGAvtivitySignUpViewModel.h"
@implementation PGAvtivitySignUpViewModel
- (instancetype)init {
    if (self = [super init]) {
        _dataArray = [NSMutableArray array];
        _xLabelArray = [NSMutableArray array];
        _personCountArray = [NSMutableArray array];
    }
    return self;
}
- (void)getActivityListDate:(NSInteger)activityId
                  beginDate:(NSString *)beginDate
                    endDate:(NSString *)endDate
               successBlock:(kZDCommonSucc)successBlock
                  failBlock:(kZDCommonFail)failBlock{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSString *url = [NSString stringWithFormat:@"%@api/v2/dataCube/getActivityListDate?token=%@&activityId=%li&beginDate=%@&endDate=%@",zhundaoApi,token,(long)activityId,beginDate,endDate];
    [ZD_NetWorkM getDataWithMethod:url parameters:nil succ:^(NSDictionary *obj) {
        if ([obj[@"res"] boolValue]) {
            [_dataArray removeAllObjects];
            [_xLabelArray removeAllObjects];
            for (NSDictionary *dic in obj[@"data"]) {
                PGAvtivitySignUpModel *model = [[PGAvtivitySignUpModel alloc] initWithDic:dic];
                [_dataArray addObject:[NSString stringWithFormat:@"%li",(long)model.count]];
                [_xLabelArray addObject:model.date];
            }
            successBlock();
        } else {
            ZDDo_Block_Safe_Main1(failBlock, obj[@"errmsg"])
        }
    } fail:^(NSError *error) {
        failBlock(error.domain);
    }];
}
- (void)getActivityReadDate:(NSInteger)activityId
                  beginDate:(NSString *)beginDate
                    endDate:(NSString *)endDate
               successBlock:(kZDCommonSucc)successBlock
                  failBlock:(kZDCommonFail)failBlock {
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSString *url = [NSString stringWithFormat:@"%@api/v2/dataCube/getActivityReadDate?token=%@&activityId=%li&beginDate=%@&endDate=%@",zhundaoApi,token,(long)activityId,beginDate,endDate];
    [ZD_NetWorkM getDataWithMethod:url parameters:nil succ:^(NSDictionary *obj) {
        [_dataArray removeAllObjects];
        [_xLabelArray removeAllObjects];
        for (NSDictionary *dic in obj[@"data"]) {
            PGAvtivitySignUpModel *model = [[PGAvtivitySignUpModel alloc] initWithDic:dic];
            [_dataArray addObject:[NSString stringWithFormat:@"%li",model.count]];
            [_xLabelArray addObject:model.date];
        }
        successBlock();
    } fail:^(NSError *error) {
        failBlock(error.description);
    }];
}
- (void)getFeePeopleNoDate:(NSInteger)activityId
              successBlock:(kZDCommonSucc)successBlock
                 failBlock:(kZDCommonFail)failBlock {
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSString *url = [NSString stringWithFormat:@"%@api/v2/dataCube/getFeePeopleNoDate?token=%@&activityId=%li",zhundaoApi,token,(long)activityId];
    [ZD_NetWorkM getDataWithMethod:url parameters:nil succ:^(NSDictionary *obj) {
        if ([obj[@"errcode"] integerValue] == 0) {
            if ( [obj[@"data"][@"total"] integerValue] - [obj[@"data"][@"unpaid"] integerValue] == 0) {
                failBlock(@"该活动暂无收入");
            } else {
                [_personCountArray addObject:@[@"付款人数", obj[@"data"][@"paid"]]];
                [_personCountArray addObject:@[@"未付款人数", obj[@"data"][@"unpaid"]]];
                successBlock();
            }
        } else {
            failBlock(@"该活动暂无收入");
        }
    } fail:^(NSError *error) {
        failBlock(error.description);
    }];
}
- (void)getEachFeeDate:(NSInteger)activityId
              successBlock:(kZDCommonSucc)successBlock
                 failBlock:(kZDCommonFail)failBlock {
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSString *url = [NSString stringWithFormat:@"%@api/v2/dataCube/getEachFeeDate?token=%@&activityId=%li",zhundaoApi,token,activityId];
    [ZD_NetWorkM getDataWithMethod:url parameters:nil succ:^(NSDictionary *obj) {
        if ([obj[@"errcode"] integerValue] == 0) {
            for (NSDictionary *dic in obj[@"data"]) {
                PGAvtivitySignUpModel *model = [[PGAvtivitySignUpModel alloc] initWithDic:dic];
                [_dataArray addObject:model];
            }
        }
        successBlock();
    } fail:^(NSError *error) {
        failBlock(error.description);
    }];
}
@end
