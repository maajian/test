//
//  detailActivityViewController.m
//  zhundao
//
//  Created by zhundao on 2017/1/5.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "detailActivityViewController.h"
#import "ShareView.h"
#import "UIView+TYAlertView.h"
@interface detailActivityViewController ()<WKNavigationDelegate,UIScrollViewDelegate>

@end

@implementation detailActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"活动详情";
    
    WKWebView *webview = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
    webview.navigationDelegate = self;
    webview.scrollView.delegate = self;
    [self.view addSubview:webview];
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    self.webView =webview;
    [self createRightItem];
    // Do any additional setup after loading the view.
}
- (void)createRightItem
{
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0,25, 25)];
    [rightButton setImage:[UIImage imageNamed:@"detailShare"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(presentAlert) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = item1;
}
- (void)presentAlert
{
    ShareView *shareView = [ShareView createViewFromNib];
    shareView.model = self.model;
    // use UIView Category
    [shareView showInWindow];
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
