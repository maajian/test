#import "PGBytesFromData.h"
#import "PGActivityAddMessageDetailVC.h"
@interface PGActivityAddMessageDetailVC ()<WKNavigationDelegate>
@end
@implementation PGActivityAddMessageDetailVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"充值记录";
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
