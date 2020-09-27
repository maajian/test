#import "PGMeMyWalletViewModel.h"
@implementation PGMeMyWalletViewModel
- (void)getInfo :(moneyBlock)moneyBlock {
    NSString *url = [NSString stringWithFormat:@"%@api/PerBase/GetWithdrawStatus?accessKey=%@",zhundaoApi,[[PGSignManager shareManager] getaccseekey]];
    [ZD_NetWorkM getDataWithMethod:url parameters:nil succ:^(NSDictionary *obj) {
        NSDictionary *dic1 = [NSDictionary dictionaryWithDictionary:obj];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:dic1[@"Balance"] forKey:@"Balance"];  
        [dic setValue:dic1[@"Status"] forKey:@"status"];   
        if ([dic1[@"Status"]integerValue ]==0) {
            NSArray *array = dic1[@"withdraw"];
            NSDictionary *detailDic = array.firstObject;
            for (NSString *keyStr in detailDic.allKeys) {
                if ([keyStr isEqualToString:@"Amount"]) {
                    [dic setObject:detailDic[@"Amount"] forKey:@"Amount"];
                }else if ([keyStr isEqualToString:@"AddTime"]){
                    [dic setObject:detailDic[@"AddTime"] forKey:@"AddTime"];
                }else if ([keyStr isEqualToString:@"BankName"]){
                    [dic setObject:detailDic[@"BankName"] forKey:@"BankName"];
                }else if ([keyStr isEqualToString:@"Account"]){
                    [dic setObject:detailDic[@"Account"] forKey:@"Account"];
                }
            }
        }
        moneyBlock(dic);
    } fail:^(NSError *error) {
    }];
}
- (void)saveWithdraw :(NSDictionary *)dic{
    NSString *filepath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"withdraw.plist"];
  BOOL issuces =    [dic writeToFile:filepath atomically:YES];
    if (issuces) {
        NSLog(@"1");
    }
}
- (NSDictionary *)readWithdraw {
     NSString *filepath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"withdraw.plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filepath];
    return dic;
}
@end
