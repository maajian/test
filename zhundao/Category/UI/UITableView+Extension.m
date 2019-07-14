//
//  UITableView+Extension.m
//  zhundao
//
//  Created by maj on 2019/7/6.
//  Copyright © 2019 zhundao. All rights reserved.
//

#import "UITableView+Extension.h"

@implementation UITableView (Extension)

- (void)endRefresh {
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
}

@end
