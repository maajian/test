//
//  MainViewController.m
//  zhundao
//
//  Created by zhundao on 2016/12/1.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import "MainViewController.h"

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
        [self createCustomTabBar];
        [self createSubControllers];
     
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.translucent = NO;
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    for (UIView *subView in self.tabBar.subviews) {
        Class buttonClass = NSClassFromString(@"UITabBarButton");
        if ([subView isKindOfClass:buttonClass]) {
            [subView removeFromSuperview];
        }
    }
     [self.selectedViewController beginAppearanceTransition: YES animated: animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)createSubControllers
{
    NSArray *storyboardNames = @[@"Activity",@"Signin",@"Me"];
    NSMutableArray *Marray = [[NSMutableArray alloc]init];
    for (NSString *sbName in storyboardNames) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:sbName bundle:nil];
        UINavigationController *nav = [sb instantiateInitialViewController];
        [Marray addObject:nav];
    }
    self.viewControllers = [Marray copy];
}
- (void)createCustomTabBar
{

    
    CGFloat buttonWidth = kScreenWidth/3;
    NSArray *imageArray = @[@"activity",@"loginin",@"me"];
    NSArray *titleArray = @[@"活动",@"签到",@"我"];
    for (int i=0; i<3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*buttonWidth, 0, buttonWidth, 49);
        
        
//        [button setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents: UIControlEventTouchUpInside ];
        button.tag = 100+i;
        [self.tabBar addSubview:button];
        UIImageView *imageview = [[UIImageView alloc]init];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 35 , buttonWidth,  12)];

           imageview.image = [UIImage imageNamed:imageArray[i]];
            label.textColor = [UIColor lightGrayColor];

        imageview.frame = CGRectMake(buttonWidth/2-10, 10, 20, 20);
        
        [button addSubview:imageview];
        
        
        
        label.text = titleArray[i];
        label.font = [UIFont systemFontOfSize:13];
        
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
    
    NSArray *imageArray = @[@"activity",@"loginin",@"me"];
        NSArray *imagedarray = @[@"activityed",@"logined",@"meed"];
    
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


-(void) viewDidAppear:(BOOL)animated
{    [super viewDidAppear:animated];
    [self.selectedViewController endAppearanceTransition];
}

-(void) viewWillDisappear:(BOOL)animated
{    [super viewWillDisappear:animated];
    [self.selectedViewController beginAppearanceTransition: NO animated: animated];
}

-(void) viewDidDisappear:(BOOL)animated
{   [super viewDidDisappear:animated];
    [self.selectedViewController endAppearanceTransition];
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
