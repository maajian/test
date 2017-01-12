//
//  SuggestViewController.m
//  zhundao
//
//  Created by zhundao on 2016/12/27.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import "SuggestViewController.h"
#import <WebKit/WebKit.h>
@interface SuggestViewController ()<WKNavigationDelegate,UIScrollViewDelegate>

@end

@implementation SuggestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"通讯录";
    WKWebView *webview = [[WKWebView alloc]initWithFrame:self.view.bounds];
    webview.navigationDelegate = self;
    webview.scrollView.delegate = self;
    [self.view addSubview:webview];
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    self.webView =webview;
    
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
