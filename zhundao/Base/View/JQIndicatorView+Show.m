//
//  JQIndicatorView+Show.m
//  zhundao
//
//  Created by zhundao on 2017/6/12.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "JQIndicatorView+Show.h"

@implementation JQIndicatorView (Show)
- (JQIndicatorView *)showWithView :(UIView *)view
{
  JQIndicatorView  *indicator = [[JQIndicatorView alloc]initWithType:3 tintColor: [UIColor colorWithRed:9.00f/255.0f green:187.00f/255.0f blue:7.00f/255.0f alpha:1] size:CGSizeMake(90, 70)];
    indicator.center = view.center;
    [view addSubview:indicator];
    [indicator startAnimating];
    return indicator;
}
@end
