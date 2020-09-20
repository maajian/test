//
//  PGloginSendVC.m
//  zhundao
//
//  Created by zhundao on 2016/12/15.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import "PGloginSendVC.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "PGBaseTabbarVC.h"
#import "PGLoginMainVC.h"
@interface PGloginSendVC ()
{
    NSDictionary *dic;
}
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UITextField *phonetext;
@property (weak, nonatomic) IBOutlet UITextField *phoneyangzheng;

@end

@implementation PGloginSendVC
- (IBAction)sendyangzheng:(id)sender {
    NSString *str = [NSString stringWithFormat:@"%@api/v2/senCode?phoneOrEmail=%@",zhundaoApi,_phonetext.text];
    [ZD_NetWorkM getDataWithMethod:str parameters:nil succ:^(NSDictionary *obj) {
        [self beginTime];
    } fail:^(NSError *error) {
        
    }];
}
- (void)beginTime {
    __block int timeout =60;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC,0);
    dispatch_source_set_event_handler(timer, ^{
        if (timeout<=0) {
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                _sendButton.userInteractionEnabled = YES;
                    [_sendButton setBackgroundColor:ZDMainColor];
                 [_sendButton setTitle:@"获取验证码" forState:UIControlStateNormal];
            });
          
            
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                _sendButton.userInteractionEnabled = NO;
                [_sendButton setBackgroundColor:ZDGrayColor];
                  [_sendButton setTitle:[NSString stringWithFormat:@"(%d)发送验证码",timeout] forState:UIControlStateNormal];
                timeout--;
            });
            
        }
    });
    dispatch_resume(timer);
}
- (IBAction)backaction:(id)sender {
    
    PGLoginMainVC *login = [[PGLoginMainVC alloc]init];
     AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    appDelegate.window.rootViewController = [[PGBaseNavVC alloc] initWithRootViewController:login];
    
}
- (IBAction)bangding:(id)sender {
    if (_phonetext.text.length <7) {
        [self showAlert:@"请输入正确的手机号"];
        return;
    }
    NSString *verifyUrl = [NSString stringWithFormat:@"%@api/v2/verifyCode?phoneOrEmail=%@&code=%@",zhundaoApi,_phonetext.text,_phoneyangzheng.text];
    [ZD_NetWorkM getDataWithMethod:verifyUrl parameters:nil succ:^(NSDictionary *obj) {
        NSString *url = [NSString stringWithFormat:@"%@/api/v2/user/updatePhoneOrEmail?phoneOrEmail=%@&token=%@&code=%@",zhundaoApi,_phonetext.text,[[PGSignManager shareManager] getToken],_phoneyangzheng.text];
        [ZD_NetWorkM getDataWithMethod:url parameters:nil succ:^(NSDictionary *obj) {
            dic = [NSDictionary dictionaryWithDictionary:obj];
            if ([dic[@"errcode"] integerValue]==0) {
                [ZD_UserM saveLoginTime];
                PGBaseTabbarVC *tabbar = [[PGBaseTabbarVC alloc]init];
                AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
                appDelegate.window.rootViewController= tabbar;
                
            } else {
                [self showalert];
            }
        } fail:^(NSError *error) {
            
        }];
    } fail:^(NSError *error) {
        
    }];
}

- (void)showalert
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入正确的手机号和验证码" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绑定手机号";
    _phonetext.keyboardType = UIKeyboardTypeNumberPad;
    _phoneyangzheng.keyboardType = UIKeyboardTypeNumberPad;
    // Do any additional setup after loading the view from its nib.
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
