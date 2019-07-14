//
//  PasswordViewController.m
//  zhundao
//
//  Created by zhundao on 2017/11/7.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PasswordViewController.h"
#import "payTextField.h"
#import "MyWalletViewController.h"

@interface PasswordViewController ()<payTextFieldDelegate>{
    payTextField *textfView;
}

@property(nonatomic,strong)UILabel *label;

@end

@implementation PasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    [self setUI];
    [self titleSet];
    // Do any additional setup after loading the view.
}

- (void)setUI{
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(50, 110, kScreenWidth-100, 40)];
    _label.textColor = kheaderTitleColor;
    _label.font =[UIFont systemFontOfSize:15];
    _label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_label];
    textfView = [[payTextField alloc]initWithFrame:CGRectMake(50, 150, kScreenWidth-100, (kScreenWidth-100)/6) blackRadius:5];
    textfView.payTextFieldDelegate = self;
    [self.view addSubview:textfView];
}

#pragma mark --- payTextFieldDelegate

- (void)sendPassWord:(NSString *)PS{
    switch (_state) {
             // 验证老密码 
        case Old:{
            [self verifyOld:PS];
        }
            break;
             // 输入新密码
        case New:{
            PasswordViewController *password1 = [[PasswordViewController alloc]init];
            [self setHidesBottomBarWhenPushed:YES];
            password1.state = ReNew;
            password1.password = PS;
            [self.navigationController pushViewController:password1 animated:YES];
        }
            break;
             // 再次输入密码
        case ReNew:{
            if ([PS isEqualToString:_password]) {
                [self changePassword];
            }else{
                maskLabel *label = [[maskLabel alloc]initWithTitle:@"密码输入不匹配，请重新输入"];
                [label labelAnimationWithViewlong:self.view];
                [self clearData];
            }
        }
            break;
            
        default:
            break;
    }
}
#pragma mark--- 网络请求
- (void)changePassword{
    
    AFmanager *manager = [AFmanager shareManager];
    NSString *str = [NSString stringWithFormat:@"%@api/PerBase/SetPassWord?accessKey=%@&newPwd=%@",zhundaoApi,[[SignManager shareManager]getaccseekey],textfView.textf.text];
    MBProgressHUD *hud = [MyHud initWithAnimationType:MBProgressHUDAnimationFade showAnimated:YES UIView:self.view];
    hud.label.text = @"请稍候...";
    [manager GET:str parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [hud hideAnimated:YES];
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseObject];
        if ([dic[@"Res"]integerValue]==0) {
            MBProgressHUD *hud1 = [MyHud initWithMode:MBProgressHUDModeCustomView labelText:@"设置成功" showAnimated:YES UIView:self.view imageName:@"签到打勾"];
            [hud1 hideAnimated:YES afterDelay:1.5];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                MyWalletViewController *MyWallet = nil;
//                for (UIViewController *VC in self.navigationController.viewControllers) {
//                    if ([VC isKindOfClass:[MyWalletViewController class]]) {
//                        MyWallet = (MyWalletViewController *)VC;
//                    }
//                }
//                [self.navigationController popToViewController:MyWallet animated:YES];
                [self.navigationController popToRootViewControllerAnimated:YES];
            });
        }else{
            maskLabel *label = [[maskLabel alloc]initWithTitle:dic[@"Msg"]];
            [label labelAnimationWithViewlong:self.view];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         [hud hideAnimated:YES];
    }];
}

- (void)verifyOld :(NSString *)old{
    AFmanager *manager = [AFmanager shareManager];
    NSString *str = [NSString stringWithFormat:@"%@api/PerBase/VerifyOldPwd?accessKey=%@&oldPwd=%@",zhundaoApi,[[SignManager shareManager]getaccseekey],old];
     MBProgressHUD *hud = [MyHud initWithAnimationType:MBProgressHUDAnimationFade showAnimated:YES UIView:self.view];
    hud.label.text = @"请稍候...";
    [manager GET:str parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         [hud hideAnimated:YES];
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseObject];
        if ([dic[@"Res"] integerValue]==0) {
            PasswordViewController *password1 = [[PasswordViewController alloc]init];
            [self setHidesBottomBarWhenPushed:YES];
            password1.state = New;
            [self.navigationController pushViewController:password1 animated:YES];
        }else{
            [self showLabel:@"密码输入错误"];
            [self clearData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         [hud hideAnimated:YES];
    }];
}

#pragma mark --- 其他

- (void)showLabel:(NSString *)str{
    maskLabel *label = [[maskLabel alloc]initWithTitle:str];
    [label labelAnimationWithViewlong:self.view];
}

- (void)titleSet{
    switch (_state) {
        case Old:{
            _label.text = @"请输入原来的支付密码，以验证身份";
        }
            break;
        case New:{
            _label.text = @"请输入支付密码";
        }
            break;
        case ReNew:{
            _label.text = @"请再次填写以确认";
        }
            break;
            
        default:
            break;
    }
}

- (void)clearData{
    textfView.textf.text = @"";
    textfView.label1.hidden = YES;
    textfView.label2.hidden = YES;
    textfView.label3.hidden = YES;
    textfView.label4.hidden = YES;
    textfView.label5.hidden = YES;
    textfView.label6.hidden = YES;
    
}

- (void)dealloc{
    NSLog(@"没有内存泄露");
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
