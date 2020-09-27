#import "PGMeAuthViewModel.h"
@implementation PGMeAuthViewModel
- (void)postAuthentication :(NSDictionary *)dic authBlock :(authBlock)authBlock{
    NSString *str = [NSString stringWithFormat:@"%@api/PerBase/PstAuthentication?accessKey=%@",zhundaoApi,[[PGSignManager shareManager]getaccseekey]];
    [ZD_NetWorkM postDataWithMethod:str parameters:dic succ:^(NSDictionary *obj) {
        NSDictionary *result = [NSDictionary dictionaryWithDictionary:obj];
        NSLog(@"result = %@",result);
        if ([result[@"Res"] integerValue]==0) {
            authBlock(1);
        }else{
            authBlock(0);
        }
    } fail:^(NSError *error) {
        NSLog(@"error = %@",error);
        authBlock(0);
    }];
}
- (void)GetAuthorInfo {
    NSString *str = [NSString stringWithFormat:@"%@api/PerBase/GetAuthorInfo?accessKey=%@",zhundaoApi,[[PGSignManager shareManager]getaccseekey]];
    [ZD_NetWorkM getDataWithMethod:str parameters:nil succ:^(NSDictionary *obj) {
        NSDictionary *result = [NSDictionary dictionaryWithDictionary:obj];
        NSLog(@"result = %@",result);
    } fail:^(NSError *error) {
    }];
}
@end
