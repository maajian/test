//
//  MyLabel.h
//  zhundao
//
//  Created by zhundao on 2017/2/22.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyLabel : UILabel
+(UILabel *)initWithLabelFrame:(CGRect)frame Text : (NSString *)text textColor :(UIColor *)textColor font :(UIFont *)font textAlignment : (NSTextAlignment )textAlignment cornerRadius :(float)cornerRadius masksToBounds:(BOOL)masksToBounds;

- (UILabel *)initWithFrame :(CGRect)frame Text : (NSString *)text textColor :(UIColor *)textColor font :(UIFont *)font;
@end
