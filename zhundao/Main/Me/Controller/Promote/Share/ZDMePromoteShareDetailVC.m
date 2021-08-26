//
//  ZDMePromoteShareDetailVC.m
//  zhundao
//
//  Created by maj on 2020/1/30.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "ZDMePromoteShareDetailVC.h"

#import <WebKit/WebKit.h>

@interface ZDMePromoteShareDetailVC ()<WKNavigationDelegate, ZDShareViewDelegate>
@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *shareUrl;

@end

@implementation ZDMePromoteShareDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSet];
    [self initLayout];
}

#pragma mark --- Init
- (void)initSet {
    self.webView = [[WKWebView alloc] init];
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem shareItemWithTarget:self action:@selector(shareAction)];
    
    _imageUrl = [self.urlString componentsSeparatedByString:@"?img="].lastObject;
    _shareUrl = [self.urlString componentsSeparatedByString:@"?img="].firstObject;
}
- (void)initLayout {
    self.webView.frame = CGRectMake(0.0, 0.0, self.view.bounds.size.width, self.view.bounds.size.height - 64);
}

#pragma mark --- WKNavigationDelegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    self.title = self.webView.title;
}

#pragma mark --- action
- (void)shareAction {
    [ZDShareView showWithDelegate:self];
}

#pragma mark --- ZDShareViewDelegate
- (void)shareView:(ZDShareView *)shareView didSelectType:(ZDShareType)shareType {
    if (shareType == ZDShareTypeWechat) {
        [[SignManager shareManager] shareWithTitle:self.title detailTitle:nil thumImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_imageUrl]]] webpageUrl:self.shareUrl  withCTR:self Withtype:5 scene:0];
    } else {
        [[SignManager shareManager] shareWithTitle:self.title detailTitle:nil thumImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_imageUrl]]] webpageUrl:self.shareUrl  withCTR:self Withtype:5 scene:1];
    }
}

@end
