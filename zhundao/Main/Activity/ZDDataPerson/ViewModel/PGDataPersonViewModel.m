#import "PGDataPersonViewModel.h"
@implementation PGDataPersonViewModel
- (instancetype)init {
    if (self = [super init] ) {
        _dataSource = [NSMutableArray array];
        _allNameSource = [NSMutableArray array];
        _selectNameSource = [NSMutableArray array];
    }
    return self;
}
#pragma mark --- network
- (void)networkForGetDataPersonListActivityId:(NSInteger)activityId success:(ZDBlock_Void)success failure:(ZDBlock_Error)failure {
    NSString *url = [NSString stringWithFormat:@"%@jinTaData?token=%@", zhundaoLogApi, ZD_UserM.token];
    NSDictionary *dic = @{@"BusinessCode": @"GetDataPersonListForApp",
                          @"Data" : @{
                                  @"ActivityId":@(activityId),
                                  @"UserName": @""
                         }
    };
    [ZD_NetWorkM postDataWithMethod:url parameters:dic succ:^(NSDictionary *obj) {
        [_dataSource removeAllObjects];
        [_allNameSource removeAllObjects];
        NSArray *tempArray = [NSArray arrayWithArray:obj[@"data"]];
        for (NSDictionary *dic in tempArray) {
            PGDataPersonModel *model = [PGDataPersonModel yy_modelWithJSON:dic];
            model.number = tempArray.count - [obj[@"data"] indexOfObject:dic];
            model.AddTime = [[model.AddTime stringByReplacingOccurrencesOfString:@"T" withString:@" "] componentsSeparatedByString:@"."].firstObject;
            [self.dataSource addObject:model];
            [_allNameSource addObject:model.UserName];
        }
        ZDDo_Block_Safe_Main(success)
    } fail:^(NSError *error) {
        ZDDo_Block_Safe_Main1(failure, error)
    }];
}
@end
