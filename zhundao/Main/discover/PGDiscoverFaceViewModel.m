#import "PGDiscoverFaceViewModel.h"
@implementation PGDiscoverFaceViewModel
#pragma mark --------网络请求
- (void)getListWithBlock :(listBlock)listBlock
{
    NSString *str = [NSString stringWithFormat:@"https://face.zhundao.net/api/Core/GetDeviceList?accessKey=%@&userId=2",[[PGSignManager shareManager] getaccseekey]];
    [ZD_NetWorkM getDataWithMethod:str parameters:nil succ:^(NSDictionary *obj) {
    } fail:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];
}
#pragma mark 逻辑 
- (void)saveData:(NSArray *)array
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:array];
    [[NSUserDefaults standardUserDefaults]setObject:data forKey:@"faceArray"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
- (NSArray *)getData
{
    NSData *data = [[NSUserDefaults standardUserDefaults]objectForKey:@"faceArray"];
    NSArray *array = [[NSKeyedUnarchiver unarchiveObjectWithData:data]copy];
    return array;
}
@end
