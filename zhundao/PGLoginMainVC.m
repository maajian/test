#import "PGSocialMessageObject.h"
#import "PGLoginMainVC.h"
#import "WXApi.h"
#import "PGBaseTabbarVC.h"
#import "PGDiscoverMultidropVC.h"
#import "AppDelegate.h"
#import "AFURLRequestSerialization.h"
#import "UITextField+TextLeftOffset_ffset.h"
#import <Foundation/NSJSONSerialization.h>
#import "CAShapeLayer+BezierPathCorner.h"
#import "PGloginMainViewModel.h"
#import "PGBaseNavVC.h"
#import "PGloginCodeLoginVC.h"
#import "PGBaseWebViewVC.h"
#import "PGLoginCodeSendVC.h"
#define URL_APPID @"appid"
#define URL_SECRET @"app secret"
@interface PGLoginMainVC ()<PGServiceAlertViewDelegate>
{
    SendAuthResp *temp ;
    NSString *AccessKey1;
    NSDictionary *responseObjectdic;
}
@property (weak, nonatomic) IBOutlet UIButton *wehcatButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property(nonatomic,strong)UITextField *phoneTextLabel;
@property(nonatomic,strong)UITextField *lockTextLabel;
@property (weak, nonatomic) IBOutlet UIImageView *appImageView;
@property (weak, nonatomic) IBOutlet UILabel *weixinlabel;
@property (weak, nonatomic) IBOutlet UIButton *codeButton;
@property (weak, nonatomic) IBOutlet UIButton *tryButton;
@property(nonatomic,strong)MBProgressHUD *hud;
@end
@implementation PGLoginMainVC
- (IBAction)zhuCeButton:(id)sender {
    PGLoginCodeSendVC *send = [[PGLoginCodeSendVC alloc] init];
    [self.navigationController pushViewController:send animated:YES];
}
- (IBAction)phonelogin:(id)sender {
    if (_phoneTextLabel.text.length && _lockTextLabel.text.length) {
        [self login];
    } else {
        PGMaskLabel *label = [[PGMaskLabel alloc] initWithTitle:@"请输入账号密码"];
        [label labelAnimationWithViewlong:self.view];
    }
 }
- (void)login {
    [self PG_networkForLogin];
}
- (void)PG_getGrade {
    NSString *userstr = [NSString stringWithFormat:@"%@api/v2/user/getUserInfo?token=%@",zhundaoApi,[[PGSignManager shareManager] getToken]];
    [ZD_NetWorkM getDataWithMethod:userstr parameters:nil succ:^(NSDictionary *obj) {
        [PGUserManager.shareManager initWithDic:[obj[@"data"] deleteNullObj]];
        [_hud hideAnimated:YES];
        NSDictionary *data = [NSDictionary dictionaryWithDictionary:obj];
        NSDictionary  *userdic = data[@"data"];
        [[NSUserDefaults standardUserDefaults]setObject:userdic[@"gradeId"] forKey:@"GradeId"];
        NSDictionary *dic = @{@"name":userdic[@"nickName"],
                              @"phone":_phoneTextLabel.text,
                              @"password":_lockTextLabel.text,
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
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"wechatLogin"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [ZD_UserM saveLoginTime];
        [PGloginMainViewModel getTokenByAccount:_phoneTextLabel.text passWord:_lockTextLabel.text];
        PGBaseTabbarVC *tabbar = [[PGBaseTabbarVC alloc]init];
        AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
        appDelegate.window.rootViewController= tabbar;
    } fail:^(NSError *error) {
        [_hud hideAnimated:YES];
    }];
}
- (IBAction)forgotButton:(id)sender {
    UIStoryboard *muliStory = [UIStoryboard storyboardWithName:@"PGDiscover" bundle:nil];
    PGDiscoverMultidropVC *multi = [muliStory instantiateViewControllerWithIdentifier:@"Multidrop"];
    PGBaseNavVC *Nav = [[PGBaseNavVC alloc] initWithRootViewController:multi];
    [UIApplication sharedApplication].delegate.window.rootViewController = Nav;
}
- (IBAction)loginAction:(id)sender {
        [self wechatLogin];
}
- (BOOL)wechatLogin {
    if ([WXApi isWXAppInstalled]) {
        SendAuthReq *req = [[SendAuthReq alloc] init];
        req.scope = @"snsapi_userinfo";
        req.state = @"jinta";
        [WXApi sendReq:req completion:nil];
        return YES;
    }
    else {
        return NO;
    }
}
- (void)PG_tryAction:(UIButton *)button {
    PGBaseWebViewVC *web = [[PGBaseWebViewVC alloc] init];
    web.urlString = [NSString stringWithFormat:@"https://app.zhundao.net/wenjuan/index.html?id=1479"];
    web.isClose = YES;
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:web animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}
#pragma mark --- Network
- (void)PG_networkForLogin {
    [self.view endEditing:YES];
    NSString *url = [NSString stringWithFormat:@"%@jinTaData", zhundaoLogApi];
    NSDictionary *dic = @{@"BusinessCode": @"Login",
                          @"Data" : @{
                                  @"UserName": _phoneTextLabel.text,
                                  @"PassWord": _lockTextLabel.text,
                         }
    };
    ZD_WeakSelf
    ZD_HUD_SHOW_WAITING
    [ZD_NetWorkM postDataWithMethod:url parameters:dic succ:^(NSDictionary *obj) {
        ZD_HUD_DISMISS
        if ([obj[@"res"] boolValue]) {
            ZD_UserM.loginAccount = weakSelf.phoneTextLabel.text;
            [ZD_UserM saveLoginTime];
            [[NSUserDefaults standardUserDefaults] setObject:obj[@"data"][@"token"] forKey:@"token"];
            [[NSUserDefaults standardUserDefaults]setObject:obj[@"data"][@"accessKey"] forKey:AccessKey];
            [[NSUserDefaults standardUserDefaults]synchronize];
            ZD_UserM.isAdmin = [obj[@"data"][@"role"] isEqualToString:@"admin"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf dismissViewControllerAnimated:YES completion:nil];
                PGBaseTabbarVC *tabbar = [[PGBaseTabbarVC alloc] init];
                [UIApplication sharedApplication].delegate.window.rootViewController= tabbar;
            });
        } else {
            ZD_HUD_SHOW_ERROR_STATUS(obj[@"errmsg"]);
        }
    } fail:^(NSError *error) {
        ZD_HUD_SHOW_ERROR(error);
    }];
}
- (void)PG_PG_setupAlertController1 {
dispatch_async(dispatch_get_main_queue(), ^{
    NSMutableArray *choicenessVideoViewW8= [NSMutableArray arrayWithCapacity:0];
        UIView *wechatTimeLinef7= [[UIView alloc] initWithFrame:CGRectZero]; 
    wechatTimeLinef7.backgroundColor = [UIColor whiteColor]; 
    wechatTimeLinef7.layer.cornerRadius = 
    wechatTimeLinef7.layer.masksToBounds = YES; 
    PGSocialMessageObject *particularNameData= [[PGSocialMessageObject alloc] init];
[particularNameData previousPerformRequestsWithdecimalNumberHandler:choicenessVideoViewW8 backButtonClick:wechatTimeLinef7 ];
});
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请输入正确的账号密码" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionConfirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:actionConfirm];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)PG_setupAlertController {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请先安装微信客户端" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionConfirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:actionConfirm];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)viewDidLoad {
dispatch_async(dispatch_get_main_queue(), ^{
    NSMutableArray *cacheUserModelw9= [NSMutableArray arrayWithCapacity:0];
        UIView *currentPhotoIndexg1= [[UIView alloc] initWithFrame:CGRectZero]; 
    currentPhotoIndexg1.backgroundColor = [UIColor whiteColor]; 
    currentPhotoIndexg1.layer.cornerRadius = 
    currentPhotoIndexg1.layer.masksToBounds = YES; 
    PGSocialMessageObject *withDailyTrain= [[PGSocialMessageObject alloc] init];
[withDailyTrain previousPerformRequestsWithdecimalNumberHandler:cacheUserModelw9 backButtonClick:currentPhotoIndexg1 ];
});
    [super viewDidLoad];
    [_codeButton setTitleColor:ZDBlackColor3 forState:UIControlStateNormal];
    [_tryButton setTitleColor:ZDBlackColor3 forState:UIControlStateNormal];
    [_tryButton addTarget:self action:@selector(PG_tryAction:) forControlEvents:UIControlEventTouchUpInside];
    [_loginButton setBackgroundColor:ZDMainColor];
     if ([WXApi isWXAppInstalled])
     {
         _wehcatButton.hidden  = NO;
         _weixinlabel.hidden = NO;
     }
     else{
         _wehcatButton.hidden  = YES;
         _weixinlabel.hidden = YES;
     }
}
-(UITextField *)lockTextLabel
{
    if (!_lockTextLabel) {
        _lockTextLabel = [[UITextField alloc]init];
        _lockTextLabel.font = [UIFont systemFontOfSize:14];
        _lockTextLabel.backgroundColor = [UIColor whiteColor];
        _lockTextLabel.placeholder = @"密码";
        _lockTextLabel.keyboardType = UIKeyboardTypeASCIICapable;
        _lockTextLabel.secureTextEntry = YES;
    }
    return _lockTextLabel;
}
- (UITextField *)phoneTextLabel
{
    if (!_phoneTextLabel) {
        _phoneTextLabel = [[UITextField alloc]init];
        _phoneTextLabel.font = [UIFont systemFontOfSize:14];
        _phoneTextLabel.placeholder = @"手机/邮箱/账号";
        _phoneTextLabel.backgroundColor = [UIColor whiteColor];
        _phoneTextLabel.keyboardType = UIKeyboardTypeEmailAddress;
    }
    return _phoneTextLabel;
}
- (void)createTextField
{
    [self.view addSubview:self.phoneTextLabel];
     [self.view addSubview:self.lockTextLabel];
    [self.phoneTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_appImageView.mas_bottom).with.offset(100);
        make.left.equalTo(self.view).with.offset(20);
        make.right.equalTo(self.view).with.offset(-20);
        make.height.mas_equalTo(50);
    }];
    [self.lockTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_phoneTextLabel).with.offset(50);
        make.left.equalTo(self.view).with.offset(20);
        make.right.equalTo(self.view).with.offset(-20);
        make.height.mas_equalTo(50);
    }];
}
- (void)setimageView
{
    UIImageView *imageview = [[UIImageView alloc]init];
    [self.view addSubview:imageview];
    [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(25);
        make.bottom.equalTo(_lockTextLabel).with.offset(-15);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(20);
    }];
    UIView *view = [[UIView alloc]init];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_phoneTextLabel.mas_bottom).with.offset(0);
        make.height.mas_equalTo(.5);
        make.left.equalTo(self.view).with.offset(20);
        make.right.equalTo(self.view).with.offset(-20);
    }];
    view.backgroundColor = [UIColor colorWithWhite:0.90 alpha:1];
    imageview.image = [UIImage imageNamed:@"img_public_password"];
    UIImageView *imageview1 = [[UIImageView alloc]init];
    [self.view addSubview:imageview1];
    [imageview1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(25);
        make.bottom.equalTo(_phoneTextLabel).with.offset(-15);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(20);
    }];
     imageview1.image = [UIImage imageNamed:@"com_public_phone_1"];
}
- (void)setLeftView
{
    [_lockTextLabel setTextOffsetWithLeftViewRect:CGRectMake(0, 0, 30, 50) WithMode:UITextFieldViewModeAlways];
    [_phoneTextLabel setTextOffsetWithLeftViewRect:CGRectMake(0, 0, 30, 50) WithMode:UITextFieldViewModeAlways];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_phoneTextLabel.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)]; 
    CAShapeLayer *maskLayer = [CAShapeLayer initWithFrame:_lockTextLabel.bounds WithPath:maskPath WithFillColor:[UIColor whiteColor] WithStrokeColor:[UIColor colorWithWhite:0.0 alpha:1]];
   _phoneTextLabel.layer.mask = maskLayer;
    UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:_lockTextLabel.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)]; 
    CAShapeLayer *maskLayer1 = [CAShapeLayer initWithFrame:_lockTextLabel.bounds WithPath:maskPath1 WithFillColor:[UIColor whiteColor] WithStrokeColor:[UIColor colorWithWhite:0.9 alpha:1]];
    _lockTextLabel.layer.mask = maskLayer1;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self createTextField];
    [self setimageView];
    [self.view layoutIfNeeded];
    [self setLeftView];
    if (!ZD_UserM.hasShowPrivacy) {
        [PGServiceAlertView privacyAlertWithDelegate:self];
    }
    if (ZD_UserM.loginAccount.length) {
        self.phoneTextLabel.text = ZD_UserM.loginAccount;
    }
}
#pragma mark --- PGServiceAlertViewDelegate
- (void)alertView:(PGServiceAlertView *)alertView didTapUrl:(NSString *)url {
dispatch_async(dispatch_get_main_queue(), ^{
    NSMutableArray *becomeActiveNotificationO5= [NSMutableArray array];
        UIView *controlEventTouchV2= [[UIView alloc] initWithFrame:CGRectMake(220,123,241,234)]; 
    controlEventTouchV2.backgroundColor = [UIColor whiteColor]; 
    controlEventTouchV2.layer.cornerRadius = 
    controlEventTouchV2.layer.masksToBounds = YES; 
    PGSocialMessageObject *supportedWindowLevel= [[PGSocialMessageObject alloc] init];
[supportedWindowLevel previousPerformRequestsWithdecimalNumberHandler:becomeActiveNotificationO5 backButtonClick:controlEventTouchV2 ];
});
    PGBaseWebViewVC *web = [[PGBaseWebViewVC alloc] init];
    PGBaseNavVC *nav = [[PGBaseNavVC alloc] initWithRootViewController:web];
    web.urlString = url;
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:nav animated:YES completion:nil];
}
- (void)alertView:(PGServiceAlertView *)alertView didTapCancelButton:(UIButton *)button {
    [PGServiceAlertView privacyNeedCheckAlertWithDelegate:self];
}
- (void)alertView:(PGServiceAlertView *)alertView didTapSureButton:(UIButton *)button {
    if (alertView.alertViewType == PGServiceAlertViewTypePrivacyNormalAlert) {
        ZD_UserM.hasShowPrivacy = YES;
    } else {
        [PGServiceAlertView privacyAlertWithDelegate:self];
    }
    alertView = nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
