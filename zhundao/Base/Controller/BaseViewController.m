//
//  BaseViewController.m
//  zhundao
//
//  Created by zhundao on 2016/12/1.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import "BaseViewController.h"
#import "UIImageView+nullData.h"
#import "UILabel+nullDataLabel.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ZDBackgroundColor;
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        [UITableView appearance].estimatedRowHeight = 0;
        [UITableView appearance].estimatedSectionHeaderHeight = 0;
        [UITableView appearance].estimatedSectionFooterHeight = 0;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [ZD_NotificationCenter addObserver:self selector:@selector(networkChange:) name:ZDNotification_Network_Change object:nil];
    [ZD_NotificationCenter addObserver:self selector:@selector(logout:) name:ZDNotification_Logout object:nil];
//    if (@available(iOS 13.0, *)) self.overrideUserInterfaceStyle = UIUserInterfaceStyleLight ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)shownull :(NSArray *)nullArray WithText :(NSString *)text WithTextColor :(UIColor *)Color
{
    if (nullArray.count==0&&_nulllabel==nil) {   //么有数据 且不存在label
        _nulllabel = [self showNullLabelWithText:text WithTextColor:Color];
         _nulllabel.numberOfLines = 0;
        _nullimageview =   [self showNullImage];
        [self.view addSubview:_nulllabel];
    }
    if (nullArray.count>0&&_nulllabel!=nil&&_nullimageview!=nil) {// 有数据 存在label
        [_nulllabel removeFromSuperview];
        [_nullimageview removeFromSuperview];
        _nullimageview = nil;
        _nulllabel =nil;
    }
}
- (UIImageView *)showNullImage
{
    UIImageView *nullImageview = [UIImageView initWithFrame:CGRectMake(kScreenWidth/2-60 , kScreenHeight/2-100, 120, 120) imageName:@"空数据-5"];
    [self.view addSubview:nullImageview];
    return nullImageview;
}
- (UILabel *)showNullLabelWithText :(NSString *)text WithTextColor :(UIColor *)WithTextColor
{
    UILabel *label = [UILabel initWithFrame:CGRectMake(kScreenWidth/2-100 , kScreenHeight/2+20, 200, 50) WithText:text WithTextColor:WithTextColor WithFont:[UIFont systemFontOfSize:15] WithtextAlignment:NSTextAlignmentCenter];
    return label;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self removeTab];
}
- (void)removeTab  //移除tab
{
    for (UIView *subView in self.tabBarController.tabBar.subviews) {
        Class buttonClass = NSClassFromString(@"UITabBarButton");
        if ([subView isKindOfClass:buttonClass]) {
            [subView removeFromSuperview];
        }
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

#pragma mark --- notification
- (void)networkChange:(NSNotification *)nofi {
    if (![ZD_KeyWindow containView:[ZDAlertView class]]) {
        [ZDAlertView alertWithTitle:@"提示" message:@"网络超时，是否切换到备用服务器重试？" sureBlock:^{
            [[NSUserDefaults standardUserDefaults] setObject:@"备用线路" forKey:ZDUserDefault_Network_Line];
            [[NSUserDefaults standardUserDefaults] setObject:[NSDate getCurrentDayStr] forKey:ZDUserDefault_First_Network];
            [[NSUserDefaults standardUserDefaults] synchronize];
        } cancelBlock:nil];
    }
}
- (void)logout:(NSNotification *)nofi {
    maskLabel *label = [[maskLabel alloc] initWithTitle:@"登录信息已过期，请重新登录"];
    [label labelAnimationWithViewlong:[UIApplication sharedApplication].keyWindow];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [ZD_UserM didLogout];
    });
}

@end
