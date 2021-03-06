//
//  ZDMeaageSystemVC.m
//  zhundao
//
//  Created by maj on 2019/5/26.
//  Copyright © 2019 zhundao. All rights reserved.
//

#import "ZDMeaageSystemVC.h"

#import "ChangeContentViewController.h"
#import "MessageContentCell.h"

#import "MessageContentViewModel.h"

#import "MessageContentModel.h"

@interface ZDMeaageSystemVC ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)MessageContentViewModel *viewModel;

@end

static NSString *cellID = @"MessageContentCell";

@implementation ZDMeaageSystemVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSet];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
}
- (void)dealloc{
    NSLog(@"%@", [NSString stringWithFormat:@"%@dealloc",self.title]);
}

#pragma mark --- init
- (void)initSet {
    _viewModel = [[MessageContentViewModel alloc]init];
    [self.view addSubview:self.tableView];
}

#pragma mark --- 网络请求
- (void)getSystemContent {
    __weak typeof(self) weakSelf = self;
    [self.viewModel getSystemWithPageIndex:1 success:^(NSDictionary *obj) {
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView reloadData];
    } failure:^(NSString *error) {
        [weakSelf.tableView.mj_header endRefreshing];
        [[SignManager shareManager]showNotHaveNet:weakSelf.view];
    }];
}


#pragma mark --- lazyload
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64 - 50)];
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.backgroundColor = ZDBackgroundColor;
         [_tableView registerClass:[MessageContentCell class] forCellReuseIdentifier:@"MessageContentCell"];
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.1)];
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.layer.borderWidth = 1;
        _tableView.layer.borderColor = ZDLineColor.CGColor;
        _tableView.mj_header = [ZDRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getSystemContent)];
    }
    return _tableView;
}

#pragma mark -------UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.systemArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageContentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.model = self.viewModel.systemArray[indexPath.row];
    return cell;
}
#pragma mark -------UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.viewModel.systemHeightArray[indexPath.row] integerValue];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageContentModel *model = self.viewModel.systemArray[indexPath.row];
    [[NSNotificationCenter defaultCenter] postNotificationName:ZDNotification_Message_Select object:model.es_content];
    [self.navigationController popViewControllerAnimated:YES];
}
// 将要展示cell 补全分割线
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        cell.layoutMargins = UIEdgeInsetsZero;
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        cell.separatorInset = UIEdgeInsetsZero;
    }
}

@end
