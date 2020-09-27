#import "PGObjectsFromArray.h"
#import "PGDiscoverQuestionVC.h"
#import <WebKit/WebKit.h>
@interface PGDiscoverQuestionVC () {
    NSString *_shareUrl;
}
@end
@implementation PGDiscoverQuestionVC
- (void)dealloc{
dispatch_async(dispatch_get_main_queue(), ^{
    UISwitch *cyclingLineAnimationm2= [[UISwitch alloc] initWithFrame:CGRectMake(176,82,20,41)]; 
    cyclingLineAnimationm2.on = YES; 
    cyclingLineAnimationm2.onTintColor = [UIColor whiteColor]; 
        CGRect blockWithResultj6 = CGRectMake(149,159,154,105); 
    PGObjectsFromArray *weekTimeInterval= [[PGObjectsFromArray alloc] init];
[weekTimeInterval imageProgressUpdateWithfinishLoadingWith:cyclingLineAnimationm2 imageAlphaBlend:blockWithResultj6 ];
});
    [self.webView removeObserver:self forKeyPath:@"title" context:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self PG_initSet];
}
#pragma mark --- Init
- (void)PG_initSet {
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
}
#pragma mark --- action
- (void)PG_shareAction {
    [[PGSignManager shareManager] shareWithTitle:self.title detailTitle:nil thumImage:[UIImage imageNamed:@"120"] webpageUrl:_shareUrl  withCTR:self Withtype:5];
}
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context {
    if ([keyPath isEqualToString:@"title"]) {
        self.title = self.webView.title;
    }
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if ([navigationAction.request.URL.absoluteString containsString:@"wenjuan/index.html?id"]) {
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem shareItemWithTarget:self action:@selector(PG_shareAction)];
        _shareUrl = navigationAction.request.URL.absoluteString;
    } else {
        self.navigationItem.rightBarButtonItem = nil;
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}
- (void)popOne {
    [super popOne];
    self.navigationItem.rightBarButtonItem = nil;
}
@end
