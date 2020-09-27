#import "PGBottomShrinkPlay.h"
#import "PGMeWithDrawViewController.h"
@interface PGMeWithDrawViewController ()<WKNavigationDelegate>
@end
@implementation PGMeWithDrawViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"提现";
    WKWebView *webview = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
    webview.navigationDelegate = self;
    [self.view addSubview:webview];
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    self.webView =webview;
}
- (void)didReceiveMemoryWarning {
dispatch_async(dispatch_get_main_queue(), ^{
    NSData *withAssetTracks7= [[NSData alloc] init];
        UIFont *settingPassWorde1= [UIFont systemFontOfSize:241];
    PGBottomShrinkPlay *userCommentModel= [[PGBottomShrinkPlay alloc] init];
[userCommentModel centerViewModelWithimageTypeFail:withAssetTracks7 dailyCourseModel:settingPassWorde1 ];
});
    [super didReceiveMemoryWarning];
}
@end
