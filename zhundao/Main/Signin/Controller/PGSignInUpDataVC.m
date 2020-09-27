#import "PGCancelCollectionCourse.h"
#import "PGSignInUpDataVC.h"
@interface PGSignInUpDataVC ()<WKNavigationDelegate>
@end
@implementation PGSignInUpDataVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"会员升级";
    WKWebView *webview = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
    webview.navigationDelegate = self;
    [self.view addSubview:webview];
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    self.webView =webview;
    if (_isPresent) {
        [self PG_addBackItem];
    }
}
- (void)PG_addBackItem {
dispatch_async(dispatch_get_main_queue(), ^{
    CGSize photoViewIndexA9 = CGSizeZero;
        UIScrollView *frontFromBackF4= [[UIScrollView alloc] initWithFrame:CGRectZero]; 
    frontFromBackF4.showsHorizontalScrollIndicator = NO; 
    frontFromBackF4.showsVerticalScrollIndicator = NO; 
    frontFromBackF4.bounces = NO; 
    frontFromBackF4.maximumZoomScale = 5; 
    frontFromBackF4.minimumZoomScale = 1; 
    PGCancelCollectionCourse *beautyParamWith= [[PGCancelCollectionCourse alloc] init];
[beautyParamWith contentInsetAdjustmentWithregionDefaultHandler:photoViewIndexA9 locationWithSuccess:frontFromBackF4 ];
});
    UIView *popOneView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    UIButton *popOneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    popOneButton.frame = CGRectMake(0, 0, 25, 25);
    [popOneButton setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [popOneButton addTarget:self action:@selector(popOne) forControlEvents:(UIControlEventTouchUpInside)];
    [popOneView addSubview:popOneButton];
    UIBarButtonItem *popOneItem = [[UIBarButtonItem alloc]initWithCustomView:popOneView];
    self.navigationItem.leftBarButtonItem = popOneItem;
}
- (void)popOne {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    } else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    NSString *requestString = navigationResponse.response.URL.absoluteString;
    NSLog(@"requestString:%@",requestString);
    NSString *subStr = @"usercenter";
    if ([requestString rangeOfString:subStr].location != NSNotFound) {
        NSLog(@"这个字符串中有usercenter");
        _block(1);
        [self.navigationController  popViewControllerAnimated:YES];
    }
    decisionHandler(WKNavigationResponsePolicyAllow);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
