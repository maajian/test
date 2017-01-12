//
//  SendViewController.m
//  zhundao
//
//  Created by zhundao on 2016/12/15.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import "SendViewController.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "MainViewController.h"
#import "LoginViewController.h"
@interface SendViewController ()
{
    NSString *Unionid;
    NSDictionary *dic;
}
@property (weak, nonatomic) IBOutlet UITextField *phonetext;
@property (weak, nonatomic) IBOutlet UITextField *phoneyangzheng;

@end

@implementation SendViewController
- (IBAction)sendyangzheng:(id)sender {
    AFHTTPSessionManager *manager = [AFmanager shareManager];
  
    NSString *urlstr = [NSString stringWithFormat:@"https://open.zhundao.net/api/PerBase/SendICode?phone=%@&accessKey=%@",_phonetext.text,Unionid];
    [manager GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"res = %@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
    
    
}
- (IBAction)backaction:(id)sender {
    
    LoginViewController *login = [[LoginViewController alloc]init];
     AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    appDelegate.window.rootViewController = login;
    
}
- (IBAction)bangding:(id)sender {
    AFHTTPSessionManager *manager = [AFmanager shareManager];
    NSString *url = [NSString stringWithFormat:@"https://open.zhundao.net/api/PerBase/BindPhone?phone=%@&accessKey=%@&code=%@",_phonetext.text,Unionid,_phoneyangzheng.text];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"response = %@",responseObject);
        dic = [NSDictionary dictionaryWithDictionary:responseObject];
        if ([dic[@"Res"] integerValue]==0) {
            MainViewController *tabbar = [[MainViewController alloc]init];
            AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
            appDelegate.window.rootViewController= tabbar;

        }
          if ([dic[@"Res"] integerValue]==1) {
              [self showalert];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error = %@",error);
    }];
  
}
- (void)showalert
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入正确的手机号和验证码" message:@"sssssss" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
   Unionid = [[NSUserDefaults standardUserDefaults]objectForKey:WX_UNION_ID];
    
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
