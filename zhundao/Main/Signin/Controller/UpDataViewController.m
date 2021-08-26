//
//  UpDataViewController.m
//  zhundao
//
//  Created by zhundao on 2017/3/27.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "UpDataViewController.h"

@interface UpDataViewController ()<WKNavigationDelegate>

@end

@implementation UpDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"会员升级";
    WKWebView *webview = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
    webview.navigationDelegate = self;
    [self.view addSubview:webview];
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    self.webView =webview;
    if (_isPresent) {
        [self addBackItem];
    }
}

- (void)addBackItem {
    // 返回一层
    UIView *popOneView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    UIButton *popOneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    popOneButton.frame = CGRectMake(0, 0, 25, 25);
    [popOneButton setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [popOneButton addTarget:self action:@selector(popOne) forControlEvents:(UIControlEventTouchUpInside)];
    
    [popOneView addSubview:popOneButton];
    UIBarButtonItem *popOneItem = [[UIBarButtonItem alloc]initWithCustomView:popOneView];
    self.navigationItem.leftBarButtonItem = popOneItem;
}

- (void)popOne {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    } else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    //获取请求的url路径.
    NSString *requestString = navigationResponse.response.URL.absoluteString;
    DDLogVerbose(@"requestString:%@",requestString);
    // 遇到要做出改变的字符串
    NSString *subStr = @"usercenter";
    if ([requestString rangeOfString:subStr].location != NSNotFound) {
        DDLogVerbose(@"这个字符串中有usercenter");
        //回调的URL中如果含有百度，就直接返回，也就是关闭了webView界面
        _block(1);
        [self.navigationController  popViewControllerAnimated:YES];
    }
    
    decisionHandler(WKNavigationResponsePolicyAllow);
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
