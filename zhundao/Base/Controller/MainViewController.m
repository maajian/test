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
#import "ZDMessageMainDetailVC.h"
#import "ZDMessageMainVC.h"
#import "ListViewController.h"

@interface MainViewController ()
{
    NSInteger flag;
}
@property(nonatomic,strong)UIButton *startButton;
@property(nonatomic,strong)UILabel *startLabel;
@property(nonatomic,strong)UIImageView *startIamgeView;

@end

@implementation MainViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createSubControllers];
        [self createCustomTabBar];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushNotification:) name:ZDNotification_Push object:nil];
        [ZD_NotificationCenter addObserver:self selector:@selector(updateRedDot) name:ZDNotification_UnreadMessageChange object:nil];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.translucent = NO;
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    NSArray *imageArray = @[@"tabbar_activity",@"tabbar_message",@"tabbar_discover",@"tabbar_me"];
    NSArray *imagedarray = @[@"tabbar_activity_select",@"tabbar_message_select",@"tabbar_discover_select",@"tabbar_me_select"];
    NSArray *titleArray = @[@"活动",@"消息",@"发现",@"我的"];
    for (int i = 0; i < 4; i++) {
        UIButton *button = [UIButton buttonWithFrame:CGRectMake(i * buttonWidth , 0, kScreenWidth / 4, 49) normalImage:[UIImage imageNamed:imageArray[i]] selectedImage:[UIImage imageNamed:imagedarray[i]] target:self action:@selector(buttonAction:)];
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

#pragma mark --- 通知接收
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
- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    super.selectedIndex = selectedIndex;
    //4
    for (int i = 0; i < 4; i++) {
        UIButton *button = (UIButton *)[self.tabBar viewWithTag:100 + i];
        button.selected = i == selectedIndex;
    }
}

#pragma mark --- action
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
            [[self.tabBar viewWithTag:101] pp_moveBadgeWithX:- kScreenWidth /8 + 10 Y:12];
        }else {
            [[self.tabBar viewWithTag:101] pp_moveBadgeWithX:- kScreenWidth /8 + 10 Y:12];
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
