#import "PGPageContolAliment.h"
//
//  PGActivityFeeExplainVC.m
//  zhundao
//
//  Created by xhkj on 2018/1/24.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import "PGActivityFeeExplainVC.h"

@interface PGActivityFeeExplainVC ()<WKNavigationDelegate>

@end

@implementation PGActivityFeeExplainVC

- (void)viewDidLoad {
dispatch_async(dispatch_get_main_queue(), ^{
    UITableViewCellSeparatorStyle orderGroupModelz4 = UITableViewCellSeparatorStyleNone; 
        NSTextAlignment fullScreenVideol0 = NSTextAlignmentCenter; 
    PGPageContolAliment *uploadVideoBlock= [[PGPageContolAliment alloc] init];
[uploadVideoBlock pg_interfaceOrientationMaskWithwithDailyCourse:orderGroupModelz4 routeSearchBase:fullScreenVideol0 ];
});
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
[collectionTrainModel pg_interfaceOrientationMaskWithwithDailyCourse:playerStateFailedN3 routeSearchBase:applicationIconBadgeK5 ];
});
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
dispatch_async(dispatch_get_main_queue(), ^{
    UITableViewCellSeparatorStyle readingAllowFragmentsv7 = UITableViewCellSeparatorStyleNone; 
        NSTextAlignment changePreviousRoutet4 = NSTextAlignmentCenter; 
    PGPageContolAliment *numberHandlerWith= [[PGPageContolAliment alloc] init];
[numberHandlerWith pg_interfaceOrientationMaskWithwithDailyCourse:readingAllowFragmentsv7 routeSearchBase:changePreviousRoutet4 ];
});
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
