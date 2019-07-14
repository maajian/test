//
//  NSString+ChangeToPinyin.m
//  zhundao
//
//  Created by zhundao on 2017/5/23.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "NSString+ChangeToPinyin.h"

@implementation NSString (ChangeToPinyin)
- (NSString *)changeToPinyinWithStr :(NSString *)str
{
    NSMutableString *pinyinStr = [[NSMutableString alloc]initWithString:str];
    if(CFStringTransform((__bridge CFMutableStringRef)pinyinStr, 0, kCFStringTransformMandarinLatin, NO)) {

    }
    if (CFStringTransform((__bridge CFMutableStringRef)pinyinStr, 0, kCFStringTransformStripDiacritics, NO)) {
     
    }
    NSString *pinyinStr1 = [pinyinStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    pinyinStr1 = [pinyinStr1 stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    pinyinStr1 = [pinyinStr1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    pinyinStr1 = [pinyinStr1 stringByReplacingOccurrencesOfString:@" " withString:@""];
    return pinyinStr1;
}


@end
