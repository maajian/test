//
//  PGBaseNavVC.m
//  zhundao
//
//  Created by zhundao on 2016/12/1.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import "PGBaseNavVC.h"

@interface PGBaseNavVC ()<UINavigationControllerDelegate>

@end

@implementation PGBaseNavVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:18],
                                 NSForegroundColorAttributeName : [UIColor blackColor]};
    self.navigationBar.titleTextAttributes = attributes;
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    //将导航栏设置为不透明  会影响每一个视图的布局
    self.navigationBar.translucent = NO;
    self.navigationBar.tintColor = [UIColor blackColor];
    self.navigationBar.barTintColor = ZDBackgroundColor;
    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
