//
//  ZDMeMessageVC.m
//  jingjing
//
//  Created by maj on 2020/8/4.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "ZDMeMessageVC.h"

#import "ZDMeMessageCell.h"

@interface ZDMeMessageVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation ZDMeMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark --- Lazyload
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTopBarHeight) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = ZDBackgroundColor;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
        [_tableView registerClass:[ZDMeMessageCell class] forCellReuseIdentifier:NSStringFromClass([ZDMeMessageCell class])];
        _tableView.sectionHeaderHeight = 0.1;
        _tableView.sectionFooterHeight = 10;
        _tableView.rowHeight = 71;
    }
    return _tableView;
}


#pragma mark --- Init
- (void)initSet {
    [self.view addSubview:self.tableView];
}
- (void)initLayout {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

#pragma mark --- Network

#pragma mark --- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZDMeMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    return cell;
}

#pragma mark --- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDefault) title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
    }];
    deleteAction.backgroundColor = ZDRedColor;
    return @[deleteAction];
}

@end
