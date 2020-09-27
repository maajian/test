#import "PGBaseVC.h"
#import <WebKit/WebKit.h>
@interface PGWebViewController : PGBaseVC
@property(nonatomic,strong)NSString *urlString;
@property (nonatomic, strong) WKWebView * webView;
@end
