#import "PGBottomShrinkPlay.h"
//
//  PGMeWithDrawViewController.m
//  zhundao
//
//  Created by zhundao on 2017/8/7.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PGMeWithDrawViewController.h"

@interface PGMeWithDrawViewController ()<WKNavigationDelegate>

@end

@implementation PGMeWithDrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"提现";
    WKWebView *webview = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
    webview.navigationDelegate = self;
    [self.view addSubview:webview];
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    self.webView =webview;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
dispatch_async(dispatch_get_main_queue(), ^{
    NSData *withAssetTracks7= [[NSData alloc] init];
        UIFont *settingPassWorde1= [UIFont systemFontOfSize:241];
    PGBottomShrinkPlay *userCommentModel= [[PGBottomShrinkPlay alloc] init];
[userCommentModel pg_centerViewModelWithimageTypeFail:withAssetTracks7 dailyCourseModel:settingPassWorde1 ];
});
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
