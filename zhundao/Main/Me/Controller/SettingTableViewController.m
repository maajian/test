//
//  SettingTableViewController.m
//  zhundao
//
//  Created by zhundao on 2016/12/27.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import "SettingTableViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "SuggestViewController.h"
#import "AboutViewController.h"
@interface SettingTableViewController ()
{
    NSString *uidstr;
    NSString *AccessKeystr;
    NSString *acc;
}

@property (weak, nonatomic) IBOutlet UITableViewCell *xiugaiCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *aboutCell;


@end

@implementation SettingTableViewController
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
- (void)didLogout
{
    
//    if (uidstr) {
//        [[NSUserDefaults standardUserDefaults]removeObjectForKey:WX_UNION_ID];
//        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"name"];
//        
//        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"sex"];
//        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"image"];
//    }
//    if (AccessKeystr) {[[NSUserDefaults standardUserDefaults]removeObjectForKey:phoneName];
//        [[NSUserDefaults standardUserDefaults]removeObjectForKey:phoneSexsex];
//        
//        [[NSUserDefaults standardUserDefaults]removeObjectForKey:phoneuserimage];
//        [[NSUserDefaults standardUserDefaults]removeObjectForKey:AccessKey];
//        
//        
//    }
    NSString*appDomain = [[NSBundle mainBundle]bundleIdentifier];
    
    [[NSUserDefaults standardUserDefaults]removePersistentDomainForName:appDomain];
    LoginViewController *login = [[LoginViewController alloc]init];
    AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    appDelegate.window.rootViewController = login;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    uidstr = [[NSUserDefaults standardUserDefaults]objectForKey:WX_UNION_ID];
    AccessKeystr = [[NSUserDefaults standardUserDefaults]objectForKey:AccessKey];
    
    UITapGestureRecognizer *xiugaiTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushxiugai)];
    [_xiugaiCell addGestureRecognizer:xiugaiTap];
    UITapGestureRecognizer *aboutTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushAbout)];
    [_aboutCell addGestureRecognizer:aboutTap];
    SignManager *manager = [SignManager shareManager];
    acc = [manager getaccseekey];
}

- (void)pushxiugai
{
//
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"友情提醒" message:@"确定修改密码？若您没有密码，您输入的将变成密码" preferredStyle:UIAlertControllerStyleAlert];
   [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
       textField.placeholder = @"密码";
       textField.secureTextEntry = YES;
   }];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         NSString *postStr = [NSString stringWithFormat:@"https://open.zhundao.net/api/PerBase/UpdatePassWord?accessKey=%@&passWord=%@",acc,alert.textFields.firstObject.text];
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
        AFHTTPSessionManager *manager = [AFmanager shareManager];
        [manager POST:postStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"respond = %@",responseObject[@"Msg"]);
            
            
            
            [hud hideAnimated:YES];
            
            MBProgressHUD *hud1  = [[MBProgressHUD alloc]init];
            hud1.label.text = @"修改成功";
             [self.view addSubview:hud1];
            hud1.mode = MBProgressHUDModeCustomView;
            hud1.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"checked"]];
            [hud1 showAnimated:YES];
            [hud1 hideAnimated:YES afterDelay:1];
        
         
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error = %@",error);
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
- (void)pushAbout
{
    AboutViewController  *aboutCtrl = [[AboutViewController alloc]init];
    aboutCtrl.urlString = @"https://m.zhundao.net/html/aboutus.html";
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:aboutCtrl animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}

//- (void)pushSuggset
//{
//
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:p forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
