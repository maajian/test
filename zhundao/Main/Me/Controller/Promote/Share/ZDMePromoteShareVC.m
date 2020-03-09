//
//  ZDDiscoverPromoteShareVC.m
//  zhundao
//
//  Created by maj on 2020/1/6.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "ZDMePromoteShareVC.h"
#import "ZDMePromoteShareDetailVC.h"

#import <WebKit/WebKit.h>

@interface ZDMePromoteShareVC ()<WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) NSString *urlString;

@end

@implementation ZDMePromoteShareVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.urlString = [NSString stringWithFormat:@"https://www.zhundao.net/spread/%li", (long)ZD_UserM.userID];
    [self initSet];
    [self initLayout];
}


#pragma mark --- Init
- (void)initSet {
    self.webView = [[WKWebView alloc] init];
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
}
- (void)initLayout {
    self.webView.frame = CGRectMake(0.0, 0.0, self.view.bounds.size.width, self.view.bounds.size.height - ZD_TopBar_H);
}

#pragma mark --- WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    // 如果是跳转一个新页面
    if (![navigationAction.request.URL.absoluteString isEqualToString:self.urlString]) {
        ZDMePromoteShareDetailVC *detail = [[ZDMePromoteShareDetailVC alloc] init];
        detail.urlString = navigationAction.request.URL.absoluteString;
        [self.navigationController pushViewController:detail animated:YES];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}


@end
