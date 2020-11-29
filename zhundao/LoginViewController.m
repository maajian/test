                //
//  LoginViewController.m
//  zhundao
//
//  Created by zhundao on 2016/12/2.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import "LoginViewController.h"
#import "WXApi.h"
#import "MainViewController.h"
#import "MultidropViewController.h"
#import "AppDelegate.h"
//#import "ActivityViewController.h"
//#import "ZDMainActivityVC.h"
#import "AFURLRequestSerialization.h"
#import "UITextField+TextLeftOffset_ffset.h"
#import <Foundation/NSJSONSerialization.h>
#import "CAShapeLayer+BezierPathCorner.h"
#import "loginViewModel.h"
#import "BaseNavigationViewController.h"
#import "CodeLoginViewController.h"
#import "ZDWebViewController.h"

#define URL_APPID @"appid"
#define URL_SECRET @"app secret"
//wxe25de2684f235a04 appid
//3286d02771487220b3135ed3620e552e appsecret
@interface LoginViewController ()<ZDServiceAlertViewDelegate>
{
    SendAuthResp *temp ;
    NSString *AccessKey1;
    NSDictionary *responseObjectdic;
}
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
//@property (copy, nonatomic) void (^requestForUserInfoBlock)();
@property(nonatomic,strong)UITextField *phoneTextLabel;
@property(nonatomic,strong)UITextField *lockTextLabel;
@property (weak, nonatomic) IBOutlet UIImageView *appImageView;
@property (weak, nonatomic) IBOutlet UILabel *weixinlabel;
@property (weak, nonatomic) IBOutlet UIButton *phonelogin;

@property(nonatomic,strong)MBProgressHUD *hud;
@end

@implementation LoginViewController
 // 验证码登录
- (IBAction)zhuCeButton:(id)sender {
    
    CodeLoginViewController *code = [[CodeLoginViewController alloc] init];
    BaseNavigationViewController *nav = [[BaseNavigationViewController alloc] initWithRootViewController:code];
    [self presentViewController:nav animated:YES completion:nil];
    
}

- (IBAction)phonelogin:(id)sender {

    if (_phoneTextLabel.text.length && _lockTextLabel.text.length) {
        _hud = [MyHud initWithAnimationType:MBProgressHUDAnimationFade showAnimated:YES UIView:self.view];
        _hud.label.text = @"登录中";
        _hud.label.textColor = [UIColor whiteColor];
        [self login];
    } else {
        maskLabel *label = [[maskLabel alloc] initWithTitle:@"请输入账号密码"];
        [label labelAnimationWithViewlong:self.view];
    }
 }

- (void)login {
 
    NSString *phoneurl = [NSString stringWithFormat:@"%@api/v2/login?from=ios",@"https://open.zhundao.net/"];
    NSDictionary *parameters = @{@"userName" : _phoneTextLabel.text, @"passWord" : _lockTextLabel.text};
    
    [ZD_NetWorkM postDataWithMethod:phoneurl parameters:parameters succ:^(NSDictionary *obj) {
        if (obj[@"token"]) {
            [[NSUserDefaults standardUserDefaults]setObject:obj[@"accessKey"] forKey:AccessKey];
            [[NSUserDefaults standardUserDefaults] setObject:obj[@"token"] forKey:@"token"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            [self getGrade];
        } else {
            [_hud hideAnimated:YES];
            [self setupAlertController1];
        }
    } fail:^(NSError *error) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [[NSUserDefaults standardUserDefaults]setObject:@"备用线路" forKey:ZDUserDefault_Network_Line];
            [[NSUserDefaults standardUserDefaults]synchronize];
            [self login];
        });
        [_hud hideAnimated:YES];
    }];
}

- (void)getGrade
{
    NSString *userstr = [NSString stringWithFormat:@"%@api/v2/user/getUserInfo?token=%@",zhundaoApi,[[SignManager shareManager] getToken]];
    [ZD_NetWorkM getDataWithMethod:userstr parameters:nil succ:^(NSDictionary *obj) {
        [ZDUserManager.shareManager initWithDic:[obj[@"data"] deleteNullObj]];
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
        MainViewController *tabbar = [[MainViewController alloc]init];
        AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
        appDelegate.window.rootViewController= tabbar;
    } fail:^(NSError *error) {
        [_hud hideAnimated:YES];
    }];
}

 // 多点登录
- (IBAction)forgotButton:(id)sender {
    UIStoryboard *muliStory = [UIStoryboard storyboardWithName:@"Discover" bundle:nil];
    MultidropViewController *multi = [muliStory instantiateViewControllerWithIdentifier:@"Multidrop"];
    BaseNavigationViewController *Nav = [[BaseNavigationViewController alloc] initWithRootViewController:multi];
    [UIApplication sharedApplication].delegate.window.rootViewController = Nav;
}

- (IBAction)loginAction:(id)sender {
        [self wechatLogin];
}

- (BOOL)wechatLogin {
    if ([WXApi isWXAppInstalled]) {
        SendAuthReq *req = [[SendAuthReq alloc] init];
        req.scope = @"snsapi_userinfo";
        req.state = @"GSTDoctorApp";
        [WXApi sendReq:req completion:nil];
        return YES;
    }
    else {
        return NO;
    }
}
- (void)setupAlertController1 {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请输入正确的账号密码" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionConfirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:actionConfirm];
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (void)setupAlertController {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请先安装微信客户端" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionConfirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:actionConfirm];
    [self presentViewController:alert animated:YES completion:nil];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
     if ([WXApi isWXAppInstalled])
     {
         _loginButton.hidden  = NO;
         _weixinlabel.hidden = NO;
     }
     else{
         _loginButton.hidden  = YES;
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
        make.top.equalTo(_appImageView).with.offset(130);
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
    imageview.image = [UIImage imageNamed:@"密码"];
    UIImageView *imageview1 = [[UIImageView alloc]init];
    [self.view addSubview:imageview1];
    [imageview1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(25);
        make.bottom.equalTo(_phoneTextLabel).with.offset(-15);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(20);
    }];
     imageview1.image = [UIImage imageNamed:@"手机"];
}

- (void)setLeftView
{
    [_lockTextLabel setTextOffsetWithLeftViewRect:CGRectMake(0, 0, 30, 50) WithMode:UITextFieldViewModeAlways];
    [_phoneTextLabel setTextOffsetWithLeftViewRect:CGRectMake(0, 0, 30, 50) WithMode:UITextFieldViewModeAlways];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_phoneTextLabel.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)]; // UIRectCornerBottomRight通过这个设置
    CAShapeLayer *maskLayer = [CAShapeLayer initWithFrame:_lockTextLabel.bounds WithPath:maskPath WithFillColor:[UIColor whiteColor] WithStrokeColor:[UIColor colorWithWhite:0.0 alpha:1]];
   _phoneTextLabel.layer.mask = maskLayer;
    UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:_lockTextLabel.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)]; // UIRectCornerBottomRight通过这个设置
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
        [ZDServiceAlertView privacyAlertWithDelegate:self];
    }
}

#pragma mark --- ZDServiceAlertViewDelegate
- (void)alertView:(ZDServiceAlertView *)alertView didTapUrl:(NSString *)url {
    ZDWebViewController *web = [[ZDWebViewController alloc] init];
    BaseNavigationViewController *nav = [[BaseNavigationViewController alloc] initWithRootViewController:web];
    web.urlString = url;
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:nav animated:YES completion:nil];
}
- (void)alertView:(ZDServiceAlertView *)alertView didTapCancelButton:(UIButton *)button {
    [ZDServiceAlertView privacyNeedCheckAlertWithDelegate:self];
}
- (void)alertView:(ZDServiceAlertView *)alertView didTapSureButton:(UIButton *)button {
    if (alertView.alertViewType == ZDServiceAlertViewTypePrivacyNormalAlert) {
        ZD_UserM.hasShowPrivacy = YES;
    } else {
        [ZDServiceAlertView privacyAlertWithDelegate:self];
    }
    alertView = nil;
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
