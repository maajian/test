#import "PGLoginInfoEditViewModel.h"
@implementation PGLoginInfoEditViewModel
- (void)loginWirhCode:(NSString *)code phoneStr:(NSString *)phoneStr name:(NSString *)name passWord:(NSString *)passWord  successBlock:(kZDCommonSucc)successBlock failBlock:(kZDCommonFail)failBlock  {
    NSString *str = [NSString stringWithFormat:@"%@api/v2/login",zhundaoApi];
    NSDictionary *dic = @{@"userName":phoneStr,
                          @"code":code,
                          @"trueName":name,
                          @"passWord":passWord};
    [ZD_NetWorkM postDataWithMethod:str parameters:dic succ:^(NSDictionary *obj) {
        if (obj[@"token"]) {
            [[NSUserDefaults standardUserDefaults] setObject:obj[@"token"] forKey:@"token"];
            [[NSUserDefaults standardUserDefaults]setObject:obj[@"accessKey"] forKey:AccessKey];
            [[NSUserDefaults standardUserDefaults]synchronize];
        } else {
            failBlock(@"完善信息");
        }
        successBlock();
    } fail:^(NSError *error) {
        failBlock(error.description);
    }];
}
@end
