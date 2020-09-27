#import "PGDeviceOrientationFace.h"
#import "PGWebViewController.h"
@interface PGWebViewController ()<WKNavigationDelegate>
{
    JQIndicatorView *indicator;
}
@end
@implementation PGWebViewController
- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewWillDisappear:(BOOL)animated
{
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
dispatch_async(dispatch_get_main_queue(), ^{
    CGSize articleCommentDataJ8 = CGSizeMake(86,182); 
        UIImageView * taskNeedFinishE8 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString string]] highlightedImage:[[UIImage alloc] initWithData:[NSData data]]]; 
    taskNeedFinishE8.contentMode = UIViewContentModeCenter; 
    taskNeedFinishE8.clipsToBounds = NO; 
    taskNeedFinishE8.multipleTouchEnabled = YES; 
    taskNeedFinishE8.autoresizesSubviews = YES; 
    taskNeedFinishE8.clearsContextBeforeDrawing = YES; 
    PGDeviceOrientationFace *timeMakeWith= [[PGDeviceOrientationFace alloc] init];
[timeMakeWith pushNotificationTriggerWithaffineTransformIdentity:articleCommentDataJ8 modelWithAsset:taskNeedFinishE8 ];
});
    [super didReceiveMemoryWarning];
}
@end
