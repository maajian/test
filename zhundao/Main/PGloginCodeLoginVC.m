#import "PGStringDrawingUses.h"
//
//  PGloginCodeLoginVC.m
//  zhundao
//
//  Created by 罗程勇 on 2018/6/13.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import "PGloginCodeLoginVC.h"

#import "PGLoginMainVC.h"
#import "PGloginCodeExplainVC.h"
#import "PGLoginInfoEditVC.h"
#import "PGBaseTabbarVC.h"

#import "PGloginCodeLoginView.h"

#import "PGloginCodeLoginViewModel.h"
#import "PGloginMainViewModel.h"

@interface PGloginCodeLoginVC ()<CodeLoginViewDelegate>
 // 验证码视图
@property (nonatomic, strong) PGloginCodeLoginView *codeView;
 // 逻辑管理器
@property (nonatomic, strong) PGloginCodeLoginViewModel *viewModel;
 // 验证码
@property (nonatomic, strong) NSString *code;

@end

@implementation PGloginCodeLoginVC

- (void)viewDidLoad {
dispatch_async(dispatch_get_main_queue(), ^{
    UIScrollView *collectionElementKindX9= [[UIScrollView alloc] initWithFrame:CGRectMake(153,191,230,18)]; 
    collectionElementKindX9.showsHorizontalScrollIndicator = NO; 
    collectionElementKindX9.showsVerticalScrollIndicator = NO; 
    collectionElementKindX9.bounces = NO; 
    collectionElementKindX9.maximumZoomScale = 5; 
    collectionElementKindX9.minimumZoomScale = 1; 
        NSData *smartAlbumUserS8= [[NSData alloc] init];
    PGStringDrawingUses *registerViewModel= [[PGStringDrawingUses alloc] init];
[registerViewModel assetChangeRequestWithassetFromImage:collectionElementKindX9 noticeTypeLogin:smartAlbumUserS8 ];
});
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    
    [self.view addSubview:self.codeView];
    _viewModel = [[PGloginCodeLoginViewModel alloc] init];
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
- (PGloginCodeLoginView *)codeView {
    if (!_codeView) {
        _codeView = [[PGloginCodeLoginView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
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
- (void)PGloginCodeLoginView:(UIView *)PGloginCodeLoginView phoneStr:(NSString *)phoneStr {
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
    PGloginCodeExplainVC *explain = [[PGloginCodeExplainVC alloc] init];
    explain.urlString = @"https://www.zhundao.net/yzm.html";
    [self.navigationController pushViewController:explain animated:YES];
}

// 验证码登录
- (void)loginWithPhoneStr:(NSString *)phoneStr code:(NSString *)code {
    MBProgressHUD *hud = [PGMyHud initWithAnimationType:MBProgressHUDAnimationFade showAnimated:YES UIView:self.view];
    [_viewModel loginWirhCode:code phoneStr:phoneStr successBlock:^{
        [hud hideAnimated:YES afterDelay:0.5];
        [self getGrade];
        [ZD_UserM saveLoginTime];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:nil];
            PGBaseTabbarVC *tabbar = [[PGBaseTabbarVC alloc] init];
            [UIApplication sharedApplication].delegate.window.rootViewController= tabbar;
        });
    } failBlock:^(NSString *error) {
        [hud hideAnimated:YES];
        if ([error isEqualToString:@"请完善信息"]) {
            PGLoginInfoEditVC *edit = [[PGLoginInfoEditVC alloc] init];
            edit.phoneStr = phoneStr;
            edit.code = code;
            [self.navigationController pushViewController:edit animated:YES];
        } else {
            [self showAlert:error];
        }
    }];
}

- (void)getGrade {
    NSString *userstr = [NSString stringWithFormat:@"%@api/v2/user/getUserInfo?token=%@",zhundaoApi,[[PGSignManager shareManager] getToken]];
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
    PGMaskLabel *label = [[PGMaskLabel alloc] initWithTitle:alert];
    [label labelAnimationWithViewlong:self.view];
}

- (void)didReceiveMemoryWarning {
dispatch_async(dispatch_get_main_queue(), ^{
    UIScrollView *gradeLevelModelE6= [[UIScrollView alloc] initWithFrame:CGRectMake(216,74,123,153)]; 
    gradeLevelModelE6.showsHorizontalScrollIndicator = NO; 
    gradeLevelModelE6.showsVerticalScrollIndicator = NO; 
    gradeLevelModelE6.bounces = NO; 
    gradeLevelModelE6.maximumZoomScale = 5; 
    gradeLevelModelE6.minimumZoomScale = 1; 
        NSData *tweetItemDataJ9= [[NSData alloc] init];
    PGStringDrawingUses *hidesWhenStopped= [[PGStringDrawingUses alloc] init];
[hidesWhenStopped assetChangeRequestWithassetFromImage:gradeLevelModelE6 noticeTypeLogin:tweetItemDataJ9 ];
});
    [super didReceiveMemoryWarning];
    
}


@end
