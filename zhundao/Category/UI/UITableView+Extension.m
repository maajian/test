#import "UITableView+Extension.h"
@implementation UITableView (Extension)
- (void)endRefresh {
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
}
@end
