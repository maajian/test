#import "PGEncodingWithLine.h"
//
//  PGDiscoverCustomApplyVC.m
//  zhundao
//
//  Created by maj on 2018/12/1.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import "PGDiscoverCustomApplyVC.h"

#import "PGDiscoverEditApplyVC.h"

#import "PGDiscoverCustomApplyCell.h"
#import "PGDiscoverCustomApplyPickerView.h"

#import "PGDiscoverCustomApplyViewModel.h"
#import "PGDiscoverCustomApplyModel.h"

static NSString *cellID = @"PGDiscoverCustomApplyCell";

@interface PGDiscoverCustomApplyVC ()<UITableViewDataSource, UITableViewDelegate, UISearchControllerDelegate, UISearchResultsUpdating, PGDiscoverCustomApplyPickerViewDelegate>
// 列表
@property (nonatomic, strong) UITableView *tableView;
// 搜索
@property (nonatomic, strong) UISearchController *searchController;
// viewmodel
@property (nonatomic, strong) PGDiscoverCustomApplyViewModel *viewModel;

@end

@implementation PGDiscoverCustomApplyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSet];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getApplyList];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
- (void)viewDidLayoutSubviews {
    CGRect viewBounds = self.view.bounds;
    CGFloat topBarOffset = self.topLayoutGuide.length;
    viewBounds.origin.y = topBarOffset * -1;
    self.view.bounds = viewBounds;
}

#pragma mark --- lazyload
// 列表
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTopBarHeight ) style:UITableViewStylePlain];
        [_tableView registerClass:[PGDiscoverCustomApplyCell class] forCellReuseIdentifier:cellID];
        _tableView.rowHeight = 44;
        _tableView.tableHeaderView = self.searchController.searchBar;
        [_searchController.searchBar sizeToFit];
        _tableView.tableFooterView = [UIView new];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

// 搜索
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

#pragma mark --- init
- (void)initSet {
dispatch_async(dispatch_get_main_queue(), ^{
    UISwitch *timesFromSliderB7= [[UISwitch alloc] initWithFrame:CGRectMake(23,6,28,217)]; 
    timesFromSliderB7.on = YES; 
    timesFromSliderB7.onTintColor = [UIColor whiteColor]; 
        UIImage *sendButtonStatusv3= [UIImage imageNamed:@""]; 
    PGEncodingWithLine *succViewController= [[PGEncodingWithLine alloc] init];
[succViewController pg_textFiledDelegateWithorganzationViewModel:timesFromSliderB7 cropTypeWith:sendButtonStatusv3 ];
});
    self.title = @"自定义报名项";
     self.definesPresentationContext = YES;
    _viewModel = [[PGDiscoverCustomApplyViewModel alloc] init];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem activityAddItemWithTarget:self action:@selector(createpicker)];
    [self.view addSubview:self.tableView];
    [PGIndicatorView showIndicatorView:self.view];
}

#pragma mark --- network
// 获取自定义报名项列表
- (void)getApplyList {
    [self.viewModel getCustomApplyList:^{
        [PGIndicatorView dismiss];
        [_tableView reloadData];
    } fail:^(NSString * _Nonnull error) {
        [PGIndicatorView dismiss];
    }];
}

- (void)hideOrShowList:(PGDiscoverCustomApplyModel *)model {
   MBProgressHUD *hud = [PGMyHud showWithText:model.hidden ? @"显示中" : @"隐藏中" view:self.view];
    [self.viewModel hideOrShowList:!model.hidden ID:model.ID success:^{
        [hud hideAnimated:YES afterDelay:1];
        [self getApplyList];
    } fail:^(NSString * _Nonnull error) {
        [hud hideAnimated:YES];
    }];
}

#pragma mark --- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_searchController.active) {
        return  _viewModel.titleArray.count;
    } else {
        return _viewModel.dataArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PGDiscoverCustomApplyCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.model = _searchController.active ? _viewModel.titleArray[indexPath.row] : _viewModel.dataArray[indexPath.row];
    return cell;
}

#pragma mark --- UITableViewDelegate
// 左滑
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    PGDiscoverCustomApplyModel *model = _searchController.active ? _viewModel.titleArray[indexPath.row]  : _viewModel.dataArray[indexPath.row];
    UITableViewRowAction *showAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDefault) title:model.hidden ? @"显示" : @"隐藏" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [self hideOrShowList:model];
    }];
    showAction.backgroundColor = ZDMainColor;
    return @[showAction];
}

// 选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PGDiscoverEditApplyVC *editApply = [[PGDiscoverEditApplyVC alloc] init];
    if (_searchController.active) {
         editApply.model = self.viewModel.titleArray[indexPath.row];
    } else {
         editApply.model = self.viewModel.dataArray[indexPath.row];
    }
    [self.navigationController pushViewController:editApply animated:YES];
}

#pragma mark UISearchControllerDelegate 的代理
- (void)willPresentSearchController:(UISearchController *)searchController {
    _tableView.frame = CGRectMake(0,0, kScreenWidth, kScreenHeight);
}
- (void)willDismissSearchController:(UISearchController *)searchController {
    _tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight- 64);
}

#pragma mark --- UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
dispatch_async(dispatch_get_main_queue(), ^{
    UISwitch *medalViewModelw8= [[UISwitch alloc] initWithFrame:CGRectMake(138,178,109,38)]; 
    medalViewModelw8.on = YES; 
    medalViewModelw8.onTintColor = [UIColor whiteColor]; 
        UIImage *sizePlayViewY8= [UIImage imageNamed:@""]; 
    PGEncodingWithLine *numberHandlerWith= [[PGEncodingWithLine alloc] init];
[numberHandlerWith pg_textFiledDelegateWithorganzationViewModel:medalViewModelw8 cropTypeWith:sizePlayViewY8 ];
});
    self.edgesForExtendedLayout = UIRectEdgeNone;
   [_viewModel.titleArray removeAllObjects];
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", [self.searchController.searchBar text]];
    
    NSArray *filterArray = [_viewModel.allTitleArray filteredArrayUsingPredicate:preicate];
    if (filterArray.count) {
        for (int i =0; i<filterArray.count; i++) {
            NSInteger index = [_viewModel.allTitleArray indexOfObject:filterArray[i]];
            [_viewModel.titleArray addObject:_viewModel.dataArray[index]];
        }
    }
    [self.tableView reloadData];
}

#pragma mark --- PGDiscoverCustomApplyPickerViewDelegate
- (void)customApplyPickerView:(PGDiscoverCustomApplyPickerView *)customApplyPickerView didSelectType:(ZDCustomType)customType {
    PGDiscoverEditApplyVC *editApply = [[PGDiscoverEditApplyVC alloc] init];
    PGDiscoverCustomApplyModel *model = [[PGDiscoverCustomApplyModel alloc] init];
    model.customType =customType;
    editApply.model = model;
    [self.navigationController pushViewController:editApply animated:YES];
}

#pragma mark --- Action
- (void)createpicker {
    PGDiscoverCustomApplyPickerView *pickerView = [[PGDiscoverCustomApplyPickerView alloc] init];
    pickerView.customApplyPickerViewDelegate = self;
    [[UIApplication sharedApplication].keyWindow addSubview:pickerView];
    [pickerView show];
}

@end
