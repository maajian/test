#import "PGStringDrawingUses.h"
#import "PGloginCodeLoginVC.h"
#import "PGLoginMainVC.h"
#import "PGloginCodeExplainVC.h"
#import "PGLoginInfoEditVC.h"
#import "PGBaseTabbarVC.h"
#import "PGloginCodeLoginView.h"
#import "PGloginCodeLoginViewModel.h"
#import "PGloginMainViewModel.h"
@interface PGloginCodeLoginVC ()<CodeLoginViewDelegate>
@property (nonatomic, strong) PGloginCodeLoginView *codeView;
@property (nonatomic, strong) PGloginCodeLoginViewModel *viewModel;
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
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
#pragma mark --- 验证码视图
- (PGloginCodeLoginView *)codeView {
    if (!_codeView) {
        _codeView = [[PGloginCodeLoginView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _codeView.codeLoginViewDelegate = self;
    }
    return _codeView;
}
#pragma mark --- CodeLoginViewDelegate
- (void)backLogin {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)PGloginCodeLoginView:(UIView *)PGloginCodeLoginView phoneStr:(NSString *)phoneStr {
    __weak typeof(self) weakSelf = self;
    [_viewModel sendCode:phoneStr successBlock:^{
        [weakSelf PG_showAlert:weakSelf.viewModel.sendCodeJson[@"errmsg"]];
        weakSelf.code = weakSelf.viewModel.sendCodeJson[@"data"];
    } failBlock:^(NSString *error) {
        [weakSelf PG_showAlert:error];
    }];
}
- (void)goCodeWeb {
    PGloginCodeExplainVC *explain = [[PGloginCodeExplainVC alloc] init];
    explain.urlString = @"https://www.zhundao.net/yzm.html";
    [self.navigationController pushViewController:explain animated:YES];
}
- (void)loginWithPhoneStr:(NSString *)phoneStr code:(NSString *)code {
    MBProgressHUD *hud = [PGMyHud initWithAnimationType:MBProgressHUDAnimationFade showAnimated:YES UIView:self.view];
    [_viewModel loginWirhCode:code phoneStr:phoneStr successBlock:^{
        [hud hideAnimated:YES afterDelay:0.5];
        [self PG_getGrade];
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
            [self PG_showAlert:error];
        }
    }];
}
- (void)PG_getGrade {
    NSString *userstr = [NSString stringWithFormat:@"%@api/v2/user/getUserInfo?token=%@",zhundaoApi,[[PGSignManager shareManager] getToken]];
    [ZD_NetWorkM getDataWithMethod:userstr parameters:nil succ:^(NSDictionary *obj) {
        NSDictionary *data = [NSDictionary dictionaryWithDictionary:obj];
        NSDictionary  *userdic = data[@"data"];
        [[NSUserDefaults standardUserDefaults]setObject:userdic[@"gradeId"] forKey:@"GradeId"];
    } fail:^(NSError *error) {
    }];
}
#pragma mark --- action
- (void)PG_showAlert:(NSString *)alert {
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
