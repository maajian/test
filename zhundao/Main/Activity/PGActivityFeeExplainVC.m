#import "PGPageContolAliment.h"
#import "PGActivityFeeExplainVC.h"
@interface PGActivityFeeExplainVC ()<WKNavigationDelegate>
@end
@implementation PGActivityFeeExplainVC
- (void)viewDidLoad {
dispatch_async(dispatch_get_main_queue(), ^{
    UITableViewCellSeparatorStyle orderGroupModelz4 = UITableViewCellSeparatorStyleNone; 
        NSTextAlignment fullScreenVideol0 = NSTextAlignmentCenter; 
    PGPageContolAliment *uploadVideoBlock= [[PGPageContolAliment alloc] init];
[uploadVideoBlock interfaceOrientationMaskWithwithDailyCourse:orderGroupModelz4 routeSearchBase:fullScreenVideol0 ];
});
    [super viewDidLoad];
    self.title =@"手续费说明";
    WKWebView *webview =  [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
    webview.navigationDelegate = self;
    [self.view addSubview:webview];
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    self.webView =webview;
}
- (void)didReceiveMemoryWarning {
dispatch_async(dispatch_get_main_queue(), ^{
    UITableViewCellSeparatorStyle playerStateFailedN3 = UITableViewCellSeparatorStyleNone; 
        NSTextAlignment applicationIconBadgeK5 = NSTextAlignmentCenter; 
    PGPageContolAliment *collectionTrainModel= [[PGPageContolAliment alloc] init];
[collectionTrainModel interfaceOrientationMaskWithwithDailyCourse:playerStateFailedN3 routeSearchBase:applicationIconBadgeK5 ];
});
    [super didReceiveMemoryWarning];
}
@end
