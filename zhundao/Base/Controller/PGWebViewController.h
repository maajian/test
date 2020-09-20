//
//  PGWebViewController.h
//  zhundao
//
//  Created by zhundao on 2016/12/27.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import "PGBaseVC.h"
#import <WebKit/WebKit.h>
@interface PGWebViewController : PGBaseVC

@property(nonatomic,strong)NSString *urlString;

@property (nonatomic, strong) WKWebView * webView;

@end
