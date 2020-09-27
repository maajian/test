#import "PGShowInputText.h"
#import "PGloginCodeExplainVC.h"
@interface PGloginCodeExplainVC ()<WKNavigationDelegate>
@end
@implementation PGloginCodeExplainVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"获取验证码";
    WKWebView *webview =  [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
    webview.navigationDelegate = self;
    [self.view addSubview:webview];
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    self.webView =webview;
}
- (void)didReceiveMemoryWarning {
dispatch_async(dispatch_get_main_queue(), ^{
    UITableViewStyle tweetItemModelH1 = UITableViewStylePlain; 
        UITableViewStyle withSessionConfigurationm0 = UITableViewStylePlain; 
    PGShowInputText *backIndicatorImage= [[PGShowInputText alloc] init];
[backIndicatorImage birthdayPickerViewWithdataReadingMapped:tweetItemModelH1 assetsUsingBlock:withSessionConfigurationm0 ];
});
    [super didReceiveMemoryWarning];
}
@end
