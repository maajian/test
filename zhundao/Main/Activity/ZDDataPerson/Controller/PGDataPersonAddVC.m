//
//  PGDataPersonAddVC.m
//  jingjing
//
//  Created by maj on 2020/8/10.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "PGDataPersonAddVC.h"

#import "PGDataPersonAddModel.h"

#import "PGDataPersonAddCell.h"

#import "PGDataPersonAddViewModel.h"

@interface PGDataPersonAddVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) PGDataPersonAddViewModel *viewModel;

@end

@implementation PGDataPersonAddVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSet];
    [self initLayout];
}

#pragma mark --- Lazyload
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 44;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.1)];
        [_tableView registerClass:[PGDataPersonAddCell class] forCellReuseIdentifier:ZD_ClassName([PGDataPersonAddCell class])];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.sectionHeaderHeight = 0.1;
        _tableView.sectionFooterHeight = 0.1;
    }
    return _tableView;
}

#pragma mark --- Init
- (void)initSet {
    self.title = @"添加管理员";
    _viewModel = [[PGDataPersonAddViewModel alloc] init];
    [self.view addSubview:self.tableView];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem saveTextItemWithTarget:self action:@selector(saveAction)];
}
- (void)initLayout {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

#pragma mark --- Network

#pragma mark --- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PGDataPersonAddCell *cell = [tableView dequeueReusableCellWithIdentifier:ZD_ClassName([PGDataPersonAddCell class])];
    cell.model = self.viewModel.dataSource[indexPath.row];
    return cell;
}

#pragma mark --- UITableViewDelegate

#pragma mark --- action
- (void)saveAction {
    [self.view endEditing:YES];
    ZD_WeakSelf
    NSString *name = self.viewModel.dataSource.firstObject.content;
    NSString *phone = self.viewModel.dataSource.lastObject.content;
    if (!name.length) {
        ZD_HUD_SHOW_ERROR_STATUS(@"请输入姓名")
        return;
    } else if (!phone.length) {
        ZD_HUD_SHOW_ERROR_STATUS(@"请输入正确的手机号");
        return;
    } else {
        ZD_HUD_SHOW_WAITING
        [self.viewModel addDataPersonWithActivityId:self.activityID userName:name phone:phone success:^{
            ZD_HUD_SHOW_SUCCESS_STATUS(@"添加成功");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.navigationController popViewControllerAnimated:YES];
            });
        } failure:^(NSError *error) {
            ZD_HUD_SHOW_ERROR(error)
        }];
    }
}

@end
