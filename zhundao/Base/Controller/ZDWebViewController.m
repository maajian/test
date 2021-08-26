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
    [self.view addSubview:self.webView];
    [self addBackButton];
    
    // 手势返回设置
    [_webView setAllowsBackForwardNavigationGestures:true];
}

- (WKWebView *)webView {
    if (!_webView) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
        configuration.userContentController = userContentController;

        // js偏好设置
        WKPreferences *preferences = [WKPreferences new];
        preferences.javaScriptCanOpenWindowsAutomatically = YES;
        preferences.javaScriptEnabled = YES;
        preferences.minimumFontSize = 8;
        configuration.preferences = preferences;

        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kStatusBarHeight - ZD_SAFE_TOP) configuration:configuration];
        _webView.navigationDelegate = self;
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.urlString]
                                                               cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                           timeoutInterval:20];
        NSDictionary *cachedHeaders;
        if (self.urlString) {
           cachedHeaders = [[NSUserDefaults standardUserDefaults] objectForKey:self.urlString];
        }
        //设置request headers
        if (cachedHeaders) {
            NSString *etag = [cachedHeaders objectForKey:@"Etag"];
            if (etag) {
                [request setValue:etag forHTTPHeaderField:@"If-None-Match"];
            }
            NSString *lastModified = [cachedHeaders objectForKey:@"Last-Modified"];
            if (lastModified) {
                [request setValue:lastModified forHTTPHeaderField:@"If-Modified-Since"];
            }
        }
        [_webView loadRequest:request];

        [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *_Nullable data, NSURLResponse *_Nullable response, NSError *_Nullable error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
//            WYLog(@"httpResponse == %@", httpResponse);
            if (httpResponse.statusCode == 304 || httpResponse.statusCode == 0) {
                [request setCachePolicy:NSURLRequestReturnCacheDataElseLoad];
            } else {
                [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
                [ZD_UserDefaults setObject:httpResponse.allHeaderFields forKey:self.urlString];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                           [_webView reload];
                       });
        }] resume];
    }
    return _webView;
}

#pragma mark --- WKNavigationDelegate
/**
 页面开始加载时调用
 
 @param webView <#webView description#>
 @param navigation <#navigation description#>
 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
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
    NSString *url = [[navigationAction request].URL.absoluteString stringByRemovingPercentEncoding];
    NSString* scheme = [navigationAction request].URL.scheme;
    if(![url containsString:@"https"] && ![url containsString:@"http"]){
        if ([[UIDevice currentDevice].systemVersion floatValue] <= 10.0) {
            [[UIApplication sharedApplication] openURL:[navigationAction request].URL];
        }else {
            [[UIApplication sharedApplication] openURL:[navigationAction request].URL options:@{} completionHandler:^(BOOL success) {}];
        }
        //不允许跳转
        decisionHandler(WKNavigationActionPolicyCancel);
        return ;
    }
    if (navigationAction.targetFrame == nil) {
        [webView loadRequest:navigationAction.request];
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

#pragma mark --- 弹窗
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    [alertController addAction:([UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields[0].text?:@"");
    }])];
    
    
    [self presentViewController:alertController animated:YES completion:nil];
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
