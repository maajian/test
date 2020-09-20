//
//  PGAvtivityPostFooterView.m
//  zhundao
//
//  Created by zhundao on 2017/9/13.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PGAvtivityPostFooterView.h"

@interface PGAvtivityPostFooterView()
/*! 发布按钮 */
@property(nonatomic,strong)UIButton *button;
/*! 打勾按钮 */
@property(nonatomic,strong)UIButton *checkbox;
/*! 阅读并同意标签 */
@property(nonatomic,strong)UILabel *label;
/*! 《准到服务协议》标签 */
@property(nonatomic,strong)UILabel *label1;

@end

@implementation PGAvtivityPostFooterView

- (instancetype)init{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.button];
        [self addSubview:self.checkbox];
        [self addSubview:self.label];
        [self addSubview:self.label1];
    }
    return self;
}

- (UIButton *)button{
    if (!_button) {
        _button= [MyButton initWithButtonFrame:CGRectMake(10, 10, kScreenWidth-20, 40) title:@"发布" textcolor:[UIColor whiteColor] Target:self action:@selector(isCanPost) BackgroundColor:ZDMainColor cornerRadius:5 masksToBounds:YES];
        _button.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _button.layer.borderWidth = 0.5;
    }
    return _button;
}

- (UIButton *)checkbox{
    if (!_checkbox) {
        _checkbox = [UIButton buttonWithType:UIButtonTypeCustom];
        
        CGRect checkboxRect = CGRectMake(20,77,10,10);
        [_checkbox setFrame:checkboxRect];
        _checkbox.layer.borderColor = [UIColor grayColor].CGColor;
        _checkbox.layer.borderWidth = 0.5;
        [_checkbox setImage:[UIImage imageNamed:@"签到打勾"] forState:UIControlStateNormal];
        
        [_checkbox addTarget:self action:@selector(checkboxClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _checkbox;
}

- (UILabel *)label{
    if (!_label) {
        _label = [MyLabel initWithLabelFrame:CGRectMake(35, 65, 60, 35) Text:@"阅读并同意" textColor:[UIColor grayColor] font:KHeitiSCMedium(12) textAlignment:NSTextAlignmentRight cornerRadius:0 masksToBounds:NO];
    }
    return _label;
}

- (UILabel *)label1{
    if (!_label1) {
        _label1 =  [MyLabel initWithLabelFrame:CGRectMake(95, 65, 100, 35) Text:@"《准到服务协议》" textColor:[UIColor grayColor] font:KHeitiSCMedium(12) textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:NO];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:_label1.text];
        [str addAttribute:NSForegroundColorAttributeName value:ZDMainColor range:NSMakeRange(0, _label1.text.length)];
        [str addAttribute:NSFontAttributeName value:KHeitiSCMedium(12) range:NSMakeRange(0, _label1.text.length)];
        _label1.attributedText = str;
        _label1.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushToXieyi)];
        [_label1 addGestureRecognizer:tap];
    }
    return _label1;
}
#pragma mark  footerButtonAction
- (void)checkboxClick
{
    _button.selected = !_button.selected;
    if (_button.selected) {
        NSLog(@"选中");  //取消图片
        [_button setImage:[UIImage imageNamed:@"空白"] forState:UIControlStateNormal];
        _button.backgroundColor = [UIColor clearColor];
        _button.userInteractionEnabled = NO;
    }
    else{
        NSLog(@"未选中"); //打勾
        [_button setImage:[UIImage imageNamed:@"签到打勾"] forState:UIControlStateNormal];
        _button.backgroundColor = ZDMainColor;
        _button.userInteractionEnabled = YES;
    }
}

- (void)pushToXieyi
{
    if ([self.footerDelegate respondsToSelector:@selector(pushToXieyi)]) {
        [_footerDelegate pushToXieyi];
    }
}

- (void)isCanPost{
    if ([self.footerDelegate respondsToSelector:@selector(post)]) {
        [_footerDelegate post];
    }
}


@end
