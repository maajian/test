#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "PGBaseVC.h"
#import "JQIndicatorView.h"
@interface PGBaseWebViewVC : PGBaseVC
@property (nonatomic, strong) JQIndicatorView *indicator;
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) NSString *urlString;
@property (nonatomic, copy) NSString *webTitle;
@property (nonatomic , assign) BOOL isClose;
@property (nonatomic, copy) ZDBlock_Void popBlock;
@property (nonatomic, copy) ZDBlock_Void alertSureBlock;
- (void)popOne;
@end
