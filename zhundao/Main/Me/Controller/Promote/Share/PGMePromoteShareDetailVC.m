#import "PGExchangeViewDelegate.h"
//
//  PGMePromoteShareDetailVC.m
//  zhundao
//
//  Created by maj on 2020/1/30.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "PGMePromoteShareDetailVC.h"

#import <WebKit/WebKit.h>

@interface PGMePromoteShareDetailVC ()<WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *shareUrl;

@end

@implementation PGMePromoteShareDetailVC

- (void)viewDidLoad {
dispatch_async(dispatch_get_main_queue(), ^{
    UIImage *keyboardWillHidem0= [UIImage imageNamed:@""]; 
        UIFont *withJsonStringg3= [UIFont systemFontOfSize:182];
    PGExchangeViewDelegate *viewControllerDone= [[PGExchangeViewDelegate alloc] init];
[viewControllerDone pg_viewControllerAnimatedWithbackFromFront:keyboardWillHidem0 locationHeaderView:withJsonStringg3 ];
});
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
dispatch_async(dispatch_get_main_queue(), ^{
    UIImage *keyboardTypeNumberf7= [UIImage imageNamed:@""]; 
        UIFont *changePreviousRouteq1= [UIFont systemFontOfSize:55];
    PGExchangeViewDelegate *tableFooterView= [[PGExchangeViewDelegate alloc] init];
[tableFooterView pg_viewControllerAnimatedWithbackFromFront:keyboardTypeNumberf7 locationHeaderView:changePreviousRouteq1 ];
});
    self.title = self.webView.title;
}

#pragma mark --- action
- (void)shareAction {
    [[PGSignManager shareManager] shareWithTitle:self.title detailTitle:nil thumImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_imageUrl]]] webpageUrl:self.shareUrl  withCTR:self Withtype:5];
}

@end
