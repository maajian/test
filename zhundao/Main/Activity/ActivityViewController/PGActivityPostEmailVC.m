#import "PGDiscoveryViewController.h"
#import "PGActivityPostEmailVC.h"
#import "PGActivityJPullEmailTF.h"
#import "UITextField+TextLeftOffset_ffset.h"
@interface PGActivityPostEmailVC ()
@property(nonatomic,strong)PGActivityJPullEmailTF *textField;
@end
@implementation PGActivityPostEmailVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ZDBackgroundColor;
    self.title = @"发送名单";
    [self rightButtton];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [self createTextf];
    [_textField becomeFirstResponder];
}
- (void)rightButtton  
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(postEmail)];
    NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:17],
                          NSForegroundColorAttributeName : ZDMainColor};
    [item setTitleTextAttributes:dic forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = item;
}
- (void)createTextf  
{
    _textField = [[PGActivityJPullEmailTF alloc] initWithFrame:CGRectMake(-1, 20, kScreenWidth+2, 44) InView:self.view];
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
- (void)postEmail
{
    [self.view endEditing:YES];
    if ([_textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0) {
        PGMaskLabel *label = [[PGMaskLabel alloc]initWithTitle:@"输入框不能为空"];
        [label labelAnimationWithViewlong:self.view];
        return;
    }
    if (!ZD_UserM.isAdmin) {
        NSString *url = [NSString stringWithFormat:@"%@jinTaData?token=%@", zhundaoLogApi, ZD_UserM.token];
        NSDictionary *dic = @{@"BusinessCode": @"ExportActivityList",
                              @"Data" : @{
                                      @"ActivityId":@(self.activityID),
                                      @"Email": _textField.text,
                             }
        };
        [ZD_NetWorkM postDataWithMethod:url parameters:dic succ:^(NSDictionary *obj) {
            if ([obj[@"res"] boolValue]) {
                ZD_HUD_SHOW_SUCCESS_STATUS(@"发送成功");
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            } else {
                ZD_HUD_SHOW_ERROR_STATUS(obj[@"errmsg"])
            }
        } fail:^(NSError *error) {
            ZD_HUD_SHOW_ERROR(error)
        }];
    } else {
        NSString *str = nil;
        if (_signID) {
            str = [NSString stringWithFormat:@"%@api/CheckIn/SendCheckInListByEmail?accessKey=%@&email=%@&checkInId=%li",zhundaoApi,[[PGSignManager shareManager] getaccseekey],_textField.text,(long)self.signID];
        }else{
            str = [NSString stringWithFormat:@"%@api/PerActivity/SendActivityListByEmail?accessKey=%@&email=%@&activityId=%li",zhundaoApi,[[PGSignManager shareManager] getaccseekey],_textField.text,(long)self.activityID];
        }
        ZD_HUD_SHOW_WAITING
        [ZD_NetWorkM getDataWithMethod:str parameters:nil succ:^(NSDictionary *obj) {
            NSDictionary *dic = [NSDictionary dictionaryWithDictionary:obj];
            if ([dic[@"Res"] integerValue]==0) {
                ZD_HUD_SHOW_SUCCESS_STATUS(@"发送成功");
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }else{
                ZD_HUD_SHOW_ERROR_STATUS(dic[@"Msg"])
            }
        } fail:^(NSError *error) {
            ZD_HUD_SHOW_ERROR(error)
        }];
    }
}
- (void)didReceiveMemoryWarning {
dispatch_async(dispatch_get_main_queue(), ^{
    UITableViewCellSeparatorStyle becomeActiveNotificationx0 = UITableViewCellSeparatorStyleNone; 
        NSString *numberFormatterRoundJ8 = @"withMedalKind";
    PGDiscoveryViewController *orderDetailView= [[PGDiscoveryViewController alloc] init];
[orderDetailView timesFromSliderWithscreenButtonClick:becomeActiveNotificationx0 withJsonString:numberFormatterRoundJ8 ];
});
    [super didReceiveMemoryWarning];
}
@end
