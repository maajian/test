#import "PGEdgeInsetsInset.h"
//
//  PGMeDetailMoneyViewController.m
//  zhundao
//
//  Created by zhundao on 2017/8/7.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PGMeDetailMoneyViewController.h"

@interface PGMeDetailMoneyViewController ()<WKNavigationDelegate>

@end

@implementation PGMeDetailMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"明细";
    WKWebView *webview = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
    webview.navigationDelegate = self;
    [self.view addSubview:webview];
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    self.webView =webview;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

*/

@end
