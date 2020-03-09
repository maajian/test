//
//  ZDWebViewController.m
//  zhundao
//
//  Created by 罗程勇 on 2018/6/27.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import "ZDWebViewController.h"

@interface ZDWebViewController ()<WKNavigationDelegate>

@end

@implementation ZDWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.webTitle;
    [self addOwnViews];
    [self relayoutFrameOfSubViews];
    [self addBackButton];
    
    // 手势返回设置
    [_webView setAllowsBackForwardNavigationGestures:true];
}

// 视图添加
- (void)addOwnViews {
    self.webView = [[WKWebView alloc] init];
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
//    [self addBackButton];
}

// 位置计算
- (void)relayoutFrameOfSubViews {
    self.webView.frame = CGRectMake(0.0, 0.0, self.view.bounds.size.width, self.view.bounds.size.height - 64);
}

#pragma mark --- WKNavigationDelegate
/**
 页面开始加载时调用
 
 @param webView <#webView description#>
 @param navigation <#navigation description#>
 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    if (!_indicator) {
        _indicator = [[JQIndicatorView alloc]initWithType:3 tintColor: [UIColor colorWithRed:9.00f/255.0f green:187.00f/255.0f blue:7.00f/255.0f alpha:1] size:CGSizeMake(90, 70)];
        _indicator.center = self.view.center;
        [self.view addSubview:_indicator];
        [_indicator startAnimating];
    }
}

/**
 <#Description#>
 
 @param webView <#webView description#>
 @param navigation <#navigation description#>
 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [_indicator stopAnimating];
    NSString *titleStr = self.title;
    if (!titleStr.length) {
        self.title = self.webView.title;
    }
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    // 如果是跳转一个新页面
    if (navigationAction.targetFrame == nil) {
        [webView loadRequest:navigationAction.request];
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

#pragma mark --- 返回按钮

#pragma mark --- 返回按钮
- (void)addBackButton {
    // 返回一层
    UIView *popOneView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
    UIButton *popOneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    popOneButton.frame = CGRectMake(0, 0, 20, 20);
    [popOneButton setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [popOneButton addTarget:self action:@selector(popOne) forControlEvents:(UIControlEventTouchUpInside)];
    UILabel *backLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 0, 35, 20)];
    backLabel.text = @"返回";
    backLabel.textColor = [UIColor blackColor];
    backLabel.font = [UIFont systemFontOfSize:17];
    backLabel.textAlignment = NSTextAlignmentCenter;
    [backLabel addTapGestureTarget:self action:@selector(popOne)];
    [popOneView addSubview:popOneButton];
    [popOneView addSubview:backLabel];
    UIBarButtonItem *popOneItem = [[UIBarButtonItem alloc]initWithCustomView:popOneView];
    self.navigationItem.leftBarButtonItem = popOneItem;
    
    if (_isClose) {
        UIView *popCloseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
        UIButton *popCloseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        popCloseButton.frame = CGRectMake(0, 0, 44, 44);
        [popCloseButton setTitle:@"关闭" forState:UIControlStateNormal];
        [popCloseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        popCloseButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [popCloseButton addTarget:self action:@selector(popClose) forControlEvents:(UIControlEventTouchUpInside)];
        [popCloseView addSubview:popCloseButton];
        
        UIBarButtonItem *popCloseItem = [[UIBarButtonItem alloc]initWithCustomView:popCloseView];
        self.navigationItem.leftBarButtonItems = @[popOneItem, popCloseItem];
    }
}

#pragma mark --- 跳转
// pop一层vc
- (void)popOne {
    if ([_webView canGoBack]) {
        [_webView goBack];
    } else {
        if (self.presentingViewController) {
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

 // 返回主页面
- (void)popClose {
    if (self.presentingViewController) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
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
