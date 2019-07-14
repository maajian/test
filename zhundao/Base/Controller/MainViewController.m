//
//  MainViewController.m
//  zhundao
//
//  Created by zhundao on 2016/12/1.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import "MainViewController.h"

#import "LoginViewController.h"
#import "DetailNoticeViewController.h"
#import "BaseNavigationViewController.h"

@interface MainViewController ()
{
    NSInteger flag;
}
@property(nonatomic,strong)UIButton *startButton;
@property(nonatomic,strong)UILabel *startLabel;
@property(nonatomic,strong)UIImageView *startIamgeView;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation MainViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createSubControllers];
        [self createCustomTabBar];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNotification:) name:kAppNotification object:nil];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.translucent = NO;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)createSubControllers
{
    NSArray *storyboardNames = @[@"Activity",@"Signin",@"Discover",@"Me"];
    NSMutableArray *Marray = [[NSMutableArray alloc]init];
    for (NSString *sbName in storyboardNames) {
        UINavigationController *nav= nil;
        UIStoryboard *sb = [UIStoryboard storyboardWithName:sbName bundle:nil];
        nav = [sb instantiateInitialViewController];
        [Marray addObject:nav];
    }
    self.viewControllers = [Marray copy];
}
- (void)createCustomTabBar
{
    for (UIView *subView in self.tabBar.subviews) {
        Class buttonClass = NSClassFromString(@"UITabBarButton");
        if ([subView isKindOfClass:buttonClass]) {
            [subView removeFromSuperview];
        }
    }
    CGFloat buttonWidth = kScreenWidth/4;
    NSArray *imageArray = @[@"activity",@"loginin",@"discover",@"me"];
    NSArray *titleArray = @[@"活动",@"签到",@"发现",@"我"];
    for (int i=0; i<4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*buttonWidth, 0, buttonWidth, 49);
        [button addTarget:self action:@selector(buttonAction:) forControlEvents: UIControlEventTouchUpInside ];
        button.tag = 100+i;
        [self.tabBar addSubview:button];
        UIImageView *imageview = [[UIImageView alloc]init];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 27 , buttonWidth,  12)];
        
           imageview.image = [UIImage imageNamed:imageArray[i]];
            label.textColor = [UIColor lightGrayColor];

        imageview.frame = CGRectMake(buttonWidth/2-10, 2, 20, 20);
        
        [button addSubview:imageview];
        
        
        
        label.text = titleArray[i];
        label.font = [UIFont systemFontOfSize:12];
        
        label.textAlignment = NSTextAlignmentCenter;
     
        
   
        label.tag = 100+i;
        [button addSubview:label];
    
         self.tabBar.shadowImage = [[UIImage alloc] init];
        if (i==0) {
            flag=0;
            _startButton = button;
            _startLabel = label;
            _startLabel.textColor = color1;
            _startIamgeView = imageview;
            _startIamgeView.image = [UIImage imageNamed:@"activityed"];
            [_startButton addSubview:_startLabel];
            [_startButton addSubview:_startIamgeView];
          
        }
    }
}


- (void)buttonAction:(UIButton *)sender{
    self.selectedIndex = sender.tag-100;
    
    
    [MobClick event:@"zhundaoID"];
    
    
    NSArray *imageArray = @[@"activity",@"loginin",@"discover",@"me"];
        NSArray *imagedarray = @[@"activityed",@"logined",@"discovered",@"meed"];
    
    if ([_startButton.subviews[0] isKindOfClass:[UILabel class]]) {
         _startLabel =  (UILabel *)_startButton.subviews[0];
    }
    else{
        _startIamgeView =  (UIImageView *)_startButton.subviews[0];
    }
    if ([_startButton.subviews[1] isKindOfClass:[UILabel class]]) {
        _startLabel =  (UILabel *)_startButton.subviews[1];
    }
    else{
        _startIamgeView =  (UIImageView *)_startButton.subviews[1];
    }
    if (sender!=_startButton) {    //如果切换tabbar
        _startLabel.textColor = [UIColor lightGrayColor];
        _startIamgeView.image = [UIImage imageNamed:imageArray[flag]];
        
        self.startButton.selected = NO;    //startButton 取消选中
        self.startButton = sender;       // 切换button
        if ([_startButton.subviews[0] isKindOfClass:[UILabel class]]) {
            _startLabel =  (UILabel *)_startButton.subviews[0];
        }
        else{
            _startIamgeView =  (UIImageView *)_startButton.subviews[0];
        }
        if ([_startButton.subviews[1] isKindOfClass:[UILabel class]]) {
            _startLabel =  (UILabel *)_startButton.subviews[1];
        }
        else{
            _startIamgeView =  (UIImageView *)_startButton.subviews[1];
        }
      
        flag = self.selectedIndex;
    }
    else{
        self.startButton.selected = YES;    // starbutton 选中
    }
    if (!self.startButton.selected) {
        _startLabel.textColor =color1;
        _startIamgeView.image = [UIImage imageNamed:imagedarray[flag]];
    }
}

#pragma mark --- 定时器
- (void)addTimer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(checklogin) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}

- (void)checklogin {
    NSString *userstr = [NSString stringWithFormat:@"%@api/v2/user/getUserInfo?token=%@",zhundaoApi,[[SignManager shareManager] getToken]];
    [ZD_NetWorkM getDataWithMethod:userstr parameters:nil succ:^(NSDictionary *obj) {
        NSLog(@"responseObject = %@",obj);
        if (![obj[@"data"][@"email"] isEqual:[NSNull null]]) {
            [[NSUserDefaults standardUserDefaults] setObject:obj[@"data"][@"email"] forKey:@"email"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    } fail:^(NSError *error) {
        NSLog(@"code = %li",(long)error.code);
        if (error.code == -1011) {
            maskLabel *label = [[maskLabel alloc] initWithTitle:@"登录超时，请重新登录"];
            [label labelAnimationWithViewlong:[UIApplication sharedApplication].keyWindow];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self didLogout];
            });
        }
    }];
}

/*! 退出登录清空数据 */
- (void)didLogout
{
    /*! 清除本地数据 */
    NSDictionary *userArray = [[NSUserDefaults standardUserDefaults]objectForKey:@"userArray"];
    NSString *appDomain = [[NSBundle mainBundle]bundleIdentifier];
    [[NSUserDefaults standardUserDefaults]removePersistentDomainForName:appDomain];
    [[NSUserDefaults standardUserDefaults] setObject:userArray forKey:@"userArray"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if ([[SignManager shareManager].dataBase open])
    {
        NSString *updateSql = [NSString stringWithFormat:@"DROP TABLE signList"];
        [[SignManager shareManager].dataBase executeUpdate:updateSql];
        NSString *updateSql1 = [NSString stringWithFormat:@"DROP TABLE muliSignList"];
        [[SignManager shareManager].dataBase executeUpdate:updateSql1];
        NSString *updateSql12 = [NSString stringWithFormat:@"DROP TABLE contact"];
        [[SignManager shareManager].dataBase executeUpdate:updateSql12];
        [[SignManager shareManager].dataBase close];
    }
    LoginViewController *login = [[LoginViewController alloc]init];
    [UIApplication sharedApplication].delegate.window.rootViewController = login;
}

#pragma mark --- 通知接收
- (void)getNotification:(NSNotification *)nofi {
    BaseNavigationViewController *baseNav = self.viewControllers[0];
    DetailNoticeViewController *detailNotice = [[DetailNoticeViewController alloc]init];
    detailNotice.ID = [nofi.userInfo[@"id"] integerValue];
    detailNotice.isNotificationPush = YES;
    [detailNotice setHidesBottomBarWhenPushed:YES];
    self.selectedIndex = 0;
    [baseNav pushViewController:detailNotice animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self addTimer];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_timer invalidate];
    _timer = nil;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
