#import "PGSocialMessageObject.h"
//
//  PGMeMoreAcountViewController.m
//  zhundao
//
//  Created by xhkj on 2018/1/19.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import "PGMeMoreAcountViewController.h"
#import "PGMeMoreAccountLoginViewController.h"

#import "PGMeMoreAccountTableViewCell.h"

#import "PGMeMoreAccountViewModel.h"
#import "PGloginMainViewModel.h"
static NSString *moreAccountCellID = @"moreAccountCellID";
@interface PGMeMoreAcountViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) PGMeMoreAccountViewModel *viewModel;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) NSInteger selectRow;

@end

@implementation PGMeMoreAcountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"切换账号";
    _selectRow = 1000;
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"wechatLogin"] boolValue] && [[NSUserDefaults standardUserDefaults]objectForKey:@"mobile"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"userArray"]) {
        NSArray *userArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"userArray"];
        for (NSDictionary *dic in userArray) {
            if ([dic[@"phone"] isEqualToString:[[NSUserDefaults standardUserDefaults]objectForKey:@"mobile"]]) {
                _selectRow  = [userArray indexOfObject:dic];
            }
        }
    }
    [self.view addSubview:self.tableView];
    [self addNavigationItem];
    [self getData];
    // Do any additional setup after loading the view.
}

#pragma mark --- 懒加载
- (PGMeMoreAccountViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[PGMeMoreAccountViewModel alloc] init];
    }
    return _viewModel;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight -64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 70;
        _tableView.tableHeaderView = [self getHeaderView];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = ZDBackgroundColor;
        [_tableView registerClass:[PGMeMoreAccountTableViewCell class] forCellReuseIdentifier:moreAccountCellID];
    }
    return _tableView;
}

- (UIView *)getHeaderView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth, 30)];
    label.text = @"切换账号";
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = kColorA(153, 153, 153, 1);
    [headerView addSubview:label];
    return headerView;
}

#pragma mark ---数据获取
- (void)getData {
    __weak typeof(self) weakSelf = self;
    [self.viewModel getListData:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.tableView reloadData];
    }];
}

#pragma mark --- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.userArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PGMeMoreAccountTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:moreAccountCellID];
    cell.model = self.viewModel.userArray[indexPath.row];
    if (_selectRow == indexPath.row) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellSeparatorStyleNone;
    }
    return cell;
}

#pragma mark --- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
dispatch_async(dispatch_get_main_queue(), ^{
    NSMutableArray *bindWithOpenm4= [NSMutableArray array];
        UIView *assetFromImagez2= [[UIView alloc] initWithFrame:CGRectZero]; 
    assetFromImagez2.backgroundColor = [UIColor whiteColor]; 
    assetFromImagez2.layer.cornerRadius = 
    assetFromImagez2.layer.masksToBounds = YES; 
    PGSocialMessageObject *sourceTypeSaved= [[PGSocialMessageObject alloc] init];
[sourceTypeSaved pg_previousPerformRequestsWithdecimalNumberHandler:bindWithOpenm4 backButtonClick:assetFromImagez2 ];
});
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == _selectRow) {
        return;
    }
    
    PGMeMoreAccountTableViewCell *oriCell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_selectRow inSection:0]];
    oriCell.accessoryType = UITableViewCellSeparatorStyleNone;
    
    PGMeMoreAccountTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    _selectRow = indexPath.row;
    
    [self login];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == _selectRow) {
        return NO;
    }
    return YES;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    PGMeMoreAccountModel *model = self.viewModel.userArray[indexPath.row];
    
    __weak typeof(self) weakSelf = self;
    /*! 删除 */
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {

        NSMutableArray *userArray = [[[NSUserDefaults standardUserDefaults] objectForKey:@"userArray"] mutableCopy];
        NSInteger deleteIndex = 0;
        for (int i = 0; i < userArray.count; i ++) {
            NSDictionary *datadic = [userArray objectAtIndex:i];
            if ([datadic[@"phone"] isEqualToString:model.phone]) {
                deleteIndex = i;
                break;
            }
        }
        [userArray removeObjectAtIndex:deleteIndex];
        [[NSUserDefaults standardUserDefaults] setObject:userArray forKey:@"userArray"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        /*! 防止删除位置 */
        if ((indexPath.row < _selectRow)) {
            _selectRow = _selectRow - 1;
        }
        
        [weakSelf getData];
    }];
    deleteAction.backgroundColor = [UIColor redColor];
    return @[deleteAction];
}

#pragma mark --- 点击登陆

- (void)login {
     NSArray *userArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"userArray"];
    NSDictionary *userdic = [userArray objectAtIndex:_selectRow];
     MBProgressHUD *_hud = [PGMyHud initWithAnimationType:MBProgressHUDAnimationFade showAnimated:YES UIView:self.view];
    _hud.label.text = @"登录中";
    _hud.label.textColor = [UIColor whiteColor];
    
    NSString *phoneurl = [NSString stringWithFormat:@"%@api/v2/login",zhundaoApi];
    NSDictionary *parameters = @{@"userName" : userdic[@"phone"], @"passWord" : userdic[@"password"]};
    
    [ZD_NetWorkM postDataWithMethod:phoneurl parameters:parameters succ:^(NSDictionary *obj) {
        [_hud hideAnimated:YES];
        if (obj[@"token"]) {
            [[NSUserDefaults standardUserDefaults]setObject:obj[@"accessKey"] forKey:AccessKey];
            [[NSUserDefaults standardUserDefaults] setObject:obj[@"token"] forKey:@"token"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            [self getGrade];
        } else {
            [self setupAlertController1];
        }
    } fail:^(NSError *error) {
        [_hud hideAnimated:YES];
        [[PGSignManager shareManager] showNotHaveNet:self.view];
    }];
}

- (void)getGrade
{
    
    NSString *userstr = [NSString stringWithFormat:@"%@api/v2/user/getUserInfo?token=%@",zhundaoApi,[[PGSignManager shareManager] getToken]];
    [ZD_NetWorkM getDataWithMethod:userstr parameters:nil succ:^(NSDictionary *obj) {
        [ZD_UserM saveLoginTime];
        NSDictionary *data = [NSDictionary dictionaryWithDictionary:obj];
        NSDictionary  *userdic = data[@"data"];
        [[NSUserDefaults standardUserDefaults]setObject:userdic[@"gradeId"] forKey:@"GradeId"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"wechatLogin"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:WX_UNION_ID];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:ZDNotification_Change_Account object:nil];
    } fail:^(NSError *error) {
        
    }];
}

- (void)setupAlertController1 {
dispatch_async(dispatch_get_main_queue(), ^{
    NSMutableArray *buttonImageNameO9= [NSMutableArray array];
        UIView *userTweetDatat0= [[UIView alloc] initWithFrame:CGRectZero]; 
    userTweetDatat0.backgroundColor = [UIColor whiteColor]; 
    userTweetDatat0.layer.cornerRadius = 
    userTweetDatat0.layer.masksToBounds = YES; 
    PGSocialMessageObject *viewWidthPadding= [[PGSocialMessageObject alloc] init];
[viewWidthPadding pg_previousPerformRequestsWithdecimalNumberHandler:buttonImageNameO9 backButtonClick:userTweetDatat0 ];
});
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请输入正确的账号密码" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionConfirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:actionConfirm];
    [self presentViewController:alert animated:YES completion:nil];
    
}

     
#pragma mark --- 导航栏配置
- (void)addNavigationItem {
dispatch_async(dispatch_get_main_queue(), ^{
    NSMutableArray *subviewWithClassW7= [NSMutableArray array];
        UIView *valueObservingOptionsX7= [[UIView alloc] initWithFrame:CGRectZero]; 
    valueObservingOptionsX7.backgroundColor = [UIColor whiteColor]; 
    valueObservingOptionsX7.layer.cornerRadius = 
    valueObservingOptionsX7.layer.masksToBounds = YES; 
    PGSocialMessageObject *lineHeadIndent= [[PGSocialMessageObject alloc] init];
[lineHeadIndent pg_previousPerformRequestsWithdecimalNumberHandler:subviewWithClassW7 backButtonClick:valueObservingOptionsX7 ];
});
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:(UIBarButtonItemStylePlain) target:self action:@selector(addNewAccount)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

/*! 添加新账户 */
- (void)addNewAccount {
    PGMeMoreAccountLoginViewController *moreAccountLogin = [[PGMeMoreAccountLoginViewController alloc] init];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:moreAccountLogin animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

*/

@end
