//
//  UIImage+Extension.h
//  zhundao
//
//  Created by maj on 2019/7/7.
//  Copyright © 2019 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Extension)
//  颜色转换为背景图片
+ (nullable UIImage *)imageWithColor:(nullable UIColor *)color;

@end

NS_ASSUME_NONNULL_END
