//
//  PGMeSettingTableViewController.m
//  zhundao
//
//  Created by zhundao on 2016/12/27.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import "PGMeSettingTableViewController.h"
#import "AppDelegate.h"
#import "PGLoginMainVC.h"
//#import "SuggestViewController.h"
#import "PGMeMoreAcountViewController.h"
#import "PGPickerView.h"
@interface PGMeSettingTableViewController ()
{
    NSString *uidstr;
    NSString *AccessKeystr;
    NSString *acc;
}
@property (strong, nonatomic) IBOutlet UITableView *tableview;
/*! 修改cell */
@property (weak, nonatomic) IBOutlet UITableViewCell *xiugaiCell;
/*! 关于准到 */
@property (weak, nonatomic) IBOutlet UITableViewCell *aboutCell;
/*! 线路选择 */
@property (weak, nonatomic) IBOutlet UITableViewCell *lineCell;
/*! 选择器 */
@property(nonatomic,strong) PGPickerView *pickView;
/*! 当前线路显示 */
@property (weak, nonatomic) IBOutlet UILabel *lineLabel;
/*! 多账号管理 */
@property (weak, nonatomic) IBOutlet UITableViewCell *moreAcountCell;
// 用户协议
@property (unsafe_unretained, nonatomic) IBOutlet UITableViewCell *userProtocolCell;
// 隐私政策
@property (unsafe_unretained, nonatomic) IBOutlet UITableViewCell *privacyProtectCell;

@end

@implementation PGMeSettingTableViewController
/*! 退出登录 */
- (IBAction)loginout:(id)sender {
    UIAlertController *logoutAlert = [UIAlertController alertControllerWithTitle:nil message:@"退出后不会删除任何历史数据，下次登录依然可以使用本账号" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 =  [UIAlertAction actionWithTitle:@"退出登录" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self didLogout];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [logoutAlert addAction:action1];
    [logoutAlert addAction:action2];
    
    [self presentViewController:logoutAlert animated:YES completion:nil];
    
    
   
}
/*! 退出登录清空数据 */
- (void)didLogout
{
     if ([[PGSignManager shareManager].dataBase open])
     {
         NSString *updateSql = [NSString stringWithFormat:@"DROP TABLE signList"];
          [[PGSignManager shareManager].dataBase executeUpdate:updateSql];
         NSString *updateSql12 = [NSString stringWithFormat:@"DROP TABLE contact"];
         [[PGSignManager shareManager].dataBase executeUpdate:updateSql12];
         [[PGSignManager shareManager].dataBase close];
     }
    PGLoginMainVC *login = [[PGLoginMainVC alloc]init];
    AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    appDelegate.window.rootViewController = [[PGBaseNavVC alloc] initWithRootViewController:login];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f,0.0f, _tableview.bounds.size.width,15.0f)];
    _tableview.backgroundColor = ZDBackgroundColor;
    uidstr = [[NSUserDefaults standardUserDefaults]objectForKey:WX_UNION_ID];
    AccessKeystr = [[NSUserDefaults standardUserDefaults]objectForKey:AccessKey];
    
    UITapGestureRecognizer *xiugaiTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushxiugai)];
    [_xiugaiCell addGestureRecognizer:xiugaiTap];
    UITapGestureRecognizer *aboutTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushAbout)];
    [_aboutCell addGestureRecognizer:aboutTap];
    UITapGestureRecognizer *moreAcountTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(moreAcount)];
    [_moreAcountCell addGestureRecognizer:moreAcountTap];
    UITapGestureRecognizer *userProtocolTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushUserProtocol)];
    [_userProtocolCell addGestureRecognizer:userProtocolTap];
    UITapGestureRecognizer *privacyProtectTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushPrivacyProtect)];
    [_privacyProtectCell addGestureRecognizer:privacyProtectTap];
    PGSignManager *manager = [PGSignManager shareManager];
    acc = [manager getaccseekey];
    [self createVersion];
}
- (void)pushUserProtocol {
    PGBaseWebViewVC *web = [[PGBaseWebViewVC alloc] init];
    web.webTitle = @"准到服务协议";
    web.urlString = @"https://www.zhundao.net/service/help/detail/206";
    [self.navigationController pushViewController:web animated:YES];
}
- (void)pushPrivacyProtect {
    PGBaseWebViewVC *web = [[PGBaseWebViewVC alloc] init];
    web.urlString = @"https://www.zhundao.net/service/help/detail/207";
    web.webTitle = @"准到隐私政策";
    [self.navigationController pushViewController:web animated:YES];
}
- (void)moreAcount {
    PGMeMoreAcountViewController *moreAccount = [[PGMeMoreAcountViewController alloc] init];
    [self setHidesBottomBarWhenPushed: YES];
    [self.navigationController pushViewController:moreAccount animated:YES];
}

/*! 版本号查看 */
- (void)createVersion
{
    UILabel *versionLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, kScreenHeight-96, kScreenWidth-100,30)];
    [self.tableView addSubview:versionLabel];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    versionLabel.text = app_Version;
    versionLabel.font = [UIFont systemFontOfSize:12];
    versionLabel.textAlignment = NSTextAlignmentCenter;
    versionLabel.textColor  = ZDGrayColor ;
}
/*! 修改密码 */
- (void)pushxiugai
{
//
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"友情提醒" message:@"确定修改密码？若您没有密码，您输入的将变成密码" preferredStyle:UIAlertControllerStyleAlert];
   [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
       textField.placeholder = @"密码";
       textField.secureTextEntry = YES;
   }];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
         NSString *postStr = [NSString stringWithFormat:@"%@api/v2/user/updatePassWord?token=%@",zhundaoApi,[[PGSignManager shareManager] getToken]];
        NSDictionary *parameter = @{@"newPassWord" : alert.textFields.firstObject.text};
        if (alert.textFields.firstObject.text.length<6) {
            UIAlertController *lessAlert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入六位以上字符作为密码" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *lessAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [lessAlert addAction:lessAction];
            [self presentViewController:lessAlert animated:YES completion:nil];
        }
        else{
        MBProgressHUD *hud  = [[MBProgressHUD alloc]init];
        [self.view addSubview:hud];
        hud.animationType = MBProgressHUDAnimationFade;
        //        hud.minShowTime = 1;
        [hud showAnimated:YES];
            [ZD_NetWorkM postDataWithMethod:postStr parameters:parameter succ:^(NSDictionary *obj) {
                [hud hideAnimated:YES];
                
                PGMaskLabel *label = [[PGMaskLabel alloc] initWithTitle:@"修改成功,请重新登录"];
                [label labelAnimationWithViewlong:self.view];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self didLogout];
                });
            } fail:^(NSError *error) {
                
            }];
        }
    }];
    
    [alert addAction:action1];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:nil];
    
}
-(void)hudWasHidden:(MBProgressHUD *)hud
{
    [hud removeFromSuperview];
     hud = nil;
}

#pragma mark -----跳转关于准到
/*! 跳转关于准到 */

- (void)pushAbout
{
    PGBaseWebViewVC *web = [[PGBaseWebViewVC alloc] init];
    web.webTitle = @"关于";
    web.isClose = YES;
    web.urlString = @"https://www.zhundao.net";
    [self.navigationController pushViewController:web animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (_pickView) {
        _pickView = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
