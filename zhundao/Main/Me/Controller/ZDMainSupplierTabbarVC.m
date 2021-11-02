//
//  ZDDiscoverPromoteTabbarVC.m
//  zhundao
//
//  Created by maj on 2020/1/6.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "ZDMainSupplierTabbarVC.h"

#import "BaseNavigationViewController.h"
#import "ZDSupplierMainVC.h"
#import "ZDMessageMainVC.h"
#import "ZDSupplierMeVC.h"
#import "ZDPartnerMeVC.h"

@interface ZDMainSupplierTabbarVC ()

@end

@implementation ZDMainSupplierTabbarVC

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init {
    if (self = [super init]) {
        [self createSubControllers];
        [self addCustomTabbar];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.translucent = NO;
    self.view.backgroundColor = ZDBackgroundColor;
    [ZD_NotificationCenter addObserver:self selector:@selector(popAction) name:@"ZDMainSupplierTabbarPop" object:nil];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark --- custom
- (void)createSubControllers {
    BaseNavigationViewController *mainVC = [[BaseNavigationViewController alloc] initWithRootViewController:[ZDSupplierMainVC new]];
    BaseNavigationViewController *messageVC = [[BaseNavigationViewController alloc] initWithRootViewController:[ZDMessageMainVC new]];
    BaseNavigationViewController *meVC = [[BaseNavigationViewController alloc] initWithRootViewController:[ZDSupplierMeVC new]];
    BaseNavigationViewController *partnerMeVC = [[BaseNavigationViewController alloc] initWithRootViewController:[[ZDPartnerMeVC alloc] init]];
    if (ZD_UserM.identifierType == ZDIdentifierTypePartner) {
        self.viewControllers = @[mainVC, messageVC, partnerMeVC];
    } else {
        self.viewControllers = @[mainVC, messageVC, meVC];
    }
}
// 添加自定义tabbar
- (void)addCustomTabbar {
    for (UIView *subView in self.tabBar.subviews) {
       Class buttonClass = NSClassFromString(@"UITabBarButton");
       if ([subView isKindOfClass:buttonClass]) {
           [subView removeFromSuperview];
       }
   }
    
    //,@"img_tabbar_friend_normal"
    NSArray *normalImageArray = @[@"tabbar_activity",@"tabbar_message",@"tabbar_me"];
    NSArray *selectImageArray = @[@"tabbar_activity_select",@"tabbar_message_select",@"tabbar_me_select"];
    NSArray *titleArray = @[@"首页",@"消息",@"我"];
    // 添加自定义按钮
    CGFloat buttonWidth = ZD_ScreenWidth / titleArray.count;
    for (int i = 0; i < titleArray.count; i++) {
        UIButton *button = [UIButton buttonWithFrame:CGRectMake(i * buttonWidth , 0, kScreenWidth / titleArray.count, 49) normalImage:[UIImage imageNamed:normalImageArray[i]] selectedImage:[UIImage imageNamed:selectImageArray[i]] target:self action:@selector(buttonAction:)];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:ZDGreenColor forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:9];
        button.selected = i == 0;
        button.tag = 100 + i;
        button.imageView.tag = 1000 + i;
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [button setButtonWithButtonInsetType:WYButtonInsetTypeTitleBottom space:4];
        [self.tabBar addSubview:button];
        self.selectedIndex = 0;
    }
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    super.selectedIndex = selectedIndex;
    //4
    for (int i = 0; i < 3; i++) {
        UIButton *button = (UIButton *)[self.tabBar viewWithTag:100 + i];
        button.selected = i == selectedIndex;
    }
}

#pragma mark --- action
- (void)popAction {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)buttonAction:(UIButton *)button {
    NSInteger tag = button.tag - 100;
    self.selectedIndex = tag;
}

@end
