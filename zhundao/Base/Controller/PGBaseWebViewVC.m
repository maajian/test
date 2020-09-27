#import "PGHonorTitleModel.h"
#import "PGBaseWebViewVC.h"
@interface PGBaseWebViewVC ()<WKNavigationDelegate, WKUIDelegate>
@end
@implementation PGBaseWebViewVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.webTitle;
    [self PG_addOwnViews];
    [self PG_relayoutFrameOfSubViews];
    [self PG_addBackButton];
    [_webView setAllowsBackForwardNavigationGestures:true];
}
- (void)PG_addOwnViews {
    self.webView = [[WKWebView alloc] init];
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    [self.view addSubview:self.webView];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
}
- (void)PG_relayoutFrameOfSubViews {
dispatch_async(dispatch_get_main_queue(), ^{
    CGPoint medalViewModelL6 = CGPointZero;
        UITextView *circleViewControllerI4= [[UITextView alloc] initWithFrame:CGRectZero]; 
    circleViewControllerI4.editable = NO; 
    circleViewControllerI4.font = [UIFont systemFontOfSize:35];
    circleViewControllerI4.text = @"phoneWithPhone";
    PGHonorTitleModel *withTaskCenter= [[PGHonorTitleModel alloc] init];
[withTaskCenter attentionViewControllerWithcellPlayerFather:medalViewModelL6 withCourseVideo:circleViewControllerI4 ];
});
    self.webView.frame = CGRectMake(0.0, 0.0, self.view.bounds.size.width, self.view.bounds.size.height - 64);
}
#pragma mark --- WKNavigationDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    if (!_indicator) {
        _indicator = [[JQIndicatorView alloc]initWithType:3 tintColor: [UIColor colorWithRed:9.00f/255.0f green:187.00f/255.0f blue:7.00f/255.0f alpha:1] size:CGSizeMake(90, 70)];
        _indicator.center = self.view.center;
        [self.view addSubview:_indicator];
        [_indicator startAnimating];
    }
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [_indicator stopAnimating];
    NSString *titleStr = self.title;
    if (!titleStr.length) {
        self.title = self.webView.title;
    }
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
dispatch_async(dispatch_get_main_queue(), ^{
    CGPoint sliderTouchDownW5 = CGPointZero;
        UITextView *groupPhotosWitho1= [[UITextView alloc] initWithFrame:CGRectMake(175,230,21,118)]; 
    groupPhotosWitho1.editable = NO; 
    groupPhotosWitho1.font = [UIFont systemFontOfSize:142];
    groupPhotosWitho1.text = @"compositionLayerInstruction";
    PGHonorTitleModel *viewContentSize= [[PGHonorTitleModel alloc] init];
[viewContentSize attentionViewControllerWithcellPlayerFather:sliderTouchDownW5 withCourseVideo:groupPhotosWitho1 ];
});
    if (navigationAction.targetFrame == nil) {
        [webView loadRequest:navigationAction.request];
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}
#pragma mark --- WKUIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    [PGAlertView alertWithTitle:message message:nil cancelBlock:^{
        completionHandler();
        ZDDo_Block_Safe_Main(self.alertSureBlock)
    }];
}
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    [PGAlertView alertWithTitle:message message:nil sureBlock:^{
        completionHandler(YES);
        ZDDo_Block_Safe_Main(self.alertSureBlock)
    } cancelBlock:^{
        completionHandler(NO);
    }];
}
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
    }];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields.lastObject.text);
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}
#pragma mark --- 返回按钮
#pragma mark --- 返回按钮
- (void)PG_addBackButton {
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
        UIView *PG_popCloseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
        UIButton *PG_popCloseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        PG_popCloseButton.frame = CGRectMake(0, 0, 44, 44);
        [PG_popCloseButton setTitle:@"关闭" forState:UIControlStateNormal];
        [PG_popCloseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        PG_popCloseButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [PG_popCloseButton addTarget:self action:@selector(PG_popClose) forControlEvents:(UIControlEventTouchUpInside)];
        [PG_popCloseView addSubview:PG_popCloseButton];
        UIBarButtonItem *PG_popCloseItem = [[UIBarButtonItem alloc]initWithCustomView:PG_popCloseView];
        self.navigationItem.leftBarButtonItems = @[popOneItem, PG_popCloseItem];
    }
}
#pragma mark --- 跳转
- (void)popOne {
    if (self.popBlock) {
        ZDDo_Block_Safe_Main(self.popBlock);
    } else {
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
}
- (void)PG_popClose {
    if (self.popBlock) {
        ZDDo_Block_Safe_Main(self.popBlock);
    } else {
        if (self.presentingViewController) {
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
