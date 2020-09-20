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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
dispatch_async(dispatch_get_main_queue(), ^{
    UISlider *customAnimateTransitionH7= [[UISlider alloc] initWithFrame:CGRectMake(177,13,32,133)]; 
    customAnimateTransitionH7.minimumValue = 0; 
    customAnimateTransitionH7.maximumValue = 100; 
    customAnimateTransitionH7.value =57; 
        UITableView *photoPickerPhotot3= [[UITableView alloc] initWithFrame:CGRectZero style: UITableViewStylePlain]; 
    photoPickerPhotot3.frame = CGRectZero; 
    photoPickerPhotot3.showsVerticalScrollIndicator = NO; 
    photoPickerPhotot3.showsHorizontalScrollIndicator = NO; 
    photoPickerPhotot3.backgroundColor = [UIColor whiteColor]; 
    photoPickerPhotot3.separatorColor = [UIColor whiteColor]; 
    photoPickerPhotot3.tableFooterView = [UIView new]; 
    photoPickerPhotot3.estimatedRowHeight =15; 
    photoPickerPhotot3.estimatedSectionHeaderHeight =6; 
    photoPickerPhotot3.estimatedSectionFooterHeight =58; 
    photoPickerPhotot3.rowHeight =86; 
    photoPickerPhotot3.sectionFooterHeight =11; 
    photoPickerPhotot3.sectionHeaderHeight =58; 
    photoPickerPhotot3.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(7,118,173,209)];
     photoPickerPhotot3.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(146,242,183,229)];
     PGVideoWithScroll *courseViewModel= [[PGVideoWithScroll alloc] init];
[courseViewModel pg_pickerViewShowWithphotosDelegateWith:customAnimateTransitionH7 colorSpaceCreate:photoPickerPhotot3 ];
});
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
