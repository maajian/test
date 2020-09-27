#import "PGFirstAlreadyLogged.h"
#import "PGActivityNewActivityVC.h"
@interface PGActivityNewActivityVC ()<WKNavigationDelegate>
@end
@implementation PGActivityNewActivityVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"发起活动";
    WKWebView *webview =  [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
    webview.navigationDelegate = self;
    [self.view addSubview:webview];
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    self.webView =webview;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
