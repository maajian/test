//
//  sendMessageDetailViewController.m
//  zhundao
//
//  Created by zhundao on 2017/11/10.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "sendMessageDetailViewController.h"

@interface sendMessageDetailViewController ()<WKNavigationDelegate>

@end

@implementation sendMessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"发送记录";
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
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
