#import "PGTrainParticularProperty.h"
//
//  PGDiscoverPromoteTabbarVC.m
//  zhundao
//
//  Created by maj on 2020/1/6.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "PGMePromoteTabbarVC.h"

#import "PGBaseNavVC.h"
#import "PGMePromoteCustomContactVC.h"
#import "PGMePromoteShareVC.h"

@interface PGMePromoteTabbarVC ()

@end

@implementation PGMePromoteTabbarVC

- (instancetype)init {
    if (self = [super init]) {
        [self createSubControllers];
        [self addCustomTabbar];
        
    }
    return self;
}

- (void)viewDidLoad {
dispatch_async(dispatch_get_main_queue(), ^{
    UITextFieldViewMode collectionViewDataj1 = UITextFieldViewModeAlways; 
        UITableViewStyle browserPhotoScrollj6 = UITableViewStylePlain; 
    PGTrainParticularProperty *regularExpressionCase= [[PGTrainParticularProperty alloc] init];
[regularExpressionCase pg_scrollViewDecelerationWithfromVideoFile:collectionViewDataj1 separatorStyleNone:browserPhotoScrollj6 ];
});
    [super viewDidLoad];
    
    self.tabBar.translucent = NO;
}

#pragma mark --- custom
- (void)createSubControllers {
    PGBaseNavVC *mainVC = [[PGBaseNavVC alloc] initWithRootViewController:[PGMePromoteCustomContactVC new]];
    PGBaseNavVC *shareVC = [[PGBaseNavVC alloc] initWithRootViewController:[PGMePromoteShareVC new]];
    self.viewControllers = @[mainVC, shareVC];
    [self addCustomTabbar];
}
// 添加自定义tabbar
- (void)addCustomTabbar {
    // 添加自定义按钮
    CGFloat buttonWidth = ZD_ScreenWidth / 2;
    //,@"img_tabbar_friend_normal"
    NSArray *normalImageArray = @[@"img_me_promote_main_normal",@"img_me_promote_share_normal"];
    //@"img_tabbar_friend_highlighted",
    NSArray *selectImageArray = @[@"img_me_promote_main_select",@"img_me_promote_share_select"];
    //WYLocalString(@"friend_title"),
    NSArray *titleArray = @[@"首页", @"分享"];
    for (int i = 0; i < 2; i++) {
        UIButton *button = [UIButton buttonWithFrame:CGRectMake(i * buttonWidth , 0, buttonWidth, 49) normalImage:[UIImage imageNamed:normalImageArray[i]] selectedImage:[UIImage imageNamed:selectImageArray[i]] target:self action:nil];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        button.titleLabel.font = PGMediumFont(14);
        button.selected = i == 0;
        button.tag = 100 + i;
        button.imageView.tag = 1000 + i;
        button.userInteractionEnabled = NO;
        [button setTitleColor:ZDBlackColor forState:UIControlStateNormal];
        [self.tabBar addSubview:button];
        self.selectedIndex = 0;
    }
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSInteger currentSelect = [tabBar.items indexOfObject:item];
    //4
    for (int i = 0; i < 2; i++) {
        UIButton *button = (UIButton *)[tabBar viewWithTag:100 + i];
        button.selected = i == currentSelect;
    }
}

@end
