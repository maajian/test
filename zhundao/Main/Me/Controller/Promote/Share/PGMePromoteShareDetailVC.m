#import "PGExchangeViewDelegate.h"
#import "PGMePromoteShareDetailVC.h"
#import <WebKit/WebKit.h>
@interface PGMePromoteShareDetailVC ()<WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *shareUrl;
@end
@implementation PGMePromoteShareDetailVC
- (void)viewDidLoad {
dispatch_async(dispatch_get_main_queue(), ^{
    UIImage *keyboardWillHidem0= [UIImage imageNamed:@""]; 
        UIFont *withJsonStringg3= [UIFont systemFontOfSize:182];
    PGExchangeViewDelegate *viewControllerDone= [[PGExchangeViewDelegate alloc] init];
[viewControllerDone viewControllerAnimatedWithbackFromFront:keyboardWillHidem0 locationHeaderView:withJsonStringg3 ];
});
    [super viewDidLoad];
    [self PG_initSet];
    [self PG_initLayout];
}
#pragma mark --- Init
- (void)PG_initSet {
    self.webView = [[WKWebView alloc] init];
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem shareItemWithTarget:self action:@selector(PG_shareAction)];
    _imageUrl = [self.urlString componentsSeparatedByString:@"?img="].lastObject;
    _shareUrl = [self.urlString componentsSeparatedByString:@"?img="].firstObject;
}
- (void)PG_initLayout {
    self.webView.frame = CGRectMake(0.0, 0.0, self.view.bounds.size.width, self.view.bounds.size.height - 64);
}
#pragma mark --- WKNavigationDelegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
dispatch_async(dispatch_get_main_queue(), ^{
    UIImage *keyboardTypeNumberf7= [UIImage imageNamed:@""]; 
        UIFont *changePreviousRouteq1= [UIFont systemFontOfSize:55];
    PGExchangeViewDelegate *tableFooterView= [[PGExchangeViewDelegate alloc] init];
[tableFooterView viewControllerAnimatedWithbackFromFront:keyboardTypeNumberf7 locationHeaderView:changePreviousRouteq1 ];
});
    self.title = self.webView.title;
}
#pragma mark --- action
- (void)PG_shareAction {
    [[PGSignManager shareManager] shareWithTitle:self.title detailTitle:nil thumImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_imageUrl]]] webpageUrl:self.shareUrl  withCTR:self Withtype:5];
}
@end
