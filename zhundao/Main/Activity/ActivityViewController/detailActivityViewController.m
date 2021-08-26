//
//  detailActivityViewController.m
//  zhundao
//
//  Created by zhundao on 2017/1/5.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "detailActivityViewController.h"
//#import <UShareUI/UShareUI.h>
#import "WXApi.h"
@interface detailActivityViewController ()<WKNavigationDelegate, ZDShareViewDelegate>

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
    [ZDShareView showWithDelegate:self];
}

#pragma mark --- ZDShareViewDelegate
- (void)shareView:(ZDShareView *)shareView didSelectType:(ZDShareType)shareType {
    if (shareType == ZDShareTypeWechat) {
        [[SignManager shareManager]shareImagewithModel:_model withCTR:self Withtype:5 withImage:nil scene:0];
    } else {
        [[SignManager shareManager]shareImagewithModel:_model withCTR:self Withtype:5 withImage:nil scene:1];
    }
}

@end
