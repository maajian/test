//
//  ZDWebViewController.h
//  zhundao
//
//  Created by zhundao on 2016/12/27.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import "ZDBaseVC.h"
#import <WebKit/WebKit.h>
@interface ZDWebViewController : ZDBaseVC

@property(nonatomic,strong)NSString *urlString;

@property (nonatomic, strong) WKWebView * webView;

@end
