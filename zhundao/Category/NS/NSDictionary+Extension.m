#import "NSDictionary+Extension.h"
@implementation NSDictionary (Extension)
- (NSString *)zd_jsonString {
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error];
    if (error) {
        return nil;
    }
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return string;
}
- (id)deleteNullObj {
    __block NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if (obj) {
            if ((NSNull *)obj != [NSNull null]) {
                [dic setObject:obj forKey:key];
            }
        }
    }];
    return dic;
}
@end
