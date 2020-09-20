//
//  PGActivitySuccessSendView.m
//  zhundao
//
//  Created by zhundao on 2017/11/9.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PGActivitySuccessSendView.h"

@interface PGActivitySuccessSendView(){
    UIView *containView ;
}

@end

@implementation PGActivitySuccessSendView

- (instancetype)init{
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        [self setUI];
    }
    return self;
}

- (void)setUI{
    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
    
  containView  = [[UIView alloc]init];
    containView.backgroundColor = [UIColor whiteColor];
    containView.layer.cornerRadius = 5;
    containView.layer.masksToBounds = YES;
    [self addSubview:containView];
    [containView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self).offset(0);
        make.centerY.equalTo(self).offset(-80);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth-40, 250));
    }];
    
    UILabel *label1 = [[UILabel alloc]init];
    label1.font = [UIFont systemFontOfSize:18];
    label1.textColor = kColorA(30, 30, 30, 1);
    label1.text = @"提交成功";
    label1.textAlignment = NSTextAlignmentCenter;
    [containView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(containView).offset(20);
        make.height.mas_equalTo(30);
        make.centerX.equalTo(containView.mas_centerX).offset(0);
        make.width.mas_equalTo(150);
    }];
    
    UILabel *label2 = [[UILabel alloc]init];
    label2.font = [UIFont systemFontOfSize:15];
    label2.textColor = kColorA(50, 50, 50, 1);
    label2.textAlignment = NSTextAlignmentCenter;
    label2.text = @"我们已收到您的群发申请";
    [containView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label1.mas_bottom).offset(10);
        make.height.mas_equalTo(30);
        make.centerX.equalTo(containView.mas_centerX).offset(0);
        make.width.mas_equalTo(kScreenWidth-40);
    }];
    
    UILabel *label3 = [[UILabel alloc]init];
    label3.font = [UIFont systemFontOfSize:15];
    label3.textColor = kColorA(50, 50, 50, 1);
    label3.text = @"1.审核通过，立即为您发送";
    label3.textAlignment = NSTextAlignmentCenter;
    [containView addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label2.mas_bottom).offset(0);
        make.height.mas_equalTo(30);
        make.centerX.equalTo(containView.mas_centerX).offset(0);
        make.width.mas_equalTo(kScreenWidth-40);
    }];
    
    UILabel *label4 = [[UILabel alloc]init];
    label4.font = [UIFont systemFontOfSize:15];
    label4.textColor = kColorA(50, 50, 50, 1);
    label4.text = @"2.审核不通过，返还短信条数";
    label4.textAlignment = NSTextAlignmentCenter;
    [containView addSubview:label4];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label3.mas_bottom).offset(0);
        make.height.mas_equalTo(30);
        make.centerX.equalTo(containView.mas_centerX).offset(0);
        make.width.mas_equalTo(kScreenWidth-40);
    }];
    
    UILabel *label5 = [[UILabel alloc]init];
    label5.font = [UIFont systemFontOfSize:15];
    label5.textColor = kColorA(50, 50, 50, 1);
    label5.text = @"3发送结果可在 个人中心→我的短信 查看";
    
    label5.textAlignment = NSTextAlignmentCenter;
    [containView addSubview:label5];
    [label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label4.mas_bottom).offset(0);
        make.height.mas_equalTo(30);
        make.centerX.equalTo(containView.mas_centerX).offset(0);
        make.width.mas_equalTo(kScreenWidth-40);
    }];
    
    
    
    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureButton setTitle:@"我知道了" forState:(UIControlStateNormal)];
    [sureButton setTitleColor:ZDMainColor forState:UIControlStateNormal];
    sureButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [sureButton addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    [containView addSubview:sureButton];
    [sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(containView.mas_bottom).offset(0);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth-40, 44));
        make.left.equalTo(containView).offset(0);
    }];
    
    [self layoutIfNeeded];
    [self createLayer];
    
    containView.transform = CGAffineTransformMakeScale(0.5, 0.5);
    [UIView animateWithDuration:0.25 animations:^{
        containView.transform = CGAffineTransformMakeScale(1, 1);
    }];
    
}

- (void)createLayer{
    CAShapeLayer *layer1 = [CAShapeLayer layer];
    layer1.lineWidth = 0.8;
    layer1.strokeColor = kColorA(230, 230, 230, 1).CGColor;
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    [path1 moveToPoint:CGPointMake(0, 200)];
    [path1 addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), 200)];
    layer1.path = path1.CGPath;
    [containView.layer addSublayer:layer1];
}
- (void)sure{
    if ([self.successSendViewDeleagte respondsToSelector:@selector(sureAction)]) {
        [self.successSendViewDeleagte sureAction];
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0.01;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


@end
