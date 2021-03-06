//
//  MoreAccountLoginViewController.m
//  zhundao
//
//  Created by xhkj on 2018/1/19.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import "MoreAccountLoginViewController.h"

#import "loginViewModel.h"
@interface MoreAccountLoginViewController ()

/*! 账户 */
@property (nonatomic, strong) UITextField *accountTF;
/*! 密码输入框 */
@property (nonatomic, strong) UITextField *passwordTF;

@end

@implementation MoreAccountLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"登录";
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)setupUI {
    
    UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(20, 15, kScreenWidth - 40, 0.5)];
    topLine.backgroundColor = kColorA(180, 180, 180, 1);
    [self.view addSubview:topLine];
    
    UILabel *accountLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(topLine.frame), 70, 50)];
    accountLabel.textColor = kColorA(119, 119, 119, 1);
    accountLabel.font = [UIFont systemFontOfSize:14];
    accountLabel.textAlignment = NSTextAlignmentLeft;
    accountLabel.text = @"账号";
    [self.view addSubview:accountLabel];
    
    _accountTF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(accountLabel.frame) + 5, CGRectGetMaxY(topLine.frame), kScreenWidth -CGRectGetMaxX(accountLabel.frame) - 50 , 50)];
    _accountTF.keyboardType = UIKeyboardTypeNumberPad;
    _accountTF.font = [UIFont systemFontOfSize:14];
    _accountTF.placeholder = @"请输入登录账号";
    _accountTF.textColor = kColorA(51, 51, 51, 1);
    [self.view addSubview:_accountTF];
    
    UIView *centerLine = [[UIView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(accountLabel.frame), kScreenWidth - 40, 0.5)];
    centerLine.backgroundColor = kColorA(180, 180, 180, 1);
    [self.view addSubview:centerLine];
    
    UILabel *passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(centerLine.frame), 70, 50)];
    passwordLabel.textColor = kColorA(119, 119, 119, 1);;
    passwordLabel.font = [UIFont systemFontOfSize:14];
    passwordLabel.textAlignment = NSTextAlignmentLeft;
    passwordLabel.text = @"登陆密码";
    [self.view addSubview:passwordLabel];
    
    _passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(passwordLabel.frame) + 5, CGRectGetMaxY(centerLine.frame), kScreenWidth -CGRectGetMaxX(passwordLabel.frame) - 50 , 50)];
    _passwordTF.keyboardType = UIKeyboardTypeDefault;
    _passwordTF.font = [UIFont systemFontOfSize:14];
    _passwordTF.placeholder = @"请输入登录密码";
    _passwordTF.secureTextEntry = YES;
    _passwordTF.textColor = kColorA(51, 51, 51, 1);
    [self.view addSubview:_passwordTF];
    
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(passwordLabel.frame), kScreenWidth - 40, 0.5)];
    bottomLine.backgroundColor = kColorA(180, 180, 180, 1);
    [self.view addSubview:bottomLine];
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton  setBackgroundColor:ZDGreenColor];
    loginButton.layer.cornerRadius = 5;
    loginButton.layer.masksToBounds = YES;
    [loginButton setTitle:@"登录" forState:(UIControlStateNormal)];
    [loginButton setTitleColor: [UIColor colorWithWhite:0.95 alpha:1] forState:UIControlStateNormal];
    loginButton.frame = CGRectMake(20, CGRectGetMaxY(bottomLine.frame) + 20, kScreenWidth - 40, 50);
    [loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
}

#pragma mark --- 点击登陆

- (void)login {
    MBProgressHUD *_hud = [MyHud initWithAnimationType:MBProgressHUDAnimationFade showAnimated:YES UIView:self.view];
    _hud.label.text = @"登录中";
    _hud.label.textColor = [UIColor whiteColor];

    NSString *phoneurl = [NSString stringWithFormat:@"%@api/v2/login",zhundaoApi];
    NSDictionary *parameters = @{@"userName" : _accountTF .text, @"passWord" : _passwordTF.text};
    
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
        [[SignManager shareManager] showNotHaveNet:self.view];
    }];
}

- (void)getGrade
{
    NSString *userstr = [NSString stringWithFormat:@"%@api/v2/user/getUserInfo?token=%@",zhundaoApi,[[SignManager shareManager] getToken]];
    [ZD_NetWorkM getDataWithMethod:userstr parameters:nil succ:^(NSDictionary *obj) {
        NSDictionary *data = [NSDictionary dictionaryWithDictionary:obj];
        NSDictionary  *userdic = data[@"data"];
        [[NSUserDefaults standardUserDefaults]setObject:userdic[@"gradeId"] forKey:@"GradeId"];
        NSDictionary *dic = @{@"name":userdic[@"nickName"],
                              @"phone":_accountTF.text,
                              @"password":_passwordTF.text,
                              @"headImgurl":userdic[@"headImgUrl"]
                              };
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"userArray"]) {
            NSMutableArray *userArray = [[[NSUserDefaults standardUserDefaults] objectForKey:@"userArray"] mutableCopy];
            BOOL isHavePhone = NO;
            for (NSDictionary *datadic in userArray) {
                if ([datadic[@"phone"] isEqualToString:dic[@"phone"]]) {
                    isHavePhone = YES;
                }
            }
            if (!isHavePhone) {
                [userArray addObject:dic];
                [[NSUserDefaults standardUserDefaults] setObject:userArray forKey:@"userArray"];
            }
            
        } else {
            NSMutableArray *userArray = [NSMutableArray arrayWithObject:dic];
            [[NSUserDefaults standardUserDefaults] setObject:userArray forKey:@"userArray"];
        }
        [ZD_UserM saveLoginTime];
        [loginViewModel getTokenByAccount:_accountTF .text passWord:_passwordTF.text];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"wechatLogin"];
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:WX_UNION_ID];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:ZDNotification_Change_Account object:nil];
        [self.navigationController popToRootViewControllerAnimated:YES];
    } fail:^(NSError *error) {
        
    }];
}

- (void)setupAlertController1 {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请输入正确的账号密码" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionConfirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:actionConfirm];
    [self presentViewController:alert animated:YES completion:nil];
    
}

/*! 退出登录清空数据 */
- (void)didLogout
{
    /*! 清除本地数据 */
    NSDictionary *userArray = [[NSUserDefaults standardUserDefaults]objectForKey:@"userArray"];
    NSString *appDomain = [[NSBundle mainBundle]bundleIdentifier];
    [[NSUserDefaults standardUserDefaults]removePersistentDomainForName:appDomain];
    [[NSUserDefaults standardUserDefaults] setObject:userArray forKey:@"userArray"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if ([[SignManager shareManager].dataBase open])
    {
        NSString *updateSql = [NSString stringWithFormat:@"DROP TABLE signList"];
        [[SignManager shareManager].dataBase executeUpdate:updateSql];
        NSString *updateSql1 = [NSString stringWithFormat:@"DROP TABLE muliSignList"];
        [[SignManager shareManager].dataBase executeUpdate:updateSql1];
        NSString *updateSql12 = [NSString stringWithFormat:@"DROP TABLE contact"];
        [[SignManager shareManager].dataBase executeUpdate:updateSql12];
        [[SignManager shareManager].dataBase close];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
