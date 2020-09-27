#import "PGEdgeInsetsInset.h"
#import "PGMeDetailMoneyViewController.h"
@interface PGMeDetailMoneyViewController ()<WKNavigationDelegate>
@end
@implementation PGMeDetailMoneyViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"明细";
    WKWebView *webview = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
    webview.navigationDelegate = self;
    [self.view addSubview:webview];
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    self.webView =webview;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
