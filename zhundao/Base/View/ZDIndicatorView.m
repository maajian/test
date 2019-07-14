//
//  ZDIndicatorView.m
//  zhundao
//
//  Created by maj on 2018/12/1.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import "ZDIndicatorView.h"

@implementation ZDIndicatorView

+ (instancetype)shareIndicator {
    static ZDIndicatorView *indicator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        indicator = [[ZDIndicatorView alloc]initWithType:3 tintColor: [UIColor colorWithRed:9.00f/255.0f green:187.00f/255.0f blue:7.00f/255.0f alpha:1] size:CGSizeMake(90, 70)];
    });
    return indicator;
}

+ (void)showIndicatorView:(UIView *)view {
    [ZDIndicatorView shareIndicator].center = view.center;
    [view addSubview:[ZDIndicatorView shareIndicator]];
    [[ZDIndicatorView shareIndicator] startAnimating];
}

+ (void)dismiss {
    [[ZDIndicatorView shareIndicator] stopAnimating];
}


@end
