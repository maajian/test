//
//  PostEmailViewController.m
//  zhundao
//
//  Created by zhundao on 2017/6/14.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PostEmailViewController.h"
#import "JPullEmailTF.h"
#import "UITextField+TextLeftOffset_ffset.h"
@interface PostEmailViewController ()
@property(nonatomic,strong)JPullEmailTF *textField;
@end

@implementation PostEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ZDBackgroundColor;
    self.title = @"发送名单";
    [self rightButtton];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [self createTextf];
    [_textField becomeFirstResponder];
}
- (void)rightButtton  // 右边发送邮箱按钮
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(postEmail)];
    NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:17],
                          NSForegroundColorAttributeName : ZDGreenColor};
    [item setTitleTextAttributes:dic forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = item;
}
- (void)createTextf  // 输入框初始化
{
    _textField = [[JPullEmailTF alloc] initWithFrame:CGRectMake(-1, 20, kScreenWidth+2, 44) InView:self.view];
//    textField.layer.borderColor = [UIColor colorWithRed:178.0f/256.0f green:178.0f/256.0f blue:178.0f/256.0f alpha:1].CGColor;
    _textField.layer.borderColor = [UIColor colorWithWhite:0.80 alpha:1].CGColor;
    _textField.layer.borderWidth = 1;
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.mailCellHeight  = 40;
    _textField.keyboardType = UIKeyboardTypeEmailAddress;
    
    [_textField setTextOffsetWithLeftViewRect:CGRectMake(0, 0, 20, 44) WithMode:UITextFieldViewModeAlways];
    _textField.mailFont        = [UIFont  systemFontOfSize:16];
    _textField.MailFontColor   = [UIColor blackColor];
    _textField.mailCellColor   = [UIColor whiteColor];
    _textField.mLeftMargin = 20;
    _textField.mailBgColor     = [UIColor whiteColor];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"email"]) {
        _textField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"email"];
    }
    [self.view addSubview:_textField];
}

#pragma  发送邮箱
//GET api/PerActivity/SendActivityListByEmail?accessKey={accessKey}&email={email}&activityId={activityId}
- (void)postEmail
{
    [self.view endEditing:YES];
    if ([_textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0) {
        maskLabel *label = [[maskLabel alloc]initWithTitle:@"输入框不能为空"];
        [label labelAnimationWithViewlong:self.view];
        return;
    }
    NSString *str = nil;
    if (_signID) {
        str = [NSString stringWithFormat:@"%@api/v2/checkIn/sendCheckInListByEmail?token=%@&email=%@&checkInId=%li&from=ios",zhundaoApi,[[SignManager shareManager] getToken],_textField.text,(long)self.signID];
    }else{
        str = [NSString stringWithFormat:@"%@api/v2/activity/sendActivityListByEmail?token=%@&email=%@&activityId=%li&from=ios",zhundaoApi,[[SignManager shareManager] getToken],_textField.text,(long)self.activityID];
    }
    MBProgressHUD *hud1 = [MyHud initWithAnimationType:MBProgressHUDAnimationFade showAnimated:YES UIView:self.view];
    [ZD_NetWorkM getDataWithMethod:str parameters:nil succ:^(NSDictionary *obj) {
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:obj];
        [hud1 hideAnimated:YES];
        if ([dic[@"Res"] integerValue]==0) {
            
            MBProgressHUD *hud = [MyHud initWithMode:MBProgressHUDModeCustomView labelText:@"发送成功!" showAnimated:YES UIView:self.view imageName:@"签到打勾"];
            [hud hideAnimated:YES afterDelay:1.5];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }else{
            maskLabel *label = [[maskLabel alloc]initWithTitle:dic[@"Msg"]];
            [label labelAnimationWithViewlong:self.view];
        }
    } fail:^(NSError *error) {
        NSLog(@"error = %@",error);
        [hud1 hideAnimated:YES];
        [[SignManager shareManager] showNotHaveNet:self.view];
    }];
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
