//
//  PGRefreshNormalHeader.m
//  zhundao
//
//  Created by maj on 2019/3/18.
//  Copyright © 2019年 zhundao. All rights reserved.
//

#import "PGRefreshNormalHeader.h"

@implementation PGRefreshNormalHeader

- (void)prepare {
    [super prepare];
    [self setTitle:@"下拉刷新"  forState:MJRefreshStateIdle];
    [self setTitle:@"释放刷新" forState:MJRefreshStatePulling];
    [self setTitle:@"加载中，请等待 ..." forState:MJRefreshStateRefreshing];
    self.lastUpdatedTimeLabel.hidden = YES;
}

@end
