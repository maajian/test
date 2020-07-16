//
//  ZDWebViewVC.h
//  zhundao
//
//  Created by 罗程勇 on 2018/6/27.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <WebKit/WebKit.h>

#import "ZDBaseVC.h"
#import "JQIndicatorView.h"

@interface ZDWebViewVC : ZDBaseVC

@property (nonatomic, strong) JQIndicatorView *indicator;

@property (nonatomic, strong) WKWebView *webView;

// 链接
@property (nonatomic, strong) NSString *urlString;
// 网页的标题
@property (nonatomic, copy) NSString *webTitle;
 // 是否需要关闭按钮
@property (nonatomic , assign) BOOL isClose;

- (void)popOne;

@end
