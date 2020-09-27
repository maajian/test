#import "PGRefreshNormalFooter.h"
@implementation PGRefreshNormalFooter
- (void)prepare {
    [super prepare];
    [self setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
    [self setTitle:@"正在加载更多数据"    forState:MJRefreshStateRefreshing];
    [self setTitle:@"已经全部加载完毕"   forState:MJRefreshStateNoMoreData];
}
@end
