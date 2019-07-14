//
//  NSString+HTML.h
//  zhundao
//
//  Created by zhundao on 2017/5/20.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HTML)
+ (NSAttributedString *)strToAttriWithStr:(NSString *)htmlStr;
@end
