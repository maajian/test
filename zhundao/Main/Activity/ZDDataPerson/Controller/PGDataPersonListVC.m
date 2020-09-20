//
//  PGDataPersonListVC.m
//  jingjing
//
//  Created by maj on 2020/8/5.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "PGDataPersonListVC.h"

#import "PGDataPersonCell.h"
#import "PGDataPersonModel.h"
#import "PGDataPersonViewModel.h"
#import "PGDataPersonAddVC.h"

@interface PGDataPersonListVC()<UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating,UISearchControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchController *searchController;

@property (nonatomic, strong) PGDataPersonViewModel *viewModel;

@end

@implementation PGDataPersonListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSet];
    [self.tableView.mj_header beginRefreshing];
}
- (void)viewDidLayoutSubviews {
    CGRect viewBounds = self.view.bounds;
    CGFloat topBarOffset = self.topLayoutGuide.length;
    viewBounds.origin.y = topBarOffset * -1;
    self.view.bounds = viewBounds;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self networkForGetPersonList];
}

#pragma mark --- Lazyload
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 60;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.1)];
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView registerClass:[PGDataPersonCell class] forCellReuseIdentifier:ZD_ClassName([PGDataPersonCell class])];
        _tableView.sectionHeaderHeight = 0.1;
        _tableView.sectionFooterHeight = 0.1;
        _tableView.mj_header = [PGRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(networkForGetPersonList)];
        _tableView.tableHeaderView = self.searchController.searchBar;
        [_searchController.searchBar sizeToFit];
        _tableView.separatorColor = ZDLineColor;
    }
    return _tableView;
}
- (UISearchController *)searchController {
    if (!_searchController) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        _searchController.searchBar.frame = CGRectMake(0,5,kScreenWidth-40, 40);
        _searchController.searchBar.placeholder = @"搜索";
        _searchController.searchBar.barTintColor = ZDBackgroundColor;
        _searchController.searchBar.backgroundColor = ZDBackgroundColor;
        _searchController.dimsBackgroundDuringPresentation = NO;
        _searchController.delegate = self;
        _searchController.searchResultsUpdater = self;
        //搜索时，背景变模糊
        [_searchController.searchBar setBackgroundImage:[UIImage new]];
    }
    return _searchController;
}

#pragma mark --- Init
- (void)initSet {
    self.title = @"管理员";
    self.definesPresentationContext = YES;
    _viewModel = [[PGDataPersonViewModel alloc] init];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem activityAddItemWithTarget:self action:@selector(rightAction)];
    [self.view addSubview:self.tableView];
}

#pragma mark --- Network
- (void)networkForGetPersonList {
    ZD_WeakSelf
    [self.viewModel networkForGetDataPersonListActivityId:self.activityID success:^{
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {
        [weakSelf.tableView.mj_header endRefreshing];
        ZD_HUD_SHOW_ERROR(error)
    }];
}

#pragma mark --- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_searchController.active) {
        return self.viewModel.selectNameSource.count;
    } else {
        return self.viewModel.dataSource.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PGDataPersonCell *cell = [tableView dequeueReusableCellWithIdentifier:ZD_ClassName([PGDataPersonCell class])];
    cell.model = _searchController.active ? self.viewModel.selectNameSource[indexPath.row] : self.viewModel.dataSource[indexPath.row];
    return cell;
}

#pragma mark --- UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        cell.layoutMargins = UIEdgeInsetsZero;
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        cell.separatorInset = UIEdgeInsetsZero;
    }
}

#pragma mark UISearchControllerDelegate 的代理
- (void)willPresentSearchController:(UISearchController *)searchController {
    _tableView.frame = CGRectMake(0,0, kScreenWidth, kScreenHeight);
}
- (void)willDismissSearchController:(UISearchController *)searchController {
    _tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight- 64);
}

#pragma mark UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    [_viewModel.selectNameSource removeAllObjects];
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", [self.searchController.searchBar text]];
    NSArray *filterArray = [_viewModel.allNameSource filteredArrayUsingPredicate:preicate];
    if (filterArray.count) {
        for (int i =0; i<filterArray.count; i++) {
            NSInteger index = [_viewModel.allNameSource indexOfObject:filterArray[i]];
            [_viewModel.selectNameSource addObject:_viewModel.dataSource[index]];
        }
    }
    [self.tableView reloadData];
}

#pragma mark --- Action
- (void)rightAction {
    PGDataPersonAddVC *add = [[PGDataPersonAddVC alloc] init];
    add.activityID = self.activityID;
    [self.navigationController pushViewController:add animated:YES];
}

@end
