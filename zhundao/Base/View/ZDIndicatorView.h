//
//  ZDIndicatorView.h
//  zhundao
//
//  Created by maj on 2018/12/1.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import "JQIndicatorView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZDIndicatorView : JQIndicatorView

+ (instancetype)shareIndicator;

+ (void)showIndicatorView:(UIView *)view;

+ (void)dismiss;

@end

NS_ASSUME_NONNULL_END
