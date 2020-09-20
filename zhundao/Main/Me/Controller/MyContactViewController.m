#import "PGWithCustomView.h"
//
//  MyContactViewController.m
//  zhundao
//
//  Created by zhundao on 2016/12/27.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import "MyContactViewController.h"
#import <WebKit/WebKit.h>
@interface MyContactViewController ()<WKNavigationDelegate,UIScrollViewDelegate>
@end

@implementation MyContactViewController


- (void)viewDidLoad {
dispatch_async(dispatch_get_main_queue(), ^{
    UIEdgeInsets withActionBlockW6 = UIEdgeInsetsMake(50,195,194,250); 
        NSString *headerViewDelegateq6 = @"recommendCourseHeight";
    PGWithCustomView *navigationViewController= [[PGWithCustomView alloc] init];
[navigationViewController pg_cyclingSpotAnimationWithcontrolStateDisabled:withActionBlockW6 columnistCategoryModel:headerViewDelegateq6 ];
});
  
    self.title =@"通讯录";
    WKWebView *webview = [[WKWebView alloc]initWithFrame:self.view.bounds];
    webview.navigationDelegate = self;
    webview.scrollView.delegate = self;
    [self.view addSubview:webview];
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    self.webView =webview;

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
dispatch_async(dispatch_get_main_queue(), ^{
    UIEdgeInsets photoPrevireViewE9 = UIEdgeInsetsZero;
        NSString *integralStoreViewA3 = @"originBackgroundColor";
    PGWithCustomView *pickingMultipleVideo= [[PGWithCustomView alloc] init];
[pickingMultipleVideo pg_cyclingSpotAnimationWithcontrolStateDisabled:photoPrevireViewE9 columnistCategoryModel:integralStoreViewA3 ];
});
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
