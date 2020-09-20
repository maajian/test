#import "PGShowInputText.h"
//
//  PGloginCodeExplainVC.m
//  zhundao
//
//  Created by 罗程勇 on 2018/6/15.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import "PGloginCodeExplainVC.h"

@interface PGloginCodeExplainVC ()<WKNavigationDelegate>

@end

@implementation PGloginCodeExplainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title =@"获取验证码";
    WKWebView *webview =  [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
    webview.navigationDelegate = self;
    [self.view addSubview:webview];
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    self.webView =webview;
}

- (void)didReceiveMemoryWarning {
dispatch_async(dispatch_get_main_queue(), ^{
    UITableViewStyle tweetItemModelH1 = UITableViewStylePlain; 
        UITableViewStyle withSessionConfigurationm0 = UITableViewStylePlain; 
    PGShowInputText *backIndicatorImage= [[PGShowInputText alloc] init];
[backIndicatorImage birthdayPickerViewWithdataReadingMapped:tweetItemModelH1 assetsUsingBlock:withSessionConfigurationm0 ];
});
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

*/

@end
