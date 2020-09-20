#import "PGWithSwimData.h"
//
//  payVerifyViewController.m
//  zhundao
//
//  Created by zhundao on 2017/11/7.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "payVerifyViewController.h"
#import "PasswordViewController.h"
@interface payVerifyViewController ()
/*! 验证码输入框 */
@property(nonatomic,strong)UITextField *textf;
/*! 发送验证码按钮 */
@property(nonatomic,strong)UIButton *sendVerifyButton;
/*! 验证按钮 */
@property(nonatomic,strong)UIButton *verifyButton;
/*! 手机号码 */
@property(nonatomic,copy)NSString *phoneStr;
@end

@implementation payVerifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _phoneStr = ZD_UserM.phone;
    [self setUI];
    self.title = @"短信验证";
    // Do any additional setup after loading the view.
}


- (void)setUI{
    
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = kColorA(180, 180, 180, 1);
    label.text = @"我们将发送6位验证码到你的手机:";
    [self.view addSubview:label];
    label.textAlignment = NSTextAlignmentCenter;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(40);
        make.height.mas_equalTo(30);
    }];
    
    UILabel *phoneLabel = [[UILabel alloc]init];
    phoneLabel.font = [UIFont systemFontOfSize:18];
    phoneLabel.textColor = kColorA(90, 90, 90, 1);
    phoneLabel.textAlignment = NSTextAlignmentCenter;
    phoneLabel.text = [_phoneStr stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    [self.view addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom);
        make.height.mas_equalTo(35);
        make.left.equalTo(self.view).offset(50);
        make.right.equalTo(self.view).offset(-50);
    }];
    
    _textf = [[UITextField alloc]init];
    _textf.placeholder = @"请输入手机验证码";
    _textf.tintColor = ZDMainColor;
    _textf.keyboardType = UIKeyboardTypeNumberPad;
    _textf.font = [UIFont systemFontOfSize:16];
    [_textf becomeFirstResponder];
    [self.view addSubview:_textf];
    [_textf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneLabel.mas_bottom).offset(30);
        make.left.equalTo(self.view).offset(20);
        make.width.mas_equalTo(kScreenWidth-40-150);
        make.height.mas_equalTo(40);
    }];
    
    _sendVerifyButton = [[UIButton alloc]init];
    [self.view addSubview:_sendVerifyButton];
    [_sendVerifyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    _sendVerifyButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_sendVerifyButton setTitleColor:ZDMainColor forState:UIControlStateNormal];
    [_sendVerifyButton addTarget:self action:@selector(sendVerify) forControlEvents:UIControlEventTouchUpInside];
    [_sendVerifyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-20);
        make.width.mas_equalTo(130);
        make.top.equalTo(phoneLabel.mas_bottom).offset(30);
        make.height.mas_equalTo(40);
    }];
    
    _verifyButton = [[UIButton alloc]init];
    [self.view addSubview:_verifyButton];
    [_verifyButton setTitle:@"验证" forState:UIControlStateNormal];
    [_verifyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _verifyButton.backgroundColor =ZDMainColor;
    _verifyButton.layer.cornerRadius = 5;
    _verifyButton.layer.masksToBounds = YES;
    [_verifyButton addTarget:self action:@selector(verifyMessage) forControlEvents:UIControlEventTouchUpInside];
    [_verifyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.top.equalTo(_sendVerifyButton.mas_bottom).offset(40);
        make.height.mas_equalTo(44);
    }];
    [self.view layoutIfNeeded];
    [self addline];
}

#pragma  mark --- 网络请求

- (void)sendVerify {
    NSString *str = [NSString stringWithFormat:@"%@api/v2/senCode?phoneOrEmail=%@",zhundaoApi,self.phoneStr];
    [ZD_NetWorkM getDataWithMethod:str parameters:nil succ:^(NSDictionary *obj) {
        [self beginTime];
    } fail:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];
}

- (void)verifyMessage{
    NSString *urlstr = [NSString stringWithFormat:@"%@api/v2/verifyCode?phoneOrEmail=%@&code=%@",zhundaoApi,self.phoneStr,_textf.text];
    [ZD_NetWorkM getDataWithMethod:urlstr parameters:nil succ:^(NSDictionary *obj) {
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:obj];
        NSLog(@"msg = %@",dic[@"Msg"]);
        if ([dic[@"errcode"] integerValue]==0) {
            PasswordViewController *pass = [[PasswordViewController alloc]init];
            [self setHidesBottomBarWhenPushed:YES];
            pass.state = New;
            [self.navigationController pushViewController:pass animated:YES];
        }
        else{
            PGMaskLabel *label = [[PGMaskLabel alloc]initWithTitle:dic[@"errmsg"]];
            [label labelAnimationWithViewlong:self.view];
        }
    } fail:^(NSError *error) {
        
    }];
}

#pragma mark --- 倒计时

- (void)beginTime
{
    __block int timeout =60;    //倒计时 gmd time
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC,0);
    dispatch_source_set_event_handler(timer, ^{
        if (timeout<=0) {
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                _sendVerifyButton.userInteractionEnabled = YES;
                [_sendVerifyButton setTitleColor:ZDMainColor forState:UIControlStateNormal];
                [_sendVerifyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                
            });
            
            
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                _sendVerifyButton.userInteractionEnabled = NO;
                [_sendVerifyButton setTitleColor:kColorA(120, 120, 120, 1) forState:UIControlStateNormal];
                [_sendVerifyButton setTitle:[NSString stringWithFormat:@"(%d)发送验证码",timeout] forState:UIControlStateNormal];
                timeout--;
            });
            
        }
    });
    dispatch_resume(timer);
}

#pragma mark -- 画线

- (void)addline{
    CAShapeLayer *layer1 = [CAShapeLayer layer];
    layer1.lineWidth = 1;
    layer1.strokeColor =  kColorA(220, 220, 220, 1).CGColor;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(20, CGRectGetMaxY(_textf.frame))];
    [path addLineToPoint:CGPointMake(kScreenWidth-20, CGRectGetMaxY(_textf.frame))];
    layer1.path = path.CGPath;
    [self.view.layer addSublayer:layer1];
    
    CAShapeLayer *layer2 = [CAShapeLayer layer];
    layer2.lineWidth = 0.3;
    layer2.strokeColor = kColorA(220, 220, 220, 1).CGColor;
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(CGRectGetMinX(_sendVerifyButton.frame), CGRectGetMinY(_textf.frame))];
    [path2 addLineToPoint:CGPointMake(CGRectGetMinX(_sendVerifyButton.frame), CGRectGetMaxY(_textf.frame))];
    layer2.path = path2.CGPath;
    [self.view.layer addSublayer:layer2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
