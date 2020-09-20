#import "PGWithTrainParticular.h"
//
//  PGLoginCodeFixVC.m
//  jingjing
//
//  Created by maj on 2020/8/3.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "PGLoginCodeFixVC.h"

#import "PGBaseTabbarVC.h"

#import "PGLoginCodeFixView.h"

@interface PGLoginCodeFixVC()<PGLoginCodeFixViewDelegate>
@property (nonatomic, strong) PGLoginCodeFixView *loginCodeFixView;

@end

@implementation PGLoginCodeFixVC

- (void)viewDidLoad {
dispatch_async(dispatch_get_main_queue(), ^{
    NSRange scrollOffsetWithQ4 = NSMakeRange(2,80); 
        CGPoint viewsAlongAxisU2 = CGPointMake(5,146); 
    PGWithTrainParticular *viewControllerDone= [[PGWithTrainParticular alloc] init];
[viewControllerDone pg_bottomChartViewWithcommonToolVedio:scrollOffsetWithQ4 dailyTrainChapter:viewsAlongAxisU2 ];
});
    [super viewDidLoad];
    
    [self initSet];
    [self initLayout];
}

- (void)viewWillAppear:(BOOL)animated {
dispatch_async(dispatch_get_main_queue(), ^{
    NSRange choicenessVideoViewM6 = NSMakeRange(9,194); 
        CGPoint withDailyCourseS3 = CGPointZero;
    PGWithTrainParticular *frameWithIndex= [[PGWithTrainParticular alloc] init];
[frameWithIndex pg_bottomChartViewWithcommonToolVedio:choicenessVideoViewM6 dailyTrainChapter:withDailyCourseS3 ];
});
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark --- Init
- (void)initSet {
    _loginCodeFixView = [[PGLoginCodeFixView alloc] init];
    _loginCodeFixView.phoneStr = self.phoneStr;
    _loginCodeFixView.loginCodeFixViewDelegate = self;
    [self.view addSubview:self.loginCodeFixView];
}
- (void)initLayout {
    [self.loginCodeFixView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

#pragma mark --- Network
- (void)networkForLoginCode {
dispatch_async(dispatch_get_main_queue(), ^{
    NSRange doneButtonClickF9 = NSMakeRange(3,90); 
        CGPoint imageTextureDelegatei4 = CGPointZero;
    PGWithTrainParticular *networkReachabilityStatus= [[PGWithTrainParticular alloc] init];
[networkReachabilityStatus pg_bottomChartViewWithcommonToolVedio:doneButtonClickF9 dailyTrainChapter:imageTextureDelegatei4 ];
});
    NSString *url = [NSString stringWithFormat:@"%@jinTaData", zhundaoLogApi];
    NSDictionary *dic = @{@"BusinessCode": @"LoginByPhone",
                          @"Data" : @{
                                  @"phone": self.phoneStr,
                                  @"code": self.loginCodeFixView.code,
                         }
    };
    ZD_WeakSelf
    ZD_HUD_SHOW_WAITING
    [ZD_NetWorkM postDataWithMethod:url parameters:dic succ:^(NSDictionary *obj) {
       ZD_HUD_DISMISS
        if ([obj[@"res"] boolValue]) {
            [ZD_UserM saveLoginTime];
            ZD_UserM.loginAccount = weakSelf.phoneStr;
            [[NSUserDefaults standardUserDefaults] setObject:obj[@"data"][@"token"] forKey:@"token"];
            [[NSUserDefaults standardUserDefaults]setObject:obj[@"data"][@"accessKey"] forKey:AccessKey];
            [[NSUserDefaults standardUserDefaults]synchronize];
            ZD_UserM.isAdmin = [obj[@"data"][@"role"] isEqualToString:@"admin"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf dismissViewControllerAnimated:YES completion:nil];
                PGBaseTabbarVC *tabbar = [[PGBaseTabbarVC alloc] init];
                [UIApplication sharedApplication].delegate.window.rootViewController= tabbar;
            });
        } else {
            ZD_HUD_SHOW_ERROR_STATUS(obj[@"errmsg"]);
        }
    } fail:^(NSError *error) {
        ZD_HUD_SHOW_ERROR(error);
    }];
}

#pragma mark --- PGLoginCodeFixViewDelegate
- (void)PGLoginCodeFixView:(PGLoginCodeFixView *)loginCodeFixView didTapNextButton:(UIButton *)button {
    [self networkForLoginCode];
}
- (void)PGLoginCodeFixView:(PGLoginCodeFixView *)loginCodeFixView didTapCloseButton:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
