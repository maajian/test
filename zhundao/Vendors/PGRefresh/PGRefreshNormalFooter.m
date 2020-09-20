//
//  PGRefreshNormalFooter.m
//  zhundao
//
//  Created by maj on 2019/3/18.
//  Copyright © 2019年 zhundao. All rights reserved.
//

#import "PGRefreshNormalFooter.h"

@implementation PGRefreshNormalFooter

- (void)prepare {
    [super prepare];
    [self setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
    [self setTitle:@"正在加载更多数据"    forState:MJRefreshStateRefreshing];
    [self setTitle:@"已经全部加载完毕"   forState:MJRefreshStateNoMoreData];
    
}

@end
