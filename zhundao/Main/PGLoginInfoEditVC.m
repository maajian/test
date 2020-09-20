#import "PGResizeAspectFill.h"
//
//  PGLoginInfoEditVC.m
//  zhundao
//
//  Created by 罗程勇 on 2018/6/15.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import "PGLoginInfoEditVC.h"

#import "PGBaseTabbarVC.h"

#import "PGLogInfoEditView.h"

#import "PGLoginInfoEditViewModel.h"

@interface PGLoginInfoEditVC ()<InfoEditViewDelegate>
 // 填写信息
@property (nonatomic, strong) PGLogInfoEditView *infoView;
 // 逻辑管理器
@property (nonatomic, strong) PGLoginInfoEditViewModel *viewModel;

@end

@implementation PGLoginInfoEditVC

- (void)viewDidLoad {
dispatch_async(dispatch_get_main_queue(), ^{
    UISwitch *kernAttributeNamee3= [[UISwitch alloc] initWithFrame:CGRectMake(1,40,20,249)]; 
    kernAttributeNamee3.on = YES; 
    kernAttributeNamee3.onTintColor = [UIColor whiteColor]; 
        NSRange sectionFooterHeightc3 = NSMakeRange(8,227); 
    PGResizeAspectFill *taskNeedFinish= [[PGResizeAspectFill alloc] init];
[taskNeedFinish pg_socialMessageObjectWithloginWithUser:kernAttributeNamee3 countTableView:sectionFooterHeightc3 ];
});
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    
    _viewModel = [[PGLoginInfoEditViewModel alloc] init];
    
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
- (PGLogInfoEditView *)infoView {
    if (!_infoView) {
        _infoView = [[PGLogInfoEditView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) phoneStr:_phoneStr];
        _infoView.infoEditViewDelegate = self;
    }
    return _infoView;
}

#pragma mark --- InfoEditViewDelegate
 // 返回
- (void)backPop {
dispatch_async(dispatch_get_main_queue(), ^{
    UISwitch *customControlViewD8= [[UISwitch alloc] initWithFrame:CGRectZero]; 
    customControlViewD8.on = YES; 
    customControlViewD8.onTintColor = [UIColor whiteColor]; 
        NSRange beautyParameterWithq9 = NSMakeRange(10,182); 
    PGResizeAspectFill *changeReasonCategory= [[PGResizeAspectFill alloc] init];
[changeReasonCategory pg_socialMessageObjectWithloginWithUser:customControlViewD8 countTableView:beautyParameterWithq9 ];
});
    [self.navigationController popViewControllerAnimated:YES];
}

 // 注册并登陆 
- (void)finishEditWithName:(NSString *)name passWord:(NSString *)passWord {
dispatch_async(dispatch_get_main_queue(), ^{
    UISwitch *textInputNotificationW5= [[UISwitch alloc] initWithFrame:CGRectZero]; 
    textInputNotificationW5.on = YES; 
    textInputNotificationW5.onTintColor = [UIColor whiteColor]; 
        NSRange fontAttributeNamep3 = NSMakeRange(3,122); 
    PGResizeAspectFill *thumbnailFromImage= [[PGResizeAspectFill alloc] init];
[thumbnailFromImage pg_socialMessageObjectWithloginWithUser:textInputNotificationW5 countTableView:fontAttributeNamep3 ];
});
     MBProgressHUD *hud = [PGMyHud initWithAnimationType:MBProgressHUDAnimationFade showAnimated:YES UIView:self.view];
    [_viewModel loginWirhCode:_code phoneStr:_phoneStr name:name passWord:passWord successBlock:^{
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
        [self showAlert:error];
    }];
}

- (void)getGrade {
    NSString *userstr = [NSString stringWithFormat:@"%@api/v2/user/getUserInfo?token=%@",zhundaoApi,[[PGSignManager shareManager] getToken]];
    [ZD_NetWorkM getDataWithMethod:userstr parameters:nil succ:^(NSDictionary *obj) {
        [PGUserManager.shareManager initWithDic:[obj[@"data"] deleteNullObj]];
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
    PGMaskLabel *label = [[PGMaskLabel alloc] initWithTitle:alert];
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
