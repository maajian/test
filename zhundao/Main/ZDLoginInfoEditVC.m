//
//  ZDLoginInfoEditVC.m
//  zhundao
//
//  Created by 罗程勇 on 2018/6/15.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import "ZDLoginInfoEditVC.h"

#import "ZDBaseTabbarVC.h"

#import "ZDLogInfoEditView.h"

#import "ZDLoginInfoEditViewModel.h"

@interface ZDLoginInfoEditVC ()<InfoEditViewDelegate>
 // 填写信息
@property (nonatomic, strong) ZDLogInfoEditView *infoView;
 // 逻辑管理器
@property (nonatomic, strong) ZDLoginInfoEditViewModel *viewModel;

@end

@implementation ZDLoginInfoEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    
    _viewModel = [[ZDLoginInfoEditViewModel alloc] init];
    
    [self.view addSubview:self.infoView];
}

#pragma mark --- 视图生命周期
 // 视图将要出现
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

     [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
}

 // 视图将要消失 
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
}

#pragma mark --- 界面
- (ZDLogInfoEditView *)infoView {
    if (!_infoView) {
        _infoView = [[ZDLogInfoEditView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) phoneStr:_phoneStr];
        _infoView.infoEditViewDelegate = self;
    }
    return _infoView;
}

#pragma mark --- InfoEditViewDelegate
 // 返回
- (void)backPop {
    [self.navigationController popViewControllerAnimated:YES];
}

 // 注册并登陆 
- (void)finishEditWithName:(NSString *)name passWord:(NSString *)passWord {
     MBProgressHUD *hud = [ZDMyHud initWithAnimationType:MBProgressHUDAnimationFade showAnimated:YES UIView:self.view];
    [_viewModel loginWirhCode:_code phoneStr:_phoneStr name:name passWord:passWord successBlock:^{
        [hud hideAnimated:YES afterDelay:0.5];
        [self getGrade];
        [ZD_UserM saveLoginTime];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:nil];
            ZDBaseTabbarVC *tabbar = [[ZDBaseTabbarVC alloc] init];
            [UIApplication sharedApplication].delegate.window.rootViewController= tabbar;
        });
    } failBlock:^(NSString *error) {
        [hud hideAnimated:YES];
        [self showAlert:error];
    }];
}

- (void)getGrade {
    NSString *userstr = [NSString stringWithFormat:@"%@api/v2/user/getUserInfo?token=%@",zhundaoApi,[[ZDSignManager shareManager] getToken]];
    [ZD_NetWorkM getDataWithMethod:userstr parameters:nil succ:^(NSDictionary *obj) {
        [ZDUserManager.shareManager initWithDic:[obj[@"data"] deleteNullObj]];
        NSDictionary *data = [NSDictionary dictionaryWithDictionary:obj];
        NSDictionary  *userdic = data[@"data"];
        [[NSUserDefaults standardUserDefaults]setObject:userdic[@"gradeId"] forKey:@"GradeId"];
    } fail:^(NSError *error) {
        [self showAlert:error.description];
    }];
}

#pragma mark --- action
// 弹窗
- (void)showAlert:(NSString *)alert {
    ZDMaskLabel *label = [[ZDMaskLabel alloc] initWithTitle:alert];
    [label labelAnimationWithViewlong:self.view];
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
