//
//  ZDDiscoverEditApplyVC.m
//  zhundao
//
//  Created by maj on 2018/12/2.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import "ZDDiscoverEditApplyVC.h"

#import "UpDataViewController.h"

#import "ZDDiscoveEditApplyCell.h"
#import "ZDDiscoveEditApplyHeaderView.h"
#import "ZDDiscoveEditApplyFooterView.h"
#import "ZDAlertSheet.h"

#import "ZDDiscoverCustomApplyModel.h"
#import "ZDDiscoveEditApplyViewModel.h"

static NSString *cellID = @"ZDDiscoveEditApplyCell";

@interface ZDDiscoverEditApplyVC ()<UITableViewDataSource, UITableViewDelegate, ZDDiscoveEditApplyFooterViewDelegate, ZDDiscoveEditApplyCellDelegate, ZDDiscoveEditApplyHeaderViewDelegate>
// 列表
@property (nonatomic, strong) UITableView *tableView;
// 头
@property (nonatomic, strong) ZDDiscoveEditApplyHeaderView *headerView;
// 逻辑视图
@property (nonatomic, strong) ZDDiscoveEditApplyViewModel *viewModel;

@end

@implementation ZDDiscoverEditApplyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem backImageItemWithTarget:self action:@selector(backAction:)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem saveTextItemWithTarget:self action:@selector(saveAction:)];
    self.title = self.viewModel.typeArray[_model.customType];
}

#pragma mark --- lazyload
// 列表
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTopBarHeight) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = ZDBackgroundColor;
        [_tableView registerClass:[ZDDiscoveEditApplyCell class] forCellReuseIdentifier:cellID];
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.1)];
        _tableView.tableFooterView = [UIView new];
        _tableView.rowHeight = 44;
    }
    return _tableView;
}

- (ZDDiscoveEditApplyViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ZDDiscoveEditApplyViewModel alloc] init];
        _viewModel.model = _model;
    }
    return _viewModel;
}

- (ZDDiscoveEditApplyHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[ZDDiscoveEditApplyHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, _model.ID ? 234 : 180)];
        _headerView.discoveEditApplyHeaderViewDelegate = self;
    }
    return _headerView;
}

#pragma mark --- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.isNeedChoice ? self.viewModel.dataArray.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZDDiscoveEditApplyCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.choiceTF.placeholder = [NSString stringWithFormat:@"选项%li",indexPath.row + 1];
    cell.choiceTF.text = self.viewModel.dataArray[indexPath.row];
    if (self.viewModel.dataArray.count <= 2) {
        [cell.leftButton setImage:[UIImage imageNamed:@"deleteCant"] forState:UIControlStateNormal];
        cell.leftButton.userInteractionEnabled = NO;
    } else {
        [cell.leftButton setImage:[UIImage imageNamed:@"deleteCan"] forState:UIControlStateNormal];
        cell.leftButton.userInteractionEnabled = YES;
    }
    cell.discoveEditApplyCellDelegate = self;
    return cell;
}

#pragma mark --- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return _model.ID ? 234 : 180;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 75;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, _model.ID ? 234 : 180)];
    [view addSubview:self.headerView];
    self.headerView.model = self.viewModel.model;
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    ZDDiscoveEditApplyFooterView *footer = [[ZDDiscoveEditApplyFooterView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 75)];
    footer.discoveEditApplyFooterViewDelegate = self;
    footer.isNew = !self.model.ID;
    footer.isNeedChoice = self.viewModel.isNeedChoice;
    return footer;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(layoutMargins)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}
#pragma mark --- ZDDiscoveEditApplyCellDelegate
// 点击删除cell
- (void)tableViewCell:(ZDDiscoveEditApplyCell *)tableViewCell didSelectButton:(UIButton *)button {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:tableViewCell];
    [self.viewModel.dataArray removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
    [self.tableView reloadData];
}

// 输入结束,数据源修改
- (void)tableViewCell:(ZDDiscoveEditApplyCell *)tableViewCell didEndEdit:(UITextField *)textField {
    NSInteger index = [self.tableView indexPathForCell:tableViewCell].row;
    [self.viewModel.dataArray replaceObjectAtIndex:index withObject:textField.text];
}

#pragma mark --- ZDDiscoveEditApplyFooterViewDelegate
// 增加cell
- (void)footerView:(UIView *)footerView didAddButton:(UIButton *)button {
    [self.viewModel.dataArray addObject:@""];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:[self.tableView numberOfRowsInSection:0]  inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
    [self.tableView reloadData];
    [self.tableView beginUpdates];
    [self.tableView setContentOffset:CGPointMake(0, self.tableView.contentSize.height) animated:YES];
    [self.tableView endUpdates];
}

#pragma mark --- ZDDiscoveEditApplyHeaderViewDelegate
// 选取类型
- (void)headerView:(ZDDiscoveEditApplyHeaderView *)headerView didChangeType:(UILabel *)typeLabel {
    [self.view endEditing:YES];
    __weak typeof(self) weakSelf = self;
    ZDAlertSheet *sheet = [[ZDAlertSheet alloc] initWithFrame:[UIScreen mainScreen].bounds array:self.viewModel.typeArray title:@"请选择报名类型" isDelete:NO selectBlock:^(NSInteger index) {
        weakSelf.model.typeStr = self.viewModel.typeArray[index];
        weakSelf.model.customType = index;
        weakSelf.title = weakSelf.model.typeStr ;
        weakSelf.viewModel.model = weakSelf.model;
        [weakSelf.tableView reloadData];
    }];
    [self.view addSubview:sheet];
    [sheet fadeIn];
}
#pragma mark --- actiom
- (void)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)saveAction:(id)sender {
    __weak typeof(self) weakSelf = self;
    NSString *title = self.headerView.titleTF.text;
    if ([[title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        maskLabel *label = [[maskLabel alloc] initWithTitle:@"项目名称不能为空"];
        [label labelAnimationWithViewlong:self.view];
    } else if (self.model.customType == ZDCustomTypeOneText && title.length > 50) {
        maskLabel *label = [[maskLabel alloc] initWithTitle:@"单文本字数不能超出50"];
        [label labelAnimationWithViewlong:self.view];
    } else {
        __block BOOL isContinue = YES;
        [weakSelf.viewModel.dataArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (![obj stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length) {
                isContinue = NO;
                maskLabel *label = [[maskLabel alloc] initWithTitle:@"选项不能为空"];
                [label labelAnimationWithViewlong:weakSelf.view];
                *stop = YES;
            }
        }];
        
        if (!isContinue) return;
        if (self.model.ID) {
            [weakSelf.viewModel changeCustomtApplyWithTitle:title inputType:self.model.customType ID:self.model.ID require:self.headerView.mustSwitch.isOn tips:self.headerView.tipInputTF.text choiceArray:self.viewModel.dataArray success:^{
                [weakSelf.navigationController popViewControllerAnimated:YES];
            } failure:^(NSString * _Nonnull error) {
                
            }];
        } else {
            [weakSelf.viewModel newCustomApplyRequestWithTitle:title inputType:self.model.customType require:self.headerView.mustSwitch.isOn tips:self.headerView.tipInputTF.text choiceArray:self.viewModel.dataArray success:^(NSDictionary *obj) {
                if ([obj[@"errcode"] integerValue] == 0) {
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                } else if ([obj[@"errcode"] integerValue] == 100 || [obj[@"errcode"] integerValue] == 200) {
                    [self showAlertWithTitle:obj[@"errmsg"]];
                } else {
                    maskLabel *label = [[maskLabel alloc] initWithTitle:obj[@"errmsg"]];
                    [label labelAnimationWithViewlong:weakSelf.view];
                }
            } failure:^(NSString * _Nonnull error) {
                
            }];
        }
    }
}

#pragma mark --- public
- (void)showAlertWithTitle:(NSString *)title {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UpDataViewController *updata = [[UpDataViewController alloc]init];
        updata.isPresent = YES;
        updata.urlString = [NSString stringWithFormat:@"%@Activity/Upgraded?accesskey=%@",zhundaoH5Api,[[ZDDataManager shareManager] getaccseekey]];
        ZDBaseNavVC *nav = [[ZDBaseNavVC alloc] initWithRootViewController:updata];
        [self presentViewController:nav animated:YES completion:nil];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
