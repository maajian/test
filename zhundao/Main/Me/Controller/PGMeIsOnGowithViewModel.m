#import "PGMeIsOnGowithViewModel.h"
@implementation PGMeIsOnGowithViewModel
- (void)Withdraw :(NSString *)amount accountId :(NSInteger)accountId isonGowithBlock:(isonGowithBlock)isonGowithBlock{
    NSString *str = [NSString stringWithFormat:@"%@api/v2/user/withdraw?token=%@&amount=%@&accountId=%li",zhundaoApi,[[PGSignManager shareManager] getToken],amount,accountId];
    PGAFmanager *manager = [PGAFmanager manager];
    [manager GET:str parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *result = [NSDictionary dictionaryWithDictionary:responseObject];
        if ([result[@"errcode"] integerValue]==0) {
             isonGowithBlock(@"提现成功");
        }else{
             isonGowithBlock(result[@"errmsg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         isonGowithBlock(error.description);
    }];
}
@end
