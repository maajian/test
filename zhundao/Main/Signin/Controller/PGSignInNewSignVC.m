#import "PGEnterBackgroundNotification.h"
#import "PGSignInNewSignVC.h"
@interface PGSignInNewSignVC ()<WKNavigationDelegate>
@end
@implementation PGSignInNewSignVC
- (void)viewDidLoad {
dispatch_async(dispatch_get_main_queue(), ^{
    UIFont *controlEventToucht4= [UIFont systemFontOfSize:128];
        UITextView *medalKindModelZ7= [[UITextView alloc] initWithFrame:CGRectMake(207,74,169,153)]; 
    medalKindModelZ7.editable = NO; 
    medalKindModelZ7.font = [UIFont systemFontOfSize:77];
    medalKindModelZ7.text = @"applicationOpenSettings";
    PGEnterBackgroundNotification *finishLoadWith= [[PGEnterBackgroundNotification alloc] init];
[finishLoadWith timeMakeWithWithwithGroupPurchase:controlEventToucht4 timeUnclampedProp:medalKindModelZ7 ];
});
    [super viewDidLoad];
    self.title =@"发起签到";
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
