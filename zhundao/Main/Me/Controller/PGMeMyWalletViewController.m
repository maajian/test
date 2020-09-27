#import "PGFriendsViewModel.h"
#import "PGMeMyWalletViewController.h"
#import "PGMeMyWalletView.h"
#import "PGMeDetailMoneyViewController.h"
#import "PGMeWithDrawViewController.h"
#import "PGMeMyWalletViewModel.h"
#import "PGMeDetailWithDrawViewController.h"
#import "PGMeIsOnGowithViewController.h"
#import "PGMeAuthViewController.h"
#import "PGAlertSheet.h"
#import "PasswordViewController.h"
#import "payVerifyViewController.h"
@interface PGMeMyWalletViewController ()<PGMeMyWalletDelegate>{
    Reachability *r;
}
@property(nonatomic,strong)PGMeMyWalletView *walletView;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)PGMeMyWalletViewModel *MyWalletVM;
@property(nonatomic,strong)JQIndicatorView *indicator;
@property(nonatomic,assign)float allMoney;
@property(nonatomic,assign)float withDraw;
@property(nonatomic,strong)NSDictionary *datadic;
@end
@implementation PGMeMyWalletViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的钱包";
    _MyWalletVM = [[PGMeMyWalletViewModel alloc]init];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"明细" style:UIBarButtonItemStylePlain target:self action:@selector(rightNav)];
    [self.view addSubview:self.scrollView];
}
#pragma mark ---网络判断
- (void)firstLoad
{
    r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            [self PG_notNet];
            break;
        case ReachableViaWWAN:
            [self netWork];
            break;
        case ReachableViaWiFi:
            [self netWork];
            break;
    }
}
- (void)netWork{
dispatch_async(dispatch_get_main_queue(), ^{
    NSTextAlignment pushNotificationTriggerG5 = NSTextAlignmentCenter; 
        UITableViewStyle collectionOriginalViewb9 = UITableViewStylePlain; 
    PGFriendsViewModel *organizeNoticeModel= [[PGFriendsViewModel alloc] init];
[organizeNoticeModel customAnimateTransitionWitharticleCommentData:pushNotificationTriggerG5 tweetItemData:collectionOriginalViewb9 ];
});
    [self PG_showIndicate];
    __weak typeof(_MyWalletVM) weakVM = _MyWalletVM;
    [self.MyWalletVM getInfo:^(NSDictionary *moneyDic) {
        _datadic = moneyDic;
        _walletView.moneyLabel.text = [NSString stringWithFormat:@"¥%.2f",[moneyDic[@"Balance"] floatValue]];
        if ([moneyDic[@"status"] integerValue]==0) {
            [weakVM saveWithdraw:_datadic];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self PG_changeButton:moneyDic];
                [_indicator stopAnimating];
            });
        }else{
             [_indicator stopAnimating];
        }
    }];
}
- (void)PG_notNet {
    _datadic = [_MyWalletVM readWithdraw];
     _walletView.moneyLabel.text = [NSString stringWithFormat:@"¥%.2f",[_datadic[@"Balance"] floatValue]];
    if ([_datadic[@"status"] integerValue]==0) {
        [self PG_changeButton:[_MyWalletVM readWithdraw]];
    }
}
#pragma mark -----懒加载
- (PGMeMyWalletView *)walletView{
    if (!_walletView) {
        _walletView = [[PGMeMyWalletView alloc]initInView:self.view];
        _walletView.delegate =self;
    }
    return _walletView;
}
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
        _scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight-63);
        _scrollView.backgroundColor = ZDBackgroundColor;
        _scrollView.showsVerticalScrollIndicator = NO;
        [_scrollView addSubview:self.walletView];
    }
    return  _scrollView;
}
#pragma mark -------   other
- (void)PG_showIndicate{
    _indicator = [[JQIndicatorView alloc]initWithType:3 tintColor: [UIColor colorWithRed:9.00f/255.0f green:187.00f/255.0f blue:7.00f/255.0f alpha:1] size:CGSizeMake(90, 70)];
    _indicator.center = self.view.center;
    [self.view addSubview:_indicator];
    [_indicator startAnimating];
}
- (void)PG_changeButton :(NSDictionary *) dic{
dispatch_async(dispatch_get_main_queue(), ^{
    NSTextAlignment imageOptionProgressiveW7 = NSTextAlignmentCenter; 
        UITableViewStyle trainCommentTableQ4 = UITableViewStylePlain; 
    PGFriendsViewModel *matchingReportProgress= [[PGFriendsViewModel alloc] init];
[matchingReportProgress customAnimateTransitionWitharticleCommentData:imageOptionProgressiveW7 tweetItemData:trainCommentTableQ4 ];
});
    if ([dic[@"Status"] integerValue]==0) { 
        [_walletView.withdrawButton setTitle:[NSString stringWithFormat:@"¥%.2f 提现中",[dic[@"Amount"]floatValue]] forState:UIControlStateNormal];
    }else{  
        [_walletView.withdrawButton setTitle:@"提现" forState:UIControlStateNormal];
    }
}
#pragma mark PGMeMyWalletDelegate
- (void)gotoWithDraw{
dispatch_async(dispatch_get_main_queue(), ^{
    NSTextAlignment frameCheckDisabledm0 = NSTextAlignmentCenter; 
        UITableViewStyle withVideosDataM8 = UITableViewStylePlain; 
    PGFriendsViewModel *deleteTweetSucc= [[PGFriendsViewModel alloc] init];
[deleteTweetSucc customAnimateTransitionWitharticleCommentData:frameCheckDisabledm0 tweetItemData:withVideosDataM8 ];
});
    NSLog(@"提现");
    PGMeIsOnGowithViewController *isOnGowith = [[PGMeIsOnGowithViewController alloc]init];
    isOnGowith.allMoney = [NSString stringWithFormat:@"%.2f",[_datadic[@"Balance"] floatValue]];
    isOnGowith.factorageRate = [_userDic[@"factorageRate"] doubleValue];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:isOnGowith animated:YES];
}
- (void)showDetail{
    PGMeDetailWithDrawViewController *detail = [[PGMeDetailWithDrawViewController alloc]init];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:detail animated:YES];
}
- (void)gotoAuth {
    PGMeAuthViewController *auth  = [[PGMeAuthViewController alloc]init];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:auth animated:YES];
}
- (void)setPassword{
    ZD_WeakSelf
    if (![[NSUserDefaults standardUserDefaults]boolForKey:@"Authentication"]) {
        [PGAlertView alertWithTitle:@"操作提醒" message:@"请先完成实名认证再添加提现账号" sureBlock:^{
            PGMeAuthViewController *auth  = [[PGMeAuthViewController alloc]init];
            [weakSelf setHidesBottomBarWhenPushed:YES];
            [weakSelf.navigationController pushViewController:auth animated:YES];
        } cancelBlock:^{
        }];
    }else{
        [self auth];
    }
}
- (void)auth {
    NSDictionary *authdic = [NSDictionary dictionaryWithContentsOfFile:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"auth.plist"]];
    if ([authdic[@"status"] integerValue]!=1) {
        PGMeAuthViewController *auth  = [[PGMeAuthViewController alloc]init];
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:auth animated:YES];
        auth.authdic = authdic;
    }else{
        [self PG_setOrChangePassword];
    }
}
-(void)normalQuestion{
    NSString *str = @"请关注准到官方微信公众号（微信号izhundao），发送关键词“钱包”了解相关功能说明！";
    PGAlertView *alert =  [PGAlertView alertWithTitle:@"常见问题" message:str cancelBlock:^{
    }];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:str];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue" size:15] range:NSMakeRange(0, attributedString.length)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:ZDMainColor range:[str rangeOfString:@"izhundao"]];
    [attributedString addAttribute:NSForegroundColorAttributeName value:ZDMainColor range:[str rangeOfString:@"短信"]];
    alert.messageAttributedString = attributedString;
}
-(void)popBack{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark --- 密码逻辑
- (void)PG_setOrChangePassword{
    BOOL isPassWord = NO;
    if (_userDic[@"hasPayPassWord"]) {
        isPassWord = NO;
    }else{
        isPassWord = YES;
    }
    if (isPassWord) {
        PGAlertSheet *sheet1 = [[PGAlertSheet alloc]initWithFrame:[UIScreen mainScreen].bounds array:@[@"修改支付密码",@"找回支付密码"] title:nil isDelete:NO selectBlock:^(NSInteger index) {
            if (index ==0) {
                PGBaseWebViewVC *web = [[PGBaseWebViewVC alloc] init];
                web.webTitle = @"修改支付密码";
                web.urlString = [NSString stringWithFormat:@"https://m.zhundao.net/Activity/UpdatePwd?token=%@",[[PGSignManager shareManager] getToken]];
                [self setHidesBottomBarWhenPushed:YES];
                [self.navigationController pushViewController:web animated:YES];
            }if (index==1) {
                [self PG_pushCtr];
            }
        }];
        [self.view addSubview:sheet1];
        [sheet1 fadeIn];
    }else{
        PGAlertSheet *sheet1 = [[PGAlertSheet alloc]initWithFrame:[UIScreen mainScreen].bounds array:@[@"设置支付密码"] title:@"未设置支付密码，请先设置支付密码" isDelete:NO selectBlock:^(NSInteger index) {
            [self PG_pushCtr];
        }];
        [self.view addSubview:sheet1];
        [sheet1 fadeIn];
    }
}
- (void)PG_pushCtr{
    PGBaseWebViewVC *web = [[PGBaseWebViewVC alloc] init];
    web.webTitle = @"找回支付密码";
    web.urlString = [NSString stringWithFormat:@"https://m.zhundao.net/Activity/GetPassWord?token=%@",[[PGSignManager shareManager] getToken]];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:web animated:YES];
}
#pragma mark ------ 右边导航栏
- (void)rightNav
{
    PGMeDetailMoneyViewController *detailCtrl = [[PGMeDetailMoneyViewController alloc]init];
    detailCtrl.urlString = [NSString stringWithFormat:@"%@Activity/WalletLog?accesskey=%@",zhundaoH5Api,[[PGSignManager shareManager] getaccseekey]];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:detailCtrl animated:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self firstLoad];
}
-(void)dealloc{
    NSLog(@"没有内存泄露");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
