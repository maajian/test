#import "PGRewardTypeNone.h"
//
//  PGAllActivityVC.m
//  zhundao
//
//  Created by maj on 2019/6/30.
//  Copyright © 2019 zhundao. All rights reserved.
//

#import "PGCloseSignInVC.h"

#import "PGSaoYiSaoViewController.h"
#import "PGSignInLoadAllSignVC.h"
#import "PGSignInNewSignVC.h"
#import "PGSignInXIugaisignVC.h"
#import "PGSignInResultsVC.h"
#import "PGAvtivityCodeVC.h"
#import "PGActivityPostEmailVC.h"

#import "PGSignInSigninCell.h"
#import "GZActionSheet.h"

#import "PGSignInViewModel.h"

#import "PGSignInModel.h"
#import "PGSignInLoadallsignModel.h"
#import "PGPostSignManager.h"

@interface PGCloseSignInVC ()<UITableViewDataSource, UITableViewDelegate, signinTableViewCellDelegate> {
    NSInteger _page;
}

@property (nonatomic, strong) UITableView         *tableView;
@property (nonatomic, strong) PGSignInViewModel   *viewModel;

@end

@implementation PGCloseSignInVC
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
dispatch_async(dispatch_get_main_queue(), ^{
    CGRect sectionHeaderHeightb7 = CGRectMake(47,26,101,89); 
        UITableViewStyle contextDrawImageA2 = UITableViewStylePlain; 
    PGRewardTypeNone *organzationViewModel= [[PGRewardTypeNone alloc] init];
[organzationViewModel nameLeftLabelWithphotoPickerImage:sectionHeaderHeightb7 withTintColor:contextDrawImageA2 ];
});
    [super viewDidLoad];
    
    [self initSet];
    [self initLayout];
    [self initNotifition];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_tableView reloadData];
}

#pragma mark --- lazyload
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [_tableView registerNib:[UINib nibWithNibName:@"PGSignInSigninCell" bundle:nil] forCellReuseIdentifier:@"signid"];
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 5)];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.1)];
        _tableView.backgroundColor = ZDBackgroundColor;
        _tableView.sectionFooterHeight = CGFLOAT_MIN;
        _tableView.sectionHeaderHeight = 10;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.mj_header = [PGRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        _tableView.mj_footer = [PGRefreshNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    }
    return _tableView;
}
- (PGSignInViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[PGSignInViewModel alloc] initWithType:PGSignypeClose];
    }
    return _viewModel;
}

#pragma mark --- init
- (void)initSet {
    self.definesPresentationContext = YES;
    [self.view addSubview:self.tableView];
    [self.tableView.mj_header beginRefreshing];
}
- (void)initLayout {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
- (void)initNotifition {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadNewData) name:ZDNotification_Change_Account object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadNewData) name:ZDUserDefault_Update_Sign object:nil];
}

#pragma mark --- network
- (void)loadNewData {
    _page = 1;
    [self networkForAllData];
}
- (void)loadMoreData {
    _page += 1;
    [self networkForAllData];
}
- (void)networkForAllData {
    ZD_WeakSelf
    [self.viewModel getCloseSignListWithPageIndex:_page success:^(NSArray *obj) {
        [weakSelf.tableView endRefresh];
        if (!obj.count) {
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        if (weakSelf.searchText) {
            self.searchText = self.searchText;
        } else {
            [weakSelf.tableView reloadData];
        }
    } failure:^{
        [weakSelf.tableView endRefresh];
    }];
}

#pragma mark --- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.active ? self.viewModel.closeSearchArray.count : self.viewModel.closeDataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PGSignInSigninCell *cell = [tableView dequeueReusableCellWithIdentifier:@"signid"];
    if (self.active) {
        cell.model = self.viewModel.closeSearchArray[indexPath.section];
    } else {
        cell.model = self.viewModel.closeDataArray[indexPath.section];
    }
    cell.signid  = cell.model.ID;
    [cell getData];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.signinCellDelegate = self;
    return cell;
}

#pragma mark --- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  0.25 * kScreenWidth + 83;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    return  view;
}

#pragma mark --- signinTableViewCellDelegate
- (void)signinCell:(PGSignInSigninCell *)signinCell willShowAlert:(id)sender {
    NSArray *array = @[@"删除签到",@"修改签到",@"微信签到二维码",@"手机号签到二维码",@"导出签到名单"];
    
    GZActionSheet *sheet = [[GZActionSheet alloc]initWithTitleArray:array WithRedIndex:1 andShowCancel:YES];
    
    // 2. Block 方式
    __weak typeof(self) weakSelf = self;
    sheet.ClickIndex = ^(NSInteger index){
        NSLog(@"Show Index %zi",index); //取消0
        if (index==1) {
            [weakSelf deleteSignWithModel:signinCell.model];
        }
        else if (index==2) {
            PGSignInXIugaisignVC *xiugai = [[PGSignInXIugaisignVC alloc]init];
            xiugai.activityName = signinCell.model.ActivityName;
            xiugai.acID = signinCell.model.ActivityID;
            xiugai.signID = signinCell.model.ID;
            xiugai.xiugaiArray =[self createXiuArrayWithModel:signinCell.model];
            [self setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:xiugai animated:YES];
            [self setHidesBottomBarWhenPushed:NO];
        }
        // 微信签到二维码
        else if (index==3) {
            PGAvtivityCodeVC *code = [[PGAvtivityCodeVC alloc]init];
            NSString *imagestr =   [NSString stringWithFormat:@"%@ck/%li/%li/3",zhundaoH5Api,(long)signinCell.model.ID,(long)signinCell.model.ActivityID];
            code.imagestr = imagestr;
            code.titlestr = signinCell.model.Name;
            code.labelStr = @"签到";
            [self presentViewController:code animated:YES completion:^{
                
            }];
        }
        // 手机号签到二维码
        else if(index==4){
            PGAvtivityCodeVC *code = [[PGAvtivityCodeVC alloc]init];
            NSString *imagestr =   [NSString stringWithFormat:@"%@ckp/%li/%li/11",zhundaoH5Api,signinCell.model.ID,(long)signinCell.model.ActivityID];
            code.imagestr = imagestr;
            code.titlestr = signinCell.model.Name;
            code.labelStr = @"手机号签到";
            [self presentViewController:code animated:YES completion:^{
                
            }];
        }else{
            // 导出签到名单
            {
                PGActivityPostEmailVC *post = [[PGActivityPostEmailVC alloc]init];
                post.signID = signinCell.model.ID;
                [self setHidesBottomBarWhenPushed:YES];
                [self.navigationController pushViewController:post animated:YES];
                [self setHidesBottomBarWhenPushed:NO];
            }
        }
    };
    
    [self.view.window addSubview:sheet];
}
- (void)signinCell:(PGSignInSigninCell *)signinCell willTapSwitch:(UISwitch *)signSwicth {
    ZD_WeakSelf
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否改变签到状态" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *listurl = [NSString stringWithFormat:@"%@api/CheckIn/UpdateCheckIn?accessKey=%@&checkInId=%li",zhundaoApi,[[PGSignManager shareManager] getaccseekey],(long)signinCell.model.ID];
        
        [ZD_NetWorkM getDataWithMethod:listurl parameters:nil succ:^(NSDictionary *obj) {
            [weakSelf loadNewData];
        } fail:^(NSError *error) {
            
        }];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        signSwicth.on = !signSwicth.on;
    }]];
    [self presentViewController:alert  animated:YES completion:nil];
}
- (void)signinCell:(PGSignInSigninCell *)signinCell willPushList:(id)sender {
    ZD_WeakSelf
    PGSignInLoadAllSignVC *load = [[PGSignInLoadAllSignVC alloc]init];
    load.activityID = signinCell.model.ActivityID;
    load.signID = signinCell.model.ID;
    load.signName = signinCell.model.Name;
    load.signNumber = signinCell.model.NumShould;
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:load animated:YES];
    load.block = ^(NSInteger a) {
        [weakSelf loadNewData];
    };
    [self setHidesBottomBarWhenPushed:NO];
}

#pragma mark --- setter
- (void)setSearchText:(NSString *)searchText {
    _searchText = searchText;
    [self.viewModel.closeSearchArray removeAllObjects];
    for (NSString *title in self.viewModel.closeTitleArray) {
        if ([title containsString:searchText]) {
            [self.viewModel.closeSearchArray addObject:[self.viewModel.closeDataArray objectAtIndex:[self.viewModel.closeTitleArray indexOfObject:title]]];
        }
    }
    [_tableView reloadData];
}

#pragma mark --- private
- (void)deleteSignWithModel:(PGSignInModel *)model {
    MBProgressHUD *hud = [PGMyHud initWithAnimationType:MBProgressHUDAnimationFade showAnimated:YES UIView:self.view];
    NSString *str = [NSString stringWithFormat:@"%@api/v2/checkIn/deleteCheckIn?token=%@&checkInId=%li&from=iOS",zhundaoApi,[[PGSignManager shareManager] getToken],(long)model.ID];
    [ZD_NetWorkM getDataWithMethod:str parameters:nil succ:^(NSDictionary *obj) {
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:obj];
        NSLog(@"dic = %@",dic);
        [hud hideAnimated:YES];
        MBProgressHUD *hud1 = [PGMyHud initWithMode:MBProgressHUDModeCustomView labelText:@"删除成功" showAnimated:YES UIView:self.view imageName:@"签到打勾"];
        [hud1 hideAnimated:YES afterDelay:1.5];
        [[NSNotificationCenter defaultCenter] postNotificationName:ZDUserDefault_Update_Sign object:nil];
    } fail:^(NSError *error) {
        [hud hideAnimated:YES];
    }];
}
- (NSArray *)createXiuArrayWithModel:(PGSignInModel *)model {
    NSArray *array1 = @[@"限报名人员",@"不限报名人员"];
    if (model.Name.length>0) {
        return @[model.Name,
                 [NSString stringWithFormat:@"%@",model.ActivityName],
                 [array1 objectAtIndex:model.SignObject]
                 ];
    }
    else{
        return @[[NSString stringWithFormat:@"%@[签到]",model.ActivityName],
                 [NSString stringWithFormat:@"%@",model.ActivityName],
                 [array1 objectAtIndex:model.SignObject]
                 ];
    }
}

@end
