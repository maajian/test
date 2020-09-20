#import "PGUserInfoModel.h"
//
//  PGBaseTabbarVC.m
//  zhundao
//
//  Created by zhundao on 2016/12/1.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import "PGBaseTabbarVC.h"

#import "PGLoginMainVC.h"
#import "PGMeDetailNoticeVC.h"
#import "PGBaseNavVC.h"

@interface PGBaseTabbarVC ()
{
    NSInteger flag;
}
@property(nonatomic,strong)UIButton *startButton;
@property(nonatomic,strong)UILabel *startLabel;
@property(nonatomic,strong)UIImageView *startIamgeView;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation PGBaseTabbarVC
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
dispatch_async(dispatch_get_main_queue(), ^{
    UIEdgeInsets particularDescriptionTablec5 = UIEdgeInsetsMake(99,174,122,53); 
        CGPoint imageSourceContainse3 = CGPointZero;
    PGUserInfoModel *chooseCellDelegate= [[PGUserInfoModel alloc] init];
[chooseCellDelegate trainParticularDataWithnaviTitleAppearance:particularDescriptionTablec5 organizationNoticeWith:imageSourceContainse3 ];
});
    [super viewDidLoad];
    self.tabBar.translucent = NO;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
dispatch_async(dispatch_get_main_queue(), ^{
    UIEdgeInsets assetMediaSubtypeD9 = UIEdgeInsetsMake(225,203,197,187); 
        CGPoint pickerViewShows3 = CGPointZero;
    PGUserInfoModel *pickerColletionView= [[PGUserInfoModel alloc] init];
[pickerColletionView trainParticularDataWithnaviTitleAppearance:assetMediaSubtypeD9 organizationNoticeWith:pickerViewShows3 ];
});
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)createSubControllers
{
    NSArray *storyboardNames;
    if (ZD_UserM.isAdmin) {
        storyboardNames = @[@"PGActivity",@"PGSign",@"PGDiscover",@"PGMe"];
    } else {
        storyboardNames = @[@"PGActivity",@"PGMe"];
    }
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
    NSArray *imageArray;
    NSArray *titleArray;
    if (ZD_UserM.isAdmin) {
        imageArray = @[@"home_tab_act_normal",@"home_tab_sign_normal",@"home_tab_find_normal",@"home_tab_mine_normal"];
        titleArray = @[@"活动",@"签到",@"发现",@"我的"];
    } else {
        imageArray = @[@"home_tab_act_normal",@"home_tab_mine_normal"];
        titleArray = @[@"首页",@"我的"];
    }
    CGFloat buttonWidth = kScreenWidth/ imageArray.count;

    for (int i=0; i<imageArray.count; i++) {
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
            _startLabel.textColor = ZDMainColor;
            _startIamgeView = imageview;
            _startIamgeView.image = [UIImage imageNamed:@"home_tab_act_pressed"];
            [_startButton addSubview:_startLabel];
            [_startButton addSubview:_startIamgeView];
          
        }
    }
}


- (void)buttonAction:(UIButton *)sender{
    self.selectedIndex = sender.tag-100;
    
    NSArray *imageArray;
    NSArray *imagedarray;
    if (ZD_UserM.isAdmin) {
        imageArray = @[@"home_tab_act_normal",@"home_tab_sign_normal",@"home_tab_find_normal",@"home_tab_mine_normal"];
        imagedarray = @[@"home_tab_act_pressed",@"home_tab_sign_pressed",@"home_tab_find_pressed",@"home_tab_mine_pressed"];
    } else {
        imageArray = @[@"home_tab_act_normal",@"home_tab_mine_normal"];
        imagedarray = @[@"home_tab_act_pressed",@"home_tab_mine_pressed"];
    }
    
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
        _startLabel.textColor = ZDMainColor;
        _startIamgeView.image = [UIImage imageNamed:imagedarray[flag]];
    }
}

#pragma mark --- 通知接收
- (void)getNotification:(NSNotification *)nofi {
    PGBaseNavVC *baseNav = self.viewControllers[0];
    PGMeDetailNoticeVC *detailNotice = [[PGMeDetailNoticeVC alloc]init];
    detailNotice.ID = [nofi.userInfo[@"id"] integerValue];
    detailNotice.isNotificationPush = YES;
    [detailNotice setHidesBottomBarWhenPushed:YES];
    self.selectedIndex = 0;
    [baseNav pushViewController:detailNotice animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_timer invalidate];
    _timer = nil;
}

- (void)dealloc {
dispatch_async(dispatch_get_main_queue(), ^{
    UIEdgeInsets effectThumbImageJ6 = UIEdgeInsetsZero;
        CGPoint startProvisionalNavigationV6 = CGPointMake(8,70); 
    PGUserInfoModel *assetPropertyAsset= [[PGUserInfoModel alloc] init];
[assetPropertyAsset trainParticularDataWithnaviTitleAppearance:effectThumbImageJ6 organizationNoticeWith:startProvisionalNavigationV6 ];
});
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

*/

@end
