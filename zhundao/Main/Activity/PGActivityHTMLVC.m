#import "PGSliderValueChanged.h"
#import "PGActivityHTMLVC.h"
@interface PGActivityHTMLVC ()
@property (nonatomic, strong) WKWebView *webView;
@end
@implementation PGActivityHTMLVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView = ({
        WKWebView *webView = [[WKWebView alloc] init];
//        webView.dataDetectorTypes = UIDataDetectorTypeNone;
        [self.view addSubview:webView];
        webView;
    });
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.webView loadHTMLString:self.HTMLString baseURL:nil];
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.webView.frame = self.view.bounds;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)setHTMLString:(NSString *)HTMLString {
    _HTMLString = [HTMLString copy];
    if (self.webView) {
        [self.webView loadHTMLString:HTMLString baseURL:nil];
    }
}
@end
