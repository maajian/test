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

#import "LoginViewController.h"
#import "DetailNoticeViewController.h"
#import "BaseNavigationViewController.h"
#import "ZDMessageMainDetailVC.h"
#import "ZDMessageMainVC.h"
#import "ListViewController.h"

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushNotification:) name:ZDNotification_Push object:nil];
    [ZD_NotificationCenter addObserver:self selector:@selector(updateRedDot) name:ZDNotification_UnreadMessageChange object:nil];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (ZD_UserM.loginExpired) {
            [ZD_NotificationCenter postNotificationName:ZDNotification_Logout object:nil];
        }
    });
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
    NSArray *titleArray = @[@"首页",@"消息",@"我的"];
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
- (void)pushNotification:(NSNotification *)nofi {
    self.selectedIndex = 1;
    if (![[SignManager shareManager] getToken].length) {
        return;
    }
    if (nofi.object) {
        NSDictionary *dic = nofi.object;
        NSInteger click_type = [dic[@"click_type"] integerValue];
        if (click_type == 103) {
            NSInteger detailID = [dic[@"param"] integerValue];
            [self networkForMessageDetail:detailID];
        } else if (click_type == 104) {
            NSInteger ActivityID = [dic[@"param"] integerValue];
            [self networkForActivityListDetail:ActivityID];
        } else if (click_type == 105 || click_type == 106 || click_type == 100) {
            NSString *url = [dic[@"url"] stringByReplacingOccurrencesOfString:@"[token]" withString:[[SignManager shareManager] getToken]];
            ZDWebViewController *web = [[ZDWebViewController alloc] init];
            web.urlString = url;
            web.isClose = YES;
            [self.selectedViewController pushViewController:web animated:YES];
        }
    }
}

- (void)buttonAction:(UIButton *)button {
    NSInteger tag = button.tag - 100;
    self.selectedIndex = tag;
}
- (void)updateRedDot {
    if (!ZD_UserM.unreadMessage) {
        [[self.tabBar viewWithTag:101] pp_hiddenBadge];
    } else {
        [[self.tabBar viewWithTag:101] pp_addBadgeWithNumber:ZD_UserM.unreadMessage];
        UIDeviceOrientation orientation  = [[[UIDevice currentDevice] valueForKey:@"orientation"] integerValue];
        if(orientation == UIDeviceOrientationLandscapeLeft ||
           orientation == UIDeviceOrientationLandscapeRight){
            [[self.tabBar viewWithTag:101] pp_moveBadgeWithX:- kScreenWidth /6 + 10 Y:12];
        }else {
            [[self.tabBar viewWithTag:101] pp_moveBadgeWithX:- kScreenWidth /6 + 10 Y:12];
        }
    }
}

#pragma mark --- Network
- (void)networkForMessageDetail:(NSInteger)detailID {
    NSString *url = [NSString stringWithFormat:@"%@jinTaData?token=%@", zhundaoLogApi, [[SignManager shareManager] getToken]];
    NSDictionary *dic = @{@"BusinessCode": @"GetMessageDetailForApp",
                          @"Data" : @{
                                  @"id":@(detailID),
                         }
    };
    [ZD_NetWorkM postDataWithMethod:url parameters:dic succ:^(NSDictionary *obj) {
        if ([obj[@"res"] boolValue]) {
            ZDMessageMainModel *model = [ZDMessageMainModel yy_modelWithJSON:obj[@"data"]];
            ZDMessageMainDetailVC *detail = [[ZDMessageMainDetailVC alloc] init];
            detail.model = model;
            [self.selectedViewController pushViewController:detail animated:YES];
        } else {
//            ZD_HUD_SHOW_ERROR_STATUS(obj[@"errmsg"])
        }
    } fail:^(NSError *error) {
//        ZD_HUD_SHOW_ERROR_STATUS(@"qi")
    }];
}
- (void)networkForActivityListDetail:(NSInteger)activityID {
    NSString *url = [NSString stringWithFormat:@"%@api/v2/getSingleActivityForUser?activityId=%li&token=%@",zhundaoApi,(long)activityID,[[SignManager shareManager] getToken]];
    [ZD_NetWorkM getDataWithMethod:url parameters:nil succ:^(NSDictionary *obj) {
        if ([obj[@"res"] boolValue]) {
            ActivityModel *model = [ActivityModel yy_modelWithDictionary:obj[@"data"]];
            ZDActivityConfigModel *configModel = [ZDActivityConfigModel yy_modelWithJSON:model.Config];
            model.configModel = configModel;
            ListViewController *list = [[ListViewController alloc]init];
            list.activityModel = model;
            [self.selectedViewController pushViewController:list animated:YES];
        } else {
            ZD_HUD_SHOW_ERROR_STATUS(obj[@"errmsg"]);
        }
    } fail:^(NSError *error) {
        ZD_HUD_SHOW_ERROR_STATUS(@"请检查网络设置")
    }];
}


@end
