//
//  NSString+HTML.m
//  zhundao
//
//  Created by zhundao on 2017/5/20.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "NSString+HTML.h"

@implementation NSString (HTML)
+ (NSAttributedString *)strToAttriWithStr:(NSString *)htmlStr{
    return [[NSAttributedString alloc] initWithData:[htmlStr dataUsingEncoding:NSUnicodeStringEncoding]
                                            options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType}
                                 documentAttributes:nil
                                              error:nil];
}
@end
