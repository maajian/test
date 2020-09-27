#import "PGCollectionViewDelegate.h"
#import "PGDiscoverUseExplainVC.h"
@interface PGDiscoverUseExplainVC ()<WKNavigationDelegate>
@end
@implementation PGDiscoverUseExplainVC
- (void)viewDidLoad {
dispatch_async(dispatch_get_main_queue(), ^{
    UITextView *pointerFunctionsOptionsm7= [[UITextView alloc] initWithFrame:CGRectZero]; 
    pointerFunctionsOptionsm7.editable = NO; 
    pointerFunctionsOptionsm7.font = [UIFont systemFontOfSize:127];
    pointerFunctionsOptionsm7.text = @"organzationViewModel";
        NSLineBreakMode buttonTitleColorb7 = NSLineBreakByTruncatingTail; 
    PGCollectionViewDelegate *photoImageView= [[PGCollectionViewDelegate alloc] init];
[photoImageView animationRightTickWithchangePreviousRoute:pointerFunctionsOptionsm7 sendTweetSucc:buttonTitleColorb7 ];
});
    [super viewDidLoad];
    self.title =@"使用说明";
    WKWebView *webview = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
    webview.navigationDelegate = self;
    [self.view addSubview:webview];
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    self.webView =webview;
}
- (void)didReceiveMemoryWarning {
dispatch_async(dispatch_get_main_queue(), ^{
    UITextView *mainFirstLoginy1= [[UITextView alloc] initWithFrame:CGRectZero]; 
    mainFirstLoginy1.editable = NO; 
    mainFirstLoginy1.font = [UIFont systemFontOfSize:232];
    mainFirstLoginy1.text = @"audioSessionCategory";
        NSLineBreakMode assetsGroupEnumerations0 = NSLineBreakByTruncatingTail; 
    PGCollectionViewDelegate *sizeWithAttributes= [[PGCollectionViewDelegate alloc] init];
[sizeWithAttributes animationRightTickWithchangePreviousRoute:mainFirstLoginy1 sendTweetSucc:assetsGroupEnumerations0 ];
});
    [super didReceiveMemoryWarning];
}
@end
