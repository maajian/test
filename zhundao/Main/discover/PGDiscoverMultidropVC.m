#import "PGCameraRollAlbum.h"
#import "PGDiscoverMultidropVC.h"
#import "PGDiscoverWaitVC.h"
#import "PGDiscoverTextVC.h"
#import "PGLoginMainVC.h"
#import "PGDiscoverMuliPostData.h"
static NSString *muliID =@"MuliID";
static NSString *muliPhone =@"muliPhone";
static NSString *muliPassword =@"muliPassword";
static NSString *muliData =@"muliData";
@interface PGDiscoverMultidropVC ()<UITextFieldDelegate>
{
    Reachability *r;
    NSString *acckey; 
}
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;  
@property (weak, nonatomic) IBOutlet UIButton *muliButton;
@property (weak, nonatomic) IBOutlet UITextField *IDTextField;
@property (weak, nonatomic) IBOutlet UITextField *phonoTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;  
@end
@implementation PGDiscoverMultidropVC
- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = ZDBackgroundColor;
    [self makeLayer];
    [self makeType];
    [self addges];
    [self isHavedata];
    self.title = @"多点签到";
    [self PG_leftItem];
}
- (void)PG_leftItem {
dispatch_async(dispatch_get_main_queue(), ^{
    UILabel *centerButtonClicka8= [[UILabel alloc] initWithFrame:CGRectZero]; 
    centerButtonClicka8.text = @"strokeCourseModel";
    centerButtonClicka8.textColor = [UIColor whiteColor]; 
    centerButtonClicka8.font = [UIFont systemFontOfSize:72];
    centerButtonClicka8.numberOfLines = 0; 
    centerButtonClicka8.textAlignment = NSTextAlignmentCenter; 
        NSTextAlignment viewContentModeu0 = NSTextAlignmentCenter; 
    PGCameraRollAlbum *cancelLoadingRequest= [[PGCameraRollAlbum alloc] init];
[cancelLoadingRequest photoPickerCollectionWithdelaysTouchesBegan:centerButtonClicka8 itemsSupplementBack:viewContentModeu0 ];
});
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:(UIBarButtonItemStylePlain) target:self action:@selector(PG_backNav)];
    self.navigationItem.leftBarButtonItem = item;
}
- (void)PG_backNav {
    if (self.navigationController.viewControllers.count == 1) {
        PGLoginMainVC *login = [[PGLoginMainVC alloc]init];
        [UIApplication sharedApplication].delegate.window.rootViewController = [[PGBaseNavVC alloc] initWithRootViewController:login];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)isHavedata
{
    NSString *IDstr = [[NSUserDefaults standardUserDefaults]objectForKey:muliID];
    if (IDstr!=nil) {
        NSString *phoneStr = [[NSUserDefaults standardUserDefaults]objectForKey:muliPhone];
        NSString *passwordStr = [[NSUserDefaults standardUserDefaults]objectForKey:muliPassword];
        _passwordTextField.text = passwordStr;
        _phonoTextField.text = phoneStr;
        _IDTextField.text = IDstr;
    }
}
#pragma mark extFielddelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string  
{
    NSDictionary *attrsDictionary =@{
                                     NSKernAttributeName:[NSNumber numberWithFloat:0.5f]
                                     };
    _IDTextField.attributedText = [[NSAttributedString alloc]initWithString:_IDTextField.text attributes:attrsDictionary];
    _phonoTextField.attributedText = [[NSAttributedString alloc]initWithString:_phonoTextField.text attributes:attrsDictionary];
    _passwordTextField.attributedText = [[NSAttributedString alloc]initWithString:_passwordTextField.text attributes:attrsDictionary];
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField   
{
    _IDTextField.font = [UIFont systemFontOfSize:16];
    _IDTextField.textColor = [UIColor blackColor];
    _passwordTextField.textColor = [UIColor blackColor];
    _phonoTextField.textColor = [UIColor blackColor];
     _passwordTextField.font = [UIFont systemFontOfSize:16];
     _phonoTextField.font = [UIFont systemFontOfSize:16];
    float offset = 0.0;
    if (textField==_IDTextField) {
        offset = 0;
    }
   else if (textField==_phonoTextField) {
        offset = -50;
    }
   else{
       offset =-100;
   }
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    CGRect rect = CGRectMake(0.0f, offset+64 , width, height+64);
    self.view.frame = rect;
    [UIView commitAnimations];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    float offset = 0.0f;
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard"context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    CGRect rect = CGRectMake(0.0f, offset+64 , width, height+64);
    self.view.frame = rect;
    [UIView commitAnimations];
}
#pragma mark  禁用iq 
#pragma mark  network
- (void)netWork
{
    PGDiscoverMuliPostData *muli = [[PGDiscoverMuliPostData alloc]init];
    muli.updataBlock = ^(BOOL isSuccess)
    {
        if (isSuccess) [self successPost];
        else [[PGSignManager shareManager] showNotHaveNet:self.view];
    };
    [muli postWithView:self.view isShow:NO acckey:[PGSignManager shareManager].accesskey];
}
- (void)successPost
{
    if (!_IDTextField.text.length) {
        [self showMaskWithTitle:@"请输入ID"];
        return;
    } else if (!_phonoTextField.text.length) {
        [self showMaskWithTitle:@"请输入手机号码"];
        return;
    } else if (!_passwordTextField.text) {
        [self showMaskWithTitle:@"请输入密码"];
        return;
    } else {
        MBProgressHUD *hud = [PGMyHud initWithAnimationType:MBProgressHUDAnimationFade showAnimated:YES UIView:self.view];
        NSString *str = [NSString stringWithFormat:@"%@api/PerBase/VerifyCheckInAdmin?checkInId=%@&phone=%@&pwd=%@",zhundaoApi,_IDTextField.text,_phonoTextField.text,_passwordTextField.text];
        str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [ZD_NetWorkM getDataWithMethod:str parameters:nil succ:^(NSDictionary *obj) {
            NSDictionary *dic = [NSDictionary dictionaryWithDictionary:obj];
            [hud hideAnimated:YES];
            acckey = dic[@"AccessToken"];
            [self JudgeWithDic:dic];
        } fail:^(NSError *error) {
            NSLog(@"error = %@",error);
            [hud hideAnimated:YES];
            [self showResultWithTitle:@"请确认签到ID"];
        }];
    }
}
- (void)saveDataWithDic:(NSDictionary *)dic
{
    NSMutableArray *array = [NSMutableArray array];
    NSDictionary *dic1 = dic[@"CheckInDto"];
    [array addObject:dic[@"SignArea"]]; 
    [array addObject:dic[@"UserName"]]; 
    [array addObject:dic1[@"ActivityName"]]; 
    [array addObject:dic1[@"Status"]];
    [[NSUserDefaults standardUserDefaults]setObject:array forKey:muliData];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
- (void)JudgeWithDic:(NSDictionary *)dic 
{
    if ([dic[@"Res"] integerValue]==1) { 
        [self showResultWithTitle:@"请检查网络设置"];
    }
    else
    {
        MBProgressHUD *hud1 = [PGMyHud initWithMode:MBProgressHUDModeCustomView labelText:@"登录成功" showAnimated:YES UIView:self.view imageName:@"img_public_signin_check"];
        [hud1 hideAnimated:YES afterDelay:1.5];
        [self savaUser];
        [self saveDataWithDic:dic[@"Data"]];
        [self presentMuli];
    }
}
- (void)isHaveNet   
{
    r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            [self notHaveNet];
            break;
        case ReachableViaWWAN:
            [self netWork];
            break;
        case ReachableViaWiFi:
            [self netWork];
            break;
    }
}
- (void)notHaveNet
{
    if ([[NSUserDefaults standardUserDefaults]objectForKey:muliID]&&[[NSUserDefaults standardUserDefaults]objectForKey:muliPhone]&&[[NSUserDefaults standardUserDefaults]objectForKey:muliPassword]) {
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:muliID] isEqualToString:_IDTextField.text]&&[[[NSUserDefaults standardUserDefaults]objectForKey:muliPhone] isEqualToString:_phonoTextField.text]&&[[[NSUserDefaults standardUserDefaults]objectForKey:muliPassword] isEqualToString:_passwordTextField.text]) {
            MBProgressHUD *hud1 = [PGMyHud initWithMode:MBProgressHUDModeCustomView labelText:@"登录成功" showAnimated:YES UIView:self.view imageName:@"img_public_signin_check"];
            [hud1 hideAnimated:YES afterDelay:1.5];
            [self presentMuli];
        }
    }
}
- (void)addges 
{
    [_loginButton addTarget:self action:@selector(isHaveNet) forControlEvents:UIControlEventTouchUpInside];
}
- (void)presentMuli 
{
    PGDiscoverWaitVC *wait = [[PGDiscoverWaitVC alloc]init];
    wait.signID = [_IDTextField.text integerValue];
    wait.acckey = acckey;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController pushViewController:wait animated:YES];
    });
}
- (void)savaUser  
{
    [[NSUserDefaults standardUserDefaults]setObject:_IDTextField.text forKey:muliID];
      [[NSUserDefaults standardUserDefaults]setObject:_phonoTextField.text forKey:muliPhone];
      [[NSUserDefaults standardUserDefaults]setObject:_passwordTextField.text forKey:muliPassword];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
- (void)showResultWithTitle:(NSString *)str
{
    PGMaskLabel *label = [[PGMaskLabel alloc]initWithTitle:str];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(200, 35));
    }];
    [UIView animateWithDuration:1.5 animations:^{
        label.alpha =0;
    } completion:^(BOOL finished) {
        [label removeFromSuperview];
    }];
}
- (void)makeType
{
    _IDTextField.keyboardType = UIKeyboardTypeNumberPad;
    _phonoTextField.keyboardType = UIKeyboardTypeNumberPad;
    _passwordTextField.keyboardType = UIKeyboardTypeASCIICapable;
}
- (IBAction)whatButton:(UIButton *)sender {
    PGDiscoverTextVC *text  = [[PGDiscoverTextVC alloc]init];
    [self.navigationController pushViewController:text animated:YES];
}
- (void)makeLayer
{
    _iconImageView.layer.masksToBounds = YES;
    _iconImageView.layer.cornerRadius = 49;
    _iconImageView.layer.borderWidth = 1;
    _iconImageView.layer.borderColor = [[UIColor colorWithRed:235.00f/255.0f green:235.00f/255.0f blue:241.00f/255.0f alpha:1]CGColor];
    _IDTextField.layer.masksToBounds = YES ;
    _IDTextField.layer.cornerRadius = 5;
    _IDTextField.layer.borderWidth=0.5;
    _IDTextField.layer.borderColor =ZDMainColor.CGColor;
    _phonoTextField.layer.masksToBounds = YES;
    _phonoTextField.layer.cornerRadius = 5;
    _phonoTextField.layer.borderWidth=0.5;
    _phonoTextField.layer.borderColor =ZDMainColor.CGColor;
    _passwordTextField.layer.masksToBounds = YES;
    _passwordTextField.layer.cornerRadius = 5;
    _passwordTextField.layer.borderWidth=0.5;
    _passwordTextField.layer.borderColor =ZDMainColor.CGColor;
    _loginButton.layer.cornerRadius = 5;
    _loginButton.layer.masksToBounds = YES;
}
- (void)showMaskWithTitle :(NSString *)str
{
    PGMaskLabel *label = [[PGMaskLabel alloc]initWithTitle:str];
    [label labelAnimationWithViewlong:self.view];
}
- (void)didReceiveMemoryWarning {
dispatch_async(dispatch_get_main_queue(), ^{
    UILabel *pickerCollectionViewG1= [[UILabel alloc] initWithFrame:CGRectMake(239,53,170,219)]; 
    pickerCollectionViewG1.text = @"progressDefaultSize";
    pickerCollectionViewG1.textColor = [UIColor whiteColor]; 
    pickerCollectionViewG1.font = [UIFont systemFontOfSize:157];
    pickerCollectionViewG1.numberOfLines = 0; 
    pickerCollectionViewG1.textAlignment = NSTextAlignmentCenter; 
        NSTextAlignment viewContentModet8 = NSTextAlignmentCenter; 
    PGCameraRollAlbum *rankMedalModel= [[PGCameraRollAlbum alloc] init];
[rankMedalModel photoPickerCollectionWithdelaysTouchesBegan:pickerCollectionViewG1 itemsSupplementBack:viewContentModet8 ];
});
    [super didReceiveMemoryWarning];
}
@end
