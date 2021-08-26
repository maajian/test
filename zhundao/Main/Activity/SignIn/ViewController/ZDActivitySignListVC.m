//
//  ZDActivitySignListVC.m
//  zhundao
//
//  Created by maj on 2021/5/12.
//  Copyright © 2021 zhundao. All rights reserved.
//

#import "ZDActivitySignListVC.h"

#import "ZDActivityPostSignVC.h"
#import "CodeViewController.h"
#import "PostEmailViewController.h"
#import "LoadAllSignViewController.h"

#import "ZDActivitySignCell.h"
#import "ZDActivitySigninEmptyView.h"
#import "GZActionSheet.h"

#import "ZDActivitySignVM.h"

@interface ZDActivitySignListVC ()<UITableViewDataSource, UITableViewDelegate, ZDActivitySignCellDelegate>
@property (nonatomic, strong) ZDActivitySignVM *viewModel;
@property (nonatomic, strong) ZDActivitySigninEmptyView *emptyView;
@property (nonatomic, assign) NSInteger page;

@end

@implementation ZDActivitySignListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSet];
    [self initLayout];
    [self initNotification];
    
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark --- Init
- (void)initSet {
    ZD_WeakSelf
    self.page = 1;
    self.title = @"签到";
    _viewModel = [[ZDActivitySignVM alloc] init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ZD_ScreenWidth, 0.1)];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.sectionHeaderHeight = CGFLOAT_MIN;
    self.tableView.sectionFooterHeight = CGFLOAT_MIN;
    [self.tableView registerClass:[ZDActivitySignCell class] forCellReuseIdentifier:NSStringFromClass([ZDActivitySignCell class])];
    self.tableView.mj_header = [ZDRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer = [ZDRefreshNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem addWhiteImageItemWithTarget:self action:@selector(addAction)];
    self.errorViewTapedBlock = ^{
        weakSelf.isLoading = YES;
        weakSelf.page = 1;
        [weakSelf loadNewData];
        DDLogVerbose(@"点击error"); 
    };
    self.emptyViewTapedBlock = ^{
        weakSelf.isLoading = YES;
        weakSelf.page = 1;
        [weakSelf loadNewData];
        DDLogVerbose(@"点击了空");
    };
    self.emptyCustomView = self.emptyView;
    self.tableView.rowHeight = 162;
    [self.view addSubview:self.tableView];
}
- (void)initLayout {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}
- (void)initNotification {
    [ZD_NotificationCenter addObserver:self selector:@selector(loadNewData) name:ZDUserDefault_Update_Sign object:nil];
}

#pragma mark --- Network
- (void)loadNewData {
    self.page = 1;
    ZD_WeakSelf
    self.isLoading = YES;
    [self.viewModel getSignListWithPage:self.page activityID:self.activityModel.ID success:^{
        weakSelf.isLoading = NO;
        weakSelf.isEmpty = weakSelf.viewModel.dataSource.count == 0;
        [weakSelf.tableView endRefresh];
        [weakSelf.tableView reloadData];
    } failure:^{
        weakSelf.isLoading = NO;
        [weakSelf.tableView endRefresh];
        ZD_HUD_SHOW_ERROR_STATUS(@"请检查网络设置")
    }];
}
- (void)loadMoreData {
    self.page += 1;
    ZD_WeakSelf
    self.isLoading = YES;
    [self.viewModel getSignListWithPage:self.page activityID:self.activityModel.ID success:^{
        weakSelf.isLoading = NO;
        weakSelf.isEmpty = weakSelf.viewModel.dataSource.count == 0;
        [weakSelf.tableView endRefresh];
        [weakSelf.tableView reloadData];
    } failure:^{
        weakSelf.isLoading = NO;
        [weakSelf.tableView endRefresh];
        ZD_HUD_SHOW_ERROR_STATUS(@"请检查网络设置")
    }];
}

#pragma mark --- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZDActivitySignCell *cell = [tableView dequeueReusableCellWithIdentifier:ZD_ClassName([ZDActivitySignCell class])];
    cell.signInModel = self.viewModel.dataSource[indexPath.section];
    cell.activitySignCellDelegate = self;
    return cell;
}

#pragma mark --- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    view.backgroundColor = ZDBackgroundColor;
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

#pragma mark --- ZDActivitySignCellDelegate
- (void)activitySignCell:(ZDActivitySignCell *)activitySignCell didTapMoreButton:(UIButton *)button {
    NSArray *array = @[@"删除签到",@"修改签到",@"微信签到二维码",@"手机号签到二维码",@"导出签到名单"];
    GZActionSheet *sheet = [[GZActionSheet alloc]initWithTitleArray:array WithRedIndex:1 andShowCancel:YES];
    ZD_WeakSelf
    sheet.ClickIndex = ^(NSInteger index){
        DDLogVerbose(@"Show Index %zi",index); //取消0
        if (index==1) {
              [weakSelf deleteSign:activitySignCell.signInModel];
            
        } else if (index==2) {
           ZDActivityPostSignVC *post = [[ZDActivityPostSignVC alloc] init];
           post.signModel = activitySignCell.signInModel;
           [self.navigationController pushViewController:post animated:YES];
        }
        // 微信签到二维码
       else if (index==3) {
           CodeViewController *code = [[CodeViewController alloc]init];
           NSString *imagestr =   [NSString stringWithFormat:@"%@ck/%li/%li/3",zhundaoH5Api,(long)activitySignCell.signInModel.ID,(long)activitySignCell.signInModel.ActivityID];
           code.imagestr = imagestr;
           code.titlestr = activitySignCell.signInModel.Name;
           code.labelStr = @"签到";
           [self presentViewController:code animated:YES completion:^{
               
           }];
       }
        // 手机号签到二维码
       else if(index==4){
           CodeViewController *code = [[CodeViewController alloc]init];
           NSString *imagestr =   [NSString stringWithFormat:@"%@ckp/%li/%li/11",zhundaoH5Api,activitySignCell.signInModel.ID,(long)activitySignCell.signInModel.ActivityID];
           code.imagestr = imagestr;
           code.titlestr = activitySignCell.signInModel.Name;
           code.labelStr = @"手机号签到";
           [self presentViewController:code animated:YES completion:nil];
       } else{
           PostEmailViewController *post = [[PostEmailViewController alloc]init];
           post.signID = activitySignCell.signInModel.ID;
           [self.navigationController pushViewController:post animated:YES];
       }
    };
    [ZD_KeyWindow addSubview:sheet];
}
- (void)activitySignCell:(ZDActivitySignCell *)activitySignCell didTapOpenSwitch:(UISwitch *)openSwitch {
    [ZDAlertView alertWithTitle:@"是否改变签到状态" message:nil sureBlock:^{
        NSString *listurl = [NSString stringWithFormat:@"%@api/CheckIn/UpdateCheckIn?accessKey=%@&checkInId=%li",zhundaoApi,[[SignManager shareManager] getaccseekey],(long)activitySignCell.signInModel.ID];
        [ZD_NetWorkM getDataWithMethod:listurl parameters:nil succ:^(NSDictionary *obj) {
            
        } fail:^(NSError *error) {
            openSwitch.on = !openSwitch.on;
        }];
    } cancelBlock:nil];

}
- (void)activitySignCell:(ZDActivitySignCell *)activitySignCell didTapSignButton:(UIButton *)button {
    LoadAllSignViewController *load = [[LoadAllSignViewController alloc]init];
    load.signInModel = activitySignCell.signInModel;
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:load animated:YES];
    ZD_WeakSelf
    load.block = ^(NSInteger a) {
        [weakSelf loadNewData];
    };
}

#pragma mark --- Private
- (void)addAction {
    ZDActivityPostSignVC *post = [[ZDActivityPostSignVC alloc] init];
    post.activityModel = self.activityModel;
    [self.navigationController pushViewController:post animated:YES];
}
// 删除签到
- (void)deleteSign:(ZDSignInModel *)model {
    NSString *str = [NSString stringWithFormat:@"%@api/v2/checkIn/deleteCheckIn?token=%@&checkInId=%li&from=ios",zhundaoApi,[[SignManager shareManager] getToken],(long)model.ID];
    ZD_HUD_SHOW_WAITING
    ZD_WeakSelf
    [ZD_NetWorkM getDataWithMethod:str parameters:nil succ:^(NSDictionary *obj) {
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:obj];
        ZD_HUD_DISMISS
        NSInteger index = [weakSelf.viewModel.dataSource indexOfObject:model];
        [weakSelf.viewModel.dataSource removeObject:model];
        [weakSelf.tableView deleteSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:(UITableViewRowAnimationFade)];
    } fail:^(NSError *error) {
        ZD_HUD_SHOW_ERROR(error)
        DDLogVerbose(@"error = %@",error);
    }];
}


#pragma mark --- Lazyload
- (ZDActivitySigninEmptyView *)emptyView {
    if (!_emptyView) {
        ZD_WeakSelf
        _emptyView = [[ZDActivitySigninEmptyView alloc] initWithEmptyBlock:^{
            ZDActivityPostSignVC *post = [[ZDActivityPostSignVC alloc] init];
            post.activityModel = weakSelf.activityModel;
            [weakSelf.navigationController pushViewController:post animated:YES];
        }];
    }
    return _emptyView;
}

@end
