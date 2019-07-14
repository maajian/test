//
//  UITextView+BaseCreate.h
//  zhundao
//
//  Created by zhundao on 2017/4/7.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (BaseCreate)
+(instancetype)initWithFrame :(CGRect)rect WithText :(NSString *)text WithTextColor :(UIColor *)color WithFont :(UIFont *)font WithTextAlignment :(NSTextAlignment)textAlignment withisCanedit :(BOOL )isCanEdit;
@end
