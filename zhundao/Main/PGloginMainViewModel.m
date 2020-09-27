#import "PGloginMainViewModel.h"
@implementation PGloginMainViewModel
+ (void)getTokenByAccount:(NSString *)phoneStr passWord:(NSString *)password {
    NSString *url = [NSString stringWithFormat:@"%@api/v2/getToken?userName=%@&password=%@&loginType=2",zhundaoApi,phoneStr,password];
    [ZD_NetWorkM getDataWithMethod:url parameters:nil succ:^(NSDictionary *obj) {
        if (obj[@"token"]) {
            [[NSUserDefaults standardUserDefaults] setObject:obj[@"token"] forKey:@"token"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    } fail:^(NSError *error) {
    }];
}
+ (void)getTokenByWechat:(NSString *)code{
    [ZD_NetWorkM getDataWithMethod:[NSString stringWithFormat:@"%@api/v2/weChatLogin?code=%@&type=1",zhundaoApi,code] parameters:nil succ:^(NSDictionary *obj) {
        if (obj[@"token"]) {
            [[NSUserDefaults standardUserDefaults] setObject:obj[@"token"] forKey:@"token"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    } fail:^(NSError *error) {
    }];
}
@end
