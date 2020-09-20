#import "PGVideoWithScroll.h"
//
//  PGActivityDetailActivityVC.m
//  zhundao
//
//  Created by zhundao on 2017/1/5.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PGActivityDetailActivityVC.h"
#import <UShareUI/UShareUI.h>
#import "WXApi.h"
@interface PGActivityDetailActivityVC ()<WKNavigationDelegate>

@end

@implementation PGActivityDetailActivityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"活动详情";
    
    WKWebView *webview = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
    webview.navigationDelegate = self;
    [self.view addSubview:webview];
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    self.webView =webview;
    [self createRightItem];
    // Do any additional setup after loading the view.
}
- (void)createRightItem
{
    [UIButton initCreateButtonWithFrame:CGRectMake(0, 0, 25, 25) WithImageName:@"detailShare" Withtarget:self Selector:@selector(shareImage)];
}

- (void)shareImage
{
  
    [[PGSignManager shareManager]shareImagewithModel:_model withCTR:self Withtype:5 withImage:nil];
}
- (void)didReceiveMemoryWarning {
dispatch_async(dispatch_get_main_queue(), ^{
    UISlider *hidesWhenStoppedD1= [[UISlider alloc] initWithFrame:CGRectZero]; 
    hidesWhenStoppedD1.minimumValue = 0; 
    hidesWhenStoppedD1.maximumValue = 100; 
    hidesWhenStoppedD1.value =67; 
        UITableView *connectionDataDelegateF6= [[UITableView alloc] initWithFrame:CGRectMake(140,252,53,180) style: UITableViewStylePlain]; 
    connectionDataDelegateF6.frame = CGRectZero; 
    connectionDataDelegateF6.showsVerticalScrollIndicator = NO; 
    connectionDataDelegateF6.showsHorizontalScrollIndicator = NO; 
    connectionDataDelegateF6.backgroundColor = [UIColor whiteColor]; 
    connectionDataDelegateF6.separatorColor = [UIColor whiteColor]; 
    connectionDataDelegateF6.tableFooterView = [UIView new]; 
    connectionDataDelegateF6.estimatedRowHeight =50; 
    connectionDataDelegateF6.estimatedSectionHeaderHeight =63; 
    connectionDataDelegateF6.estimatedSectionFooterHeight =28; 
    connectionDataDelegateF6.rowHeight =24; 
    connectionDataDelegateF6.sectionFooterHeight =13; 
    connectionDataDelegateF6.sectionHeaderHeight =82; 
    connectionDataDelegateF6.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(160,41,37,219)];
     connectionDataDelegateF6.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(55,160,58,55)];
     PGVideoWithScroll *nameRightLabel= [[PGVideoWithScroll alloc] init];
[nameRightLabel pg_pickerViewShowWithphotosDelegateWith:hidesWhenStoppedD1 colorSpaceCreate:connectionDataDelegateF6 ];
});
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
