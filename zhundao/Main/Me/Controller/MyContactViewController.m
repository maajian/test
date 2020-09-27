#import "PGWithCustomView.h"
#import "MyContactViewController.h"
#import <WebKit/WebKit.h>
@interface MyContactViewController ()<WKNavigationDelegate,UIScrollViewDelegate>
@end
@implementation MyContactViewController
- (void)viewDidLoad {
dispatch_async(dispatch_get_main_queue(), ^{
    UIEdgeInsets withActionBlockW6 = UIEdgeInsetsMake(50,195,194,250); 
        NSString *headerViewDelegateq6 = @"recommendCourseHeight";
    PGWithCustomView *navigationViewController= [[PGWithCustomView alloc] init];
[navigationViewController pg_cyclingSpotAnimationWithcontrolStateDisabled:withActionBlockW6 columnistCategoryModel:headerViewDelegateq6 ];
});
    self.title =@"通讯录";
    WKWebView *webview = [[WKWebView alloc]initWithFrame:self.view.bounds];
    webview.navigationDelegate = self;
    webview.scrollView.delegate = self;
    [self.view addSubview:webview];
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    self.webView =webview;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
