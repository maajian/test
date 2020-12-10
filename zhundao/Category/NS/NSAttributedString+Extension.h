//
//  NSAttributedString+Extension.h
//  zhundao
//
//  Created by maj on 2020/12/7.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSAttributedString (Extension)

+ (instancetype)defaultAttributedStringWithString:(NSString *)string
                                        fontColor:(UIColor *)fontColor
                                             font:(UIFont *)font ;

+ (instancetype)defaultAttributedStringWithString:(NSString *)string
                                        fontColor:(UIColor *)fontColor
                                             font:(UIFont *)font
                                        alignment:(NSTextAlignment)alignment;

@end

NS_ASSUME_NONNULL_END
