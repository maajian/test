//
//  MeViewController.m
//  zhundao
//
//  Created by zhundao on 2016/12/2.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import "MeViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "MyWalletViewController.h"
#import "MyContactViewController.h"
@interface MeViewController ()
{
    NSString *uidstr;
    NSString *AccessKeystr;
    NSDictionary *userdic ;
    NSString *acc;
}
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *sexLabel;
@property (weak, nonatomic) IBOutlet UITableViewCell *myWalletCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *suggestCell;
@property (strong, nonatomic) IBOutlet UITableView *tableview;



@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     _tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f,0.0f, _tableview.bounds.size.width,15.0f)];
    uidstr = [[NSUserDefaults standardUserDefaults]objectForKey:WX_UNION_ID];
    AccessKeystr = [[NSUserDefaults standardUserDefaults]objectForKey:AccessKey];
    if (AccessKeystr) {
     
          [self getuser];
    }
    if (uidstr) {
         [self IconAndName];
    }
    
    SignManager *manager = [SignManager shareManager];
    acc =  [manager getaccseekey];
    UITapGestureRecognizer *contacttap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showsuggest)];
    [_suggestCell addGestureRecognizer:contacttap];
    
    UITapGestureRecognizer *walletTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushWallet)];
    [_myWalletCell addGestureRecognizer:walletTap];
    _iconImageView.layer.cornerRadius = 33;
    _iconImageView.layer.masksToBounds = YES;
    _iconImageView.layer.borderWidth = 1;
    _iconImageView.layer.borderColor =  [[UIColor colorWithRed:235.00f/255.0f green:235.00f/255.0f blue:241.00f/255.0f alpha:1]CGColor];
}
- (void)showsuggest
{
    UIAlertController *suggestAlert = [UIAlertController alertControllerWithTitle:@"您好" message:@"您有任何问题欢迎添加微信公众号“izhundao”进行反馈，我们会及时给您回复!" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [suggestAlert addAction:action1];
    [self presentViewController:suggestAlert animated:YES completion:nil];
}
- (void)pushWallet
{
    MyWalletViewController *walletCtrl = [[MyWalletViewController alloc]init];
    walletCtrl.urlString = [NSString stringWithFormat:@"https://m.zhundao.net/Activity/MyWallet?accesskey=%@",acc];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:walletCtrl animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}
- (void)getuser
{
    NSString *image1 = [[NSUserDefaults standardUserDefaults]objectForKey:phoneuserimage];
    NSString *sex1 = [[NSUserDefaults standardUserDefaults]objectForKey:phoneSexsex];
    NSString *name1 = [[NSUserDefaults standardUserDefaults]objectForKey:phoneName];

    if (image1 ==nil||sex1==nil||name1==nil) {
        NSString *userstr = [NSString stringWithFormat:@"https://open.zhundao.net/api/PerBase/GetUserInfo?accessKey=%@",AccessKeystr];
        AFHTTPSessionManager *manager = [AFmanager shareManager];
        [manager GET:userstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *data = [NSDictionary dictionaryWithDictionary:responseObject];
            userdic = data[@"Data"];
//            NSLog(@"userdic = %@",userdic);
            [_iconImageView sd_setImageWithURL:[NSURL URLWithString:userdic[@"HeadImgurl"]]];
            [[NSUserDefaults standardUserDefaults]setObject:userdic[@"HeadImgurl"] forKey:phoneuserimage];
            [[NSUserDefaults standardUserDefaults]setObject:userdic[@"Sex"] forKey:phoneSexsex];
          
            if ([userdic[@"Sex"] integerValue]==1) {
                _sexLabel.image = [UIImage imageNamed:@"male"];
                
            }
           
            else
            {
                _sexLabel.image = [UIImage imageNamed:@"female"];
            }
          
           
            NSString *str = userdic[@"NickName"];
            [[ NSUserDefaults  standardUserDefaults]setObject: str forKey:phoneName];
            _nameLabel.text = str;
            _nameLabel.font = [UIFont boldSystemFontOfSize:13];
            [self.tableView reloadData];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error = %@",error);
        }];
    }
    
    if (name1&&sex1&&image1) {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory=[paths objectAtIndex:0];//Documents目录
        NSLog(@"NSDocumentDirectory:%@",documentsDirectory);
        [_iconImageView sd_setImageWithURL:[NSURL URLWithString:image1]];
        
        if ([sex1 integerValue]==1) {
            _sexLabel.image = [UIImage imageNamed:@"male"];
            
        }
        
        else
        {
            _sexLabel.image = [UIImage imageNamed:@"female"];
        }
        
        
        
        _nameLabel.text = name1;
        _nameLabel.font = [UIFont boldSystemFontOfSize:13];
        [self.tableView reloadData];

    }
    }



- (void)IconAndName

{
    
 
        NSString *imagestr = [[NSUserDefaults standardUserDefaults] objectForKey:@"image"];
        NSString *sexStr = [[NSUserDefaults standardUserDefaults]objectForKey:@"sex"];
        NSString *nameStr = [[NSUserDefaults standardUserDefaults]objectForKey:@"name"];
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:imagestr]];
        if ([sexStr integerValue]==1) {
            _sexLabel.image = [UIImage imageNamed:@"male"];
            
        }
        else
        {
            _sexLabel.image = [UIImage imageNamed:@"female"];
        }
        self.nameLabel.text = nameStr;
        self.nameLabel.font = [UIFont boldSystemFontOfSize:13];
        [self.tableView reloadData];
   

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
