//
//  ZDCodeLoginVC.m
//  zhundao
//
//  Created by 罗程勇 on 2018/6/13.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import "ZDCodeLoginVC.h"

#import "ZDLoginVC.h"
#import "ZDCodeExplainVC.h"
#import "ZDInfoEditVC.h"
#import "ZDMainViewController.h"

#import "ZDCodeLoginView.h"

#import "ZDCodeLoginViewModel.h"
#import "loginViewModel.h"

@interface ZDCodeLoginVC ()<ZDCodeLoginViewDelegate>
 // 验证码视图
@property (nonatomic, strong) ZDCodeLoginView *codeView;
 // 逻辑管理器
@property (nonatomic, strong) ZDCodeLoginViewModel *viewModel;
 // 验证码
@property (nonatomic, strong) NSString *code;

@end

@implementation ZDCodeLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    
    [self.view addSubview:self.codeView];
    _viewModel = [[ZDCodeLoginViewModel alloc] init];
}

#pragma mark --- 视图生命周期
// 视图将要出现
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

// 视图将要消失
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark --- 验证码视图
 // 验证码
- (ZDCodeLoginView *)codeView {
    if (!_codeView) {
        _codeView = [[ZDCodeLoginView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _codeView.codeLoginViewDelegate = self;
    }
    return _codeView;
}

#pragma mark --- CodeLoginViewDelegate
// 返回
- (void)backLogin {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 发送验证码
- (void)codeLoginView:(UIView *)codeLoginView phoneStr:(NSString *)phoneStr {
    __weak typeof(self) weakSelf = self;
    [_viewModel sendCode:phoneStr successBlock:^{
         // 显示弹窗
        [weakSelf showAlert:weakSelf.viewModel.sendCodeJson[@"errmsg"]];
        weakSelf.code = weakSelf.viewModel.sendCodeJson[@"data"];
        
    } failBlock:^(NSString *error) {
        [weakSelf showAlert:error];
    }];
}

// 无法获取验证码
- (void)goCodeWeb {
    ZDCodeExplainVC *explain = [[ZDCodeExplainVC alloc] init];
    explain.urlString = @"https://www.zhundao.net/yzm.html";
    [self.navigationController pushViewController:explain animated:YES];
}

// 验证码登录
- (void)loginWithPhoneStr:(NSString *)phoneStr code:(NSString *)code {
    MBProgressHUD *hud = [ZDHud initWithAnimationType:MBProgressHUDAnimationFade showAnimated:YES UIView:self.view];
    [_viewModel loginWirhCode:code phoneStr:phoneStr successBlock:^{
        [hud hideAnimated:YES afterDelay:0.5];
        [self getGrade];
        [ZD_UserM saveLoginTime];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:nil];
            ZDMainViewController *tabbar = [[ZDMainViewController alloc] init];
            [UIApplication sharedApplication].delegate.window.rootViewController= tabbar;
        });
    } failBlock:^(NSString *error) {
        [hud hideAnimated:YES];
        if ([error isEqualToString:@"请完善信息"]) {
            ZDInfoEditVC *edit = [[ZDInfoEditVC alloc] init];
            edit.phoneStr = phoneStr;
            edit.code = code;
            [self.navigationController pushViewController:edit animated:YES];
        } else {
            [self showAlert:error];
        }
    }];
}

- (void)getGrade {
    NSString *userstr = [NSString stringWithFormat:@"%@api/v2/user/getUserInfo?token=%@",zhundaoApi,[[ZDDataManager shareManager] getToken]];
    [ZD_NetWorkM getDataWithMethod:userstr parameters:nil succ:^(NSDictionary *obj) {
        NSDictionary *data = [NSDictionary dictionaryWithDictionary:obj];
        NSDictionary  *userdic = data[@"data"];
        [[NSUserDefaults standardUserDefaults]setObject:userdic[@"gradeId"] forKey:@"GradeId"];
    } fail:^(NSError *error) {
        
    }];
}

#pragma mark --- action
 // 弹窗
- (void)showAlert:(NSString *)alert {
    maskLabel *label = [[maskLabel alloc] initWithTitle:alert];
    [label labelAnimationWithViewlong:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
