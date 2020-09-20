//
//  ZDDiscoverQuestionVC.m
//  zhundao
//
//  Created by maj on 2020/2/14.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "ZDDiscoverQuestionVC.h"

#import <WebKit/WebKit.h>

@interface ZDDiscoverQuestionVC () {
    NSString *_shareUrl;
}

@end

@implementation ZDDiscoverQuestionVC

//移除监听
- (void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"title" context:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSet];
    // Do any additional setup after loading the view.
}

#pragma mark --- Init
- (void)initSet {
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
}

#pragma mark --- action
- (void)shareAction {
    [[ZDSignManager shareManager] shareWithTitle:self.title detailTitle:nil thumImage:[UIImage imageNamed:@"120"] webpageUrl:_shareUrl  withCTR:self Withtype:5];
}
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context {
    if ([keyPath isEqualToString:@"title"]) {
        self.title = self.webView.title;
    }
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if ([navigationAction.request.URL.absoluteString containsString:@"wenjuan/index.html?id"]) {
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem shareItemWithTarget:self action:@selector(shareAction)];
        _shareUrl = navigationAction.request.URL.absoluteString;
    } else {
        self.navigationItem.rightBarButtonItem = nil;
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)popOne {
    [super popOne];
    self.navigationItem.rightBarButtonItem = nil;
}

@end
