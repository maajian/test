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
#import "AppDelegate.h"
#import "ActivityViewController.h"
#import "AFURLRequestSerialization.h"
#import <Foundation/NSJSONSerialization.h>
#define URL_APPID @"appid"
#define URL_SECRET @"app secret"
//wxe25de2684f235a04 appid
//3286d02771487220b3135ed3620e552e appsecret
@interface LoginViewController ()
{
    SendAuthResp *temp ;
    NSString *AccessKey1;
    NSDictionary *responseObjectdic;
}
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (copy, nonatomic) void (^requestForUserInfoBlock)();
@property (weak, nonatomic) IBOutlet UITextField *phoneTextLabel;
@property (weak, nonatomic) IBOutlet UITextField *lockTextLabel;
@property (weak, nonatomic) IBOutlet UIImageView *appImageView;

@end

@implementation LoginViewController
- (IBAction)phonelogin:(id)sender {

    NSString *phoneurl = [NSString stringWithFormat:@"https://open.zhundao.net/api/PerBase/GetAccessKey?mobile=%@&passWord=%@",_phoneTextLabel.text,_lockTextLabel.text];
    AFHTTPSessionManager *manager = [AFmanager shareManager];
    [manager GET:phoneurl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject = %@",responseObject);
        NSDictionary *Dic = [NSDictionary dictionaryWithDictionary:responseObject];
        NSString *accessKey = Dic[@"AccessKey"];
        [[NSUserDefaults standardUserDefaults]setObject:accessKey forKey:AccessKey];
        
        
        if ([Dic[@"Res"] integerValue]==0) {
            MainViewController *tabbar = [[MainViewController alloc]init];
            AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
            appDelegate.window.rootViewController= tabbar;
        }
      if ([Dic[@"Res"] integerValue]==1) {
          [self setupAlertController1];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
        return ;
    }];
  
 }


- (IBAction)loginAction:(id)sender {
    

                [self wechatLogin];
                
    
    
  

}

- (BOOL)wechatLogin {
    if ([WXApi isWXAppInstalled]) {
        SendAuthReq *req = [[SendAuthReq alloc] init];
        req.scope = @"snsapi_userinfo";
        req.state = @"GSTDoctorApp";
   
        
        [WXApi sendReq:req];
        return YES;
    }
    else {
        [self setupAlertController];
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
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = NO;
    _appImageView.layer.masksToBounds = YES;
    _appImageView.layer.cornerRadius = 49;
    _appImageView.layer.borderWidth = 1;
    _appImageView.layer.borderColor = [[UIColor colorWithRed:235.00f/255.0f green:235.00f/255.0f blue:241.00f/255.0f alpha:1]CGColor];
    // Do any additional setup after loading the view from its nib.
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
