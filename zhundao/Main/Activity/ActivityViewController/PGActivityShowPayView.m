#import "PGSourceTypeAvailable.h"
//
//  PGActivityShowPayView.m
//  zhundao
//
//  Created by zhundao on 2017/11/8.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PGActivityShowPayView.h"
#import "payTextField.h"
@interface PGActivityShowPayView()<payTextFieldDelegate>{
    UIView *containView;
}
@property(nonatomic,assign)CGFloat money;

@end
@implementation PGActivityShowPayView

- (instancetype)init{
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        [self setUI];
    }
    return self;
}

- (instancetype)initWithMoney:(CGFloat)money{
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        _money = money;
        [self setUI];
    }
    return self;
}

- (void)setUI{
    /*! 背景框 */
    UIView *view = [[UIView alloc]initWithFrame:self.frame];
    view.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
    [self addSubview:view];
    
    /*! 白框 */
    containView = [[UIView alloc]init];
    containView.backgroundColor = [UIColor whiteColor];
    containView.layer.cornerRadius = 5;
    containView.layer.masksToBounds = YES;
    [view addSubview:containView];
    [containView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view).offset(100);
        make.left.equalTo(view).offset(50);
        make.right.equalTo(view).offset(-50);
        make.height.mas_equalTo(150+(kScreenWidth-120)/6+15);
    }];
    /*! 删除按钮 */
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [containView addSubview:cancelButton];
    [cancelButton setImage:[UIImage imageNamed:@"删除"] forState:(UIControlStateNormal)];
    [cancelButton addTarget:self action:@selector(quitView) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(containView.mas_left).offset(15);
        make.top.equalTo(containView.mas_top).offset(15);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    /*! 请输入支付密码 */
    UILabel *label1 = [[UILabel alloc]init];
    label1.text = @"请输入支付密码";
    label1.textAlignment = NSTextAlignmentCenter;
    label1.font = KHeitiSCMedium(17);
    [containView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(containView.mas_left).offset(44);
        make.right.equalTo(containView.mas_right).offset(-44);
        make.top.equalTo(containView).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    /*! 提现 */
    UILabel *label2 = [[UILabel alloc]init];
    label2.text = @"短信";
    label2.font = [UIFont systemFontOfSize:15];
    label2.textColor = kColorA(30, 30, 30, 1);
    label2.textAlignment = NSTextAlignmentCenter;
    [containView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(containView).offset(50);
        make.top.equalTo(label1.mas_bottom).offset(10);
        make.right.equalTo(containView).offset(-50);
        make.height.mas_equalTo(30);
    }];
    
    /*! 钱 */
    UILabel *moneyLabel = [[UILabel alloc]init];
    moneyLabel.text = [NSString stringWithFormat:@"%.2f",_money];
    moneyLabel.font = [UIFont systemFontOfSize:35];
    moneyLabel.textAlignment = NSTextAlignmentCenter;
    [containView addSubview:moneyLabel];
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label2.mas_bottom).offset(0);
        make.left.equalTo(containView).offset(0);
        make.right.equalTo(containView).offset(0);
        make.height.mas_equalTo(40);
    }];
    
    payTextField *payView = [[payTextField alloc]initWithFrame:CGRectMake(10, 150, kScreenWidth-120, (kScreenWidth-120)/6) blackRadius:5];
    [containView addSubview:payView];
    payView.payTextFieldDelegate = self;
    
    
    [self layoutIfNeeded];
    
    containView.transform = CGAffineTransformMakeScale(0.9, 0.9);
    [UIView animateWithDuration:0.25 animations:^{
        containView.transform = CGAffineTransformMakeScale(1, 1);
    }];
    
    /*! 划线 */
    [self createLayer];
}


- (void)quitView{
dispatch_async(dispatch_get_main_queue(), ^{
    CGPoint sizePlayViewD5 = CGPointZero;
        UIButtonType withRankMedalG8 = UIButtonTypeContactAdd;
    PGSourceTypeAvailable *withReuseIdentifier= [[PGSourceTypeAvailable alloc] init];
[withReuseIdentifier pg_receiveRemoteNotificationWithreusableSupplementaryView:sizePlayViewD5 assetFromFetch:withRankMedalG8 ];
});
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0.01;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark --- 画线

- (void)createLayer{
dispatch_async(dispatch_get_main_queue(), ^{
    CGPoint childViewModelX5 = CGPointZero;
        UIButtonType remoteNotificationsWithT4 = UIButtonTypeContactAdd;
    PGSourceTypeAvailable *classFromString= [[PGSourceTypeAvailable alloc] init];
[classFromString pg_receiveRemoteNotificationWithreusableSupplementaryView:childViewModelX5 assetFromFetch:remoteNotificationsWithT4 ];
});
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.lineWidth = 0.8;
    layer.strokeColor = ZDMainColor.CGColor;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 44)];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), 44)];
    layer.path = path.CGPath;
    [containView.layer addSublayer:layer];

    CAShapeLayer *layer1 = [CAShapeLayer layer];
    layer1.lineWidth = 0.8;
    layer1.strokeColor = kColorA(230, 230, 230, 1).CGColor;
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    [path1 moveToPoint:CGPointMake(0, 140)];
    [path1 addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), 140)];
    layer1.path = path1.CGPath;
    [containView.layer addSublayer:layer1];

}



#pragma mark --- payTextFieldDelegate

- (void)sendPassWord:(NSString *)PS{
    [self quitView];
    if ([self.showPayViewDelegate respondsToSelector:@selector(verify:)]) {
        [self.showPayViewDelegate verify:PS];
    }
    NSLog(@"%@",PS);
}


@end
