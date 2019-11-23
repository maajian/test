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

@end
