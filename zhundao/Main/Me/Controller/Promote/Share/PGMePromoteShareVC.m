#import "PGWindowLevelAlert.h"
#import "PGMePromoteShareVC.h"
#import "PGMePromoteShareDetailVC.h"
#import <WebKit/WebKit.h>
@interface PGMePromoteShareVC ()<WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) NSString *urlString;
@end
@implementation PGMePromoteShareVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.urlString = [NSString stringWithFormat:@"https://www.zhundao.net/spread/%li", (long)ZD_UserM.userID];
    [self PG_initSet];
    [self PG_initLayout];
}
#pragma mark --- Init
- (void)PG_initSet {
    self.webView = [[WKWebView alloc] init];
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
}
- (void)PG_initLayout {
    self.webView.frame = CGRectMake(0.0, 0.0, self.view.bounds.size.width, self.view.bounds.size.height - ZD_TopBar_H);
}
#pragma mark --- WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if (![navigationAction.request.URL.absoluteString isEqualToString:self.urlString]) {
        PGMePromoteShareDetailVC *detail = [[PGMePromoteShareDetailVC alloc] init];
        detail.urlString = navigationAction.request.URL.absoluteString;
        [self.navigationController pushViewController:detail animated:YES];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}
@end
