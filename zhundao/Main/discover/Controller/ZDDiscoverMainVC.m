//
//  ZDDiscoverMainVC.m
//  zhundao
//
//  Created by zhundao on 2017/1/16.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ZDDiscoverMainVC.h"

#import "ZDDiscoverShakeVC.h"
#import "ZDDiscoverPrintVC.h"
#import "ZDDiscoverFaceVC.h"
#import "ZDDiscoverPriviteInviteVC.h"
#import "ZDDiscoverCustomApplyVC.h"
#import "ZDDiscoverShopDetailVC.h"
#import "ZDDiscoverQuestionVC.h"

@interface ZDDiscoverMainVC ()
@property (strong, nonatomic) IBOutlet UITableView *tableview;
/*! 摇一摇 */
@property (weak, nonatomic) IBOutlet UITableViewCell *shakeCell;
/*! 自定义报名项 */
@property (weak, nonatomic) IBOutlet UITableViewCell *customPushCell;
/*! 打印 */
@property (weak, nonatomic) IBOutlet UITableViewCell *printCell;
/*! 邀请函 */
@property (weak, nonatomic) IBOutlet UITableViewCell *inviteCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *moreApplyCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *storeCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *questionCell;

@end

@implementation ZDDiscoverMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ZDBackgroundColor;
    /*! 添加头视图 */
    _tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f,0.0f, _tableview.bounds.size.width,15.0f)];
    /*! 添加手势 */
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushToCostomVC)];  //添加自定义
    [_customPushCell addGestureRecognizer:tap];
    
    UITapGestureRecognizer *shake = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushToShake)];  //添加摇一摇
    [_shakeCell addGestureRecognizer:shake];

    /*! 打印 */
    UITapGestureRecognizer *print = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushToPrint)];
    [_printCell addGestureRecognizer:print];
    /*! 邀请函 */
    UITapGestureRecognizer *invite = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushToInvite)];
    [_inviteCell addGestureRecognizer:invite];
    
    UITapGestureRecognizer *moreApply = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToMoreApply)];
    [_moreApplyCell addGestureRecognizer:moreApply];
    
    UITapGestureRecognizer *store = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToStore)];
    [_storeCell addGestureRecognizer:store];
    
    UITapGestureRecognizer *question = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToQuestion)];
    [_questionCell addGestureRecognizer:question];
}
#pragma  mark --- 界面跳转

- (void)pushToMoreApply {
    ZDBaseWebViewVC *web = [[ZDBaseWebViewVC alloc] init];
    web.webTitle = @"更多应用";
    web.urlString = @"https://www.zhundao.net/app";
    web.isClose = YES;
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:web animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}

/*! 自定义报名项 */
- (void)pushToCostomVC {
    ZDDiscoverCustomApplyVC *customViewCtr = [[ZDDiscoverCustomApplyVC alloc]init];
//    ZDDiscoverCustomVC *custom = [[ZDDiscoverCustomVC alloc] init];
    [self.navigationController pushViewController:customViewCtr animated:YES];
}

/*! 摇一摇 */
- (void)pushToShake
{
    ZDDiscoverShakeVC *shake = [[ZDDiscoverShakeVC alloc]init];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:shake animated:YES ];
    [self setHidesBottomBarWhenPushed:NO];
}

/*! 打印 */
- (void)pushToPrint {
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"GradeId"]) {
        NSInteger a = [[[NSUserDefaults standardUserDefaults]objectForKey:@"GradeId"]integerValue];
        if (a >=2) {
            ZDDiscoverPrintVC *print = [[ZDDiscoverPrintVC alloc]init];
            [self setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:print animated:YES];
            [self setHidesBottomBarWhenPushed:NO];
        } else {
            ZDMaskLabel *label = [[ZDMaskLabel alloc] initWithTitle:@"该功能仅限V4以上会员使用"];
            [label labelAnimationWithViewlong:self.view];
        }
    }
}

/*! 严选商城 */
- (void)pushToStore {
    ZDDiscoverShopDetailVC *web = [[ZDDiscoverShopDetailVC alloc] init];
    web.urlString = [NSString stringWithFormat:@"https://app.zhundao.net/shop/index.html?token=%@#!/market/",[[ZDSignManager shareManager] getToken]];
    web.isClose = YES;
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:web animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}

- (void)pushToQuestion {
    ZDDiscoverQuestionVC *web = [[ZDDiscoverQuestionVC alloc] init];
    web.urlString = [NSString stringWithFormat:@"https://app.zhundao.net/wenjuan/admin/index.html?token=%@#/",[[ZDSignManager shareManager] getToken]];
    web.isClose = YES;
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:web animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}

- (void)pushToInvite{
    ZDDiscoverPriviteInviteVC *invite = [[ZDDiscoverPriviteInviteVC alloc]init];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:invite animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
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
