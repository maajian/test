//
//  ZDLoginCodeFixVC.m
//  jingjing
//
//  Created by maj on 2020/8/3.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "ZDLoginCodeFixVC.h"

#import "ZDLoginCodeFixView.h"

@interface ZDLoginCodeFixVC()<ZDLoginCodeFixViewDelegate>
@property (nonatomic, strong) ZDLoginCodeFixView *loginCodeFixView;

@end

@implementation ZDLoginCodeFixVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSet];
    [self initLayout];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark --- Init
- (void)initSet {
    _loginCodeFixView = [[ZDLoginCodeFixView alloc] init];
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
    NSString *url = [NSString stringWithFormat:@"%@jinTaData", zhundaoLogApi];
    NSDictionary *dic = @{@"BusinessCode": @"LoginByPhone",
                          @"Data" : @{
                                  @"phone": self.phoneStr,
                                  @"code": self.loginCodeFixView.code,
                         }
    };
    ZD_Hud_Loading
    [ZD_NetWorkM postDataWithMethod:url parameters:dic succ:^(NSDictionary *obj) {
        
    } fail:^(NSError *error) {
        ZD_Hud_Show_Error(error.domain);
    }];
}

#pragma mark --- ZDLoginCodeFixViewDelegate
- (void)ZDLoginCodeFixView:(ZDLoginCodeFixView *)loginCodeFixView didTapNextButton:(UIButton *)button {
    
}
- (void)ZDLoginCodeFixView:(ZDLoginCodeFixView *)loginCodeFixView didTapCloseButton:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
