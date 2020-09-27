#import "PGloginCodeLoginViewModel.h"
@implementation PGloginCodeLoginViewModel
- (void)sendCode:(NSString *)phoneStr successBlock:(kZDCommonSucc)successBlock failBlock:(kZDCommonFail)failBlock {
    NSString *str = [NSString stringWithFormat:@"%@api/v2/senCode?phoneOrEmail=%@",zhundaoApi,phoneStr];
    [ZD_NetWorkM getDataWithMethod:str parameters:nil succ:^(NSDictionary *obj) {
        NSLog(@"responseObject = %@",obj);
        _sendCodeJson = [obj copy];
        successBlock();
    } fail:^(NSError *error) {
        failBlock(error.description);
    }];
}
- (void)loginWirhCode:(NSString *)code phoneStr:(NSString *)phoneStr successBlock:(kZDCommonSucc)successBlock failBlock:(kZDCommonFail)failBlock  {
    NSString *str = [NSString stringWithFormat:@"%@api/v2/login",zhundaoApi];
    NSDictionary *dic = @{@"userName":phoneStr,
                          @"code":code};
    [ZD_NetWorkM postDataWithMethod:str parameters:dic succ:^(NSDictionary *obj) {
        if (obj[@"token"]) {
            [[NSUserDefaults standardUserDefaults] setObject:obj[@"token"] forKey:@"token"];
            [[NSUserDefaults standardUserDefaults]setObject:obj[@"accessKey"] forKey:AccessKey];
            [[NSUserDefaults standardUserDefaults]synchronize];
            successBlock();
        } 
    } fail:^(NSError *error) {
        failBlock(error.description);
    }];
}
@end
