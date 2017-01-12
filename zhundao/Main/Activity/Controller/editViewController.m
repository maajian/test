//
//  editViewController.m
//  zhundao
//
//  Created by zhundao on 2016/12/19.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import "editViewController.h"
#import <WebKit/WebKit.h>
@interface editViewController ()<WKNavigationDelegate,UIScrollViewDelegate>
{
    JQIndicatorView *indicator;
}
@property (nonatomic, strong) WKWebView * webView;
@end

@implementation editViewController
- (void)dealloc
{
    self.webView.navigationDelegate = nil;
    [self.webView removeFromSuperview];
    self.webView = nil;
    self.webView.scrollView.delegate = nil;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"编辑";
    WKWebView *webview = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
    webview.navigationDelegate = self;
    webview.scrollView.delegate = self;
    [self.view addSubview:webview];
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlString]]];
    self.webView =webview;
    // Do any additional setup after loading the view.
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.webView.scrollView.delegate = nil;
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    indicator = [[JQIndicatorView alloc]initWithType:3 tintColor: [UIColor colorWithRed:9.00f/255.0f green:187.00f/255.0f blue:7.00f/255.0f alpha:1] size:CGSizeMake(90, 70)];
    indicator.center = self.view.center;
    [self.view addSubview:indicator];
    [indicator startAnimating];
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [indicator stopAnimating];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    
//    if (scrollView.contentOffset.y > 100) {
//        self.navigationItem.title = self.webView.title;
//    }else{
//        self.navigationItem.title = nil;
//    }
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
