//
//  ZDDiscoverShopDetailVC.m
//  zhundao
//
//  Created by maj on 2020/2/14.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "ZDDiscoverShopDetailVC.h"

#import <WebKit/WebKit.h>

@interface ZDDiscoverShopDetailVC () {
    NSInteger _productId;
    NSString *_imageUrl;
}

@end

@implementation ZDDiscoverShopDetailVC

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
    [[ZDDataManager shareManager] shareWithTitle:self.title detailTitle:nil thumImage:[[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_imageUrl]]] webpageUrl:self.urlString  withCTR:self Withtype:5];
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
    _productId = 0;
    if ([navigationAction.request.URL.absoluteString containsString:@"market/detail"]) {
        self.urlString = navigationAction.request.URL.absoluteString;
        _productId = ZD_SafeIntValue([navigationAction.request.URL.absoluteString componentsSeparatedByString:@"market/detail/"].lastObject);
    }
    [self networkForShare];
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)popOne {
    [super popOne];
    [self.webView reload];
}

#pragma mark --- Network
- (void)networkForShare {
    if (_productId) {
        NSString *url = [NSString stringWithFormat:@"%@api/v2/shop/getProductDetail?productId=%li",zhundaoApi,_productId];
        [ZD_NetWorkM postDataWithMethod:url parameters:nil succ:^(NSDictionary *obj) {
            if ([obj[@"errcode"] integerValue] == 0) {
                _imageUrl = ZD_SafeStringValue(obj[@"data"][@"HeadImg"]);
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    self.navigationItem.rightBarButtonItem = [UIBarButtonItem shareItemWithTarget:self action:@selector(shareAction)];
                });
            }
        } fail:^(NSError *error) {
            
        }];
    } else {
        self.navigationItem.rightBarButtonItem = nil;
    }
}

@end
