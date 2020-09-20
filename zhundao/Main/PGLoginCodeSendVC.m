//
//  PGLoginCodeSendVC.m
//  jingjing
//
//  Created by maj on 2020/8/3.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "PGLoginCodeSendVC.h"

#import "PGLoginCodeFixVC.h"

#import "PGLoginCodeSendView.h"

@interface PGLoginCodeSendVC()<PGLoginCodeSendViewDelegate>
@property (nonatomic, strong) PGLoginCodeSendView *loginCodeSendView;

@end

@implementation PGLoginCodeSendVC

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
    _loginCodeSendView = [[PGLoginCodeSendView alloc] init];
    _loginCodeSendView.loginCodeSendViewDelegate = self;
    [self.view addSubview:_loginCodeSendView];
}
- (void)initLayout {
    [_loginCodeSendView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

#pragma mark --- Network
- (void)networkForCheckPhone {
    NSString *url = [NSString stringWithFormat:@"%@jinTaData", zhundaoLogApi];
    NSDictionary *dic = @{@"BusinessCode": @"CheckPhone",
                          @"Data" : @{
                                  @"phone": self.loginCodeSendView.phoneTF.text,
                         }
    };
    ZD_HUD_SHOW_WAITING
    [ZD_NetWorkM postDataWithMethod:url parameters:dic succ:^(NSDictionary *obj) {
        ZD_HUD_DISMISS
        if ([obj[@"res"] boolValue]) {
            PGLoginCodeFixVC *codeFixVC = [[PGLoginCodeFixVC alloc] init];
            codeFixVC.phoneStr = self.loginCodeSendView.phoneTF.text;
            [self.navigationController pushViewController:codeFixVC animated:YES];
        } else {
            [PGAlertView alertWithTitle:@"暂无登录权限，如有使用需求请联系 13777880773" message:nil cancelBlock:nil];
        }
    } fail:^(NSError *error) {
        ZD_HUD_SHOW_ERROR(error);
    }];
}

#pragma mark --- PGLoginCodeSendViewDelegate
- (void)PGLoginCodeSendView:(PGLoginCodeSendView *)loginCodeSendView didTapCloseButton:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)PGLoginCodeSendView:(PGLoginCodeSendView *)loginCodeSendView didTapNextButton:(UIButton *)button {
    if (self.loginCodeSendView.phoneTF.text.length != 11) {
        ZD_HUD_SHOW_ERROR_STATUS(@"请输入正确的手机号")
        return;
    }
    [self.view endEditing:YES];
    [self networkForCheckPhone];
}

@end
