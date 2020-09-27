#import "PGVerticalScrollIndicator.h"
#import "PGMeSendMessageDetailVC.h"
@interface PGMeSendMessageDetailVC ()<WKNavigationDelegate>
@end
@implementation PGMeSendMessageDetailVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"发送记录";
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
