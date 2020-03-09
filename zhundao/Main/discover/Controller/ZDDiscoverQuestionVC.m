//
//  ZDDiscoverQuestionVC.m
//  zhundao
//
//  Created by maj on 2020/2/14.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "ZDDiscoverQuestionVC.h"

#import <WebKit/WebKit.h>

@interface ZDDiscoverQuestionVC ()

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
    [[SignManager shareManager] shareWithTitle:self.title detailTitle:nil thumImage:[UIImage imageNamed:@"120"] webpageUrl:self.urlString  withCTR:self Withtype:5];
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
    } else {
        self.navigationItem.rightBarButtonItem = nil;
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)popOne {
    [super popOne];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.webView reload];
    });
}

@end
