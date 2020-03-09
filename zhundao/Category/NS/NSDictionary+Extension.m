//
//  NSDictionary+Extension.m
//  zhundao
//
//  Created by maj on 2019/11/8.
//  Copyright © 2019 zhundao. All rights reserved.
//

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

/**
 删除字典中null数据
 
 @param dic <#dic description#>
 */
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
