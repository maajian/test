#import "PGMeAllAccountViewModel.h"
@implementation PGMeAllAccountViewModel
- (void)GetCreditCards :(allAccountBlock)allAccountBlock{
    NSString *url = [NSString stringWithFormat:@"%@api/PerBase/GetCreditCards?accessKey=%@",zhundaoApi,[[PGSignManager shareManager] getaccseekey]];
    [ZD_NetWorkM getDataWithMethod:url parameters:nil succ:^(NSDictionary *obj) {
        NSDictionary *result = [NSDictionary dictionaryWithDictionary:obj];
        NSLog( @"dic = %@",result );
        if ([result[@"Res"]integerValue]==0) {
            NSMutableArray *array = [NSMutableArray array];
            for (NSDictionary *dic in result[@"Data"]) {
                NSMutableDictionary *datadic = [NSMutableDictionary dictionary];
                [datadic setObject:dic[@"Account"] forKey:@"Account"];
                [datadic setObject:dic[@"BankName"] forKey:@"BankName"];
                [datadic setObject:dic[@"ID"] forKey:@"ID"];
                [array addObject:datadic];
            }
            allAccountBlock(1,array);
        }else{
            allAccountBlock(0,@[]);
        }
    } fail:^(NSError *error) {
        allAccountBlock(0,@[]);
    }];
}
- (void)deleteCreadCard :(NSInteger)ID successBlock:(ZDSuccessBlock)successBlock{
    NSString *str = [NSString stringWithFormat:@"%@api/PerBase/DeleteCreadCard/%li?accessKey=%@",zhundaoApi,ID,[[PGSignManager shareManager]getaccseekey]];
    [ZD_NetWorkM getDataWithMethod:str parameters:nil succ:^(NSDictionary *obj) {
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:obj];
        successBlock(dic);
    } fail:^(NSError *error) {
    }];
}
@end
