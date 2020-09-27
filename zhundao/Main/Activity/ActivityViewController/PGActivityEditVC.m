#import "PGDeviceOrientationLandscape.h"
#import "PGActivityEditVC.h"
#import <WebKit/WebKit.h>
#import "PGMainActivityVC.h"
@interface PGActivityEditVC ()<WKNavigationDelegate>
{
    JQIndicatorView *indicator;
}
@property (nonatomic, strong) WKWebView * webView;
@end
@implementation PGActivityEditVC
- (void)dealloc
{
    self.webView.navigationDelegate = nil;
    [self.webView removeFromSuperview];
    self.webView = nil;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"编辑";
    WKWebView *webview = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
    webview.navigationDelegate = self;
    [self.view addSubview:webview];
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlString]]];
    self.webView =webview;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    indicator = [[JQIndicatorView alloc]initWithType:3 tintColor: [UIColor colorWithRed:9.00f/255.0f green:187.00f/255.0f blue:7.00f/255.0f alpha:1] size:CGSizeMake(90, 70)];
    indicator.center = self.view.center;
    [self.view addSubview:indicator];
    [indicator startAnimating];
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [indicator stopAnimating];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
dispatch_async(dispatch_get_main_queue(), ^{
    UIImageView * attentionWithUserM5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString string]] highlightedImage:[[UIImage alloc] initWithData:[NSData data]]]; 
    attentionWithUserM5.contentMode = UIViewContentModeCenter; 
    attentionWithUserM5.clipsToBounds = NO; 
    attentionWithUserM5.multipleTouchEnabled = YES; 
    attentionWithUserM5.autoresizesSubviews = YES; 
    attentionWithUserM5.clearsContextBeforeDrawing = YES; 
        NSRange codeLoginViewS6 = NSMakeRange(10,237); 
    PGDeviceOrientationLandscape *finishLoadingWith= [[PGDeviceOrientationLandscape alloc] init];
[finishLoadingWith cellReuseIdentifierWithwithReuseIdentifier:attentionWithUserM5 sliderSeekTime:codeLoginViewS6 ];
});
    NSString *requestString = navigationResponse.response.URL.absoluteString;
    NSLog(@"requestString:%@",requestString);
    __weak typeof(self) weakSelf = self;
    NSString *subStr = @"MangeActivity";
    if ([requestString rangeOfString:subStr].location != NSNotFound) {
        NSLog(@"这个字符串中有MangeActivity");
        [ZD_NotificationCenter postNotificationName:ZDNotification_Load_Activity object:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        });
    }
    decisionHandler(WKNavigationResponsePolicyAllow);
}
@end
