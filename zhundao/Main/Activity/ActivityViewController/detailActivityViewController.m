//
//  detailActivityViewController.m
//  zhundao
//
//  Created by zhundao on 2017/1/5.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "detailActivityViewController.h"
#import <UShareUI/UShareUI.h>
#import "WXApi.h"
@interface detailActivityViewController ()<WKNavigationDelegate>

@end

@implementation detailActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"活动详情";
    
    WKWebView *webview = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
    webview.navigationDelegate = self;
    [self.view addSubview:webview];
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    self.webView =webview;
    [self createRightItem];
    // Do any additional setup after loading the view.
}
- (void)createRightItem
{
    [UIButton initCreateButtonWithFrame:CGRectMake(0, 0, 25, 25) WithImageName:@"detailShare" Withtarget:self Selector:@selector(shareImage)];
}

- (void)shareImage
{
  
    [[SignManager shareManager]shareImagewithModel:_model withCTR:self Withtype:5 withImage:nil];
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
