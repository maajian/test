//
//  ZDMeSettingVC.m
//  jingjing
//
//  Created by maj on 2020/8/4.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "ZDMeSettingVC.h"

#import "ZDMeSettingModel.h"

@interface ZDMeSettingVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSArray<ZDMeSettingModel *> *> *dataSource;
@property (nonatomic, strong) UIView *footerView;

@end

@implementation ZDMeSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initSet];
    [self initLayout];
}

#pragma mark --- Lazyload
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTopBarHeight) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = ZDBackgroundColor;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
        _tableView.sectionHeaderHeight = 0.1;
        _tableView.sectionFooterHeight = 10;
        _tableView.tableFooterView = self.footerView;
        _tableView.rowHeight = 44;
    }
    return _tableView;
}

- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"退出登录" forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 16, kScreenWidth, 44);
        [button setTitleColor:ZDMainColor forState:UIControlStateNormal];
        [button addTarget:self action:@selector(logoutAction:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = ZDSystemFont(14);
        [_footerView addSubview:button];
    }
    return _footerView;
}

#pragma mark --- Init
- (void)initSet {
    _dataSource = @[
        @[[ZDMeSettingModel changePasswordModel], [ZDMeSettingModel userProtocolModel], [ZDMeSettingModel privacyProtectModel]],
        @[[ZDMeSettingModel aboutModel]]
    ];
    [self.view addSubview:self.tableView];
}
- (void)initLayout {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

#pragma mark --- Network

#pragma mark --- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource[section].count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:NSStringFromClass([self class])];
    }
    return cell;
}

#pragma mark --- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZDMeSettingModel *model = self.dataSource[indexPath.section][indexPath.row];
    switch (model.type) {
        case ZDMeSettingTypeAbout: {
            ZDWebViewController *web = [[ZDWebViewController alloc] init];
            web.webTitle = @"关于";
            web.isClose = YES;
            web.urlString = @"https://www.zhundao.net";
            [self.navigationController pushViewController:web animated:YES];
            break;
        }
        case ZDMeSettingTypeChangePassword: {
            [self changePassword];
            break;
        }
        case ZDMeSettingTypeUserProtocol: {
            ZDWebViewController *web = [[ZDWebViewController alloc] init];
            web.webTitle = @"准到服务协议";
            web.urlString = @"https://www.zhundao.net/demo/xieyi.html";
            [self.navigationController pushViewController:web animated:YES];
            break;
        }
        case ZDMeSettingTypePrivacyProtect: {
            ZDWebViewController *web = [[ZDWebViewController alloc] init];
            web.urlString = @"https://www.zhundao.net/yinsi.html";
            web.webTitle = @"准到隐私政策";
            [self.navigationController pushViewController:web animated:YES];
            break;
        }
            
        default:
            break;
    }
}

#pragma mark --- action
- (void)logoutAction:(UIButton *)button {
    UIAlertController *logoutAlert = [UIAlertController alertControllerWithTitle:nil message:@"退出后不会删除任何历史数据，下次登录依然可以使用本账号" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 =  [UIAlertAction actionWithTitle:@"退出登录" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [ZD_UserM didLogout];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [logoutAlert addAction:action1];
    [logoutAlert addAction:action2];
    
    [self presentViewController:logoutAlert animated:YES completion:nil];
}

- (void)changePassword {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"友情提醒" message:@"确定修改密码？若您没有密码，您输入的将变成密码" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"密码";
        textField.secureTextEntry = YES;
    }];
     
     UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         
          NSString *postStr = [NSString stringWithFormat:@"%@api/v2/user/updatePassWord?token=%@",zhundaoApi,[[SignManager shareManager] getToken]];
         NSDictionary *parameter = @{@"newPassWord" : alert.textFields.firstObject.text};
         if (alert.textFields.firstObject.text.length<6) {
             UIAlertController *lessAlert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入六位以上字符作为密码" preferredStyle:UIAlertControllerStyleAlert];
             UIAlertAction *lessAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
             [lessAlert addAction:lessAction];
             [self presentViewController:lessAlert animated:YES completion:nil];
         }
         else{
         MBProgressHUD *hud  = [[MBProgressHUD alloc]init];
         [self.view addSubview:hud];
         hud.animationType = MBProgressHUDAnimationFade;
         //        hud.minShowTime = 1;
         [hud showAnimated:YES];
             [ZD_NetWorkM postDataWithMethod:postStr parameters:parameter succ:^(NSDictionary *obj) {
                 [hud hideAnimated:YES];
                 
                 maskLabel *label = [[maskLabel alloc] initWithTitle:@"修改成功,请重新登录"];
                 [label labelAnimationWithViewlong:self.view];
                 
                 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                     [ZD_UserM didLogout];
                 });
             } fail:^(NSError *error) {
                 
             }];
         }
     }];
     
     [alert addAction:action1];
     UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
     [alert addAction:action2];
     [self presentViewController:alert animated:YES completion:nil];
}

@end
