//
//  maskLabel.m
//  zhundao
//
//  Created by zhundao on 2017/1/19.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "maskLabel.h"

@implementation maskLabel

- (instancetype)initWithTitle:(NSString *)str
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.textColor =[UIColor whiteColor];
        self.textAlignment = NSTextAlignmentCenter;
        self.layer.cornerRadius = 5;
        self.numberOfLines = 0;
        self.layer.masksToBounds = YES;
        self.font = [UIFont boldSystemFontOfSize:16];
        self.text = str;
        self.alpha=1;
        
    }
    return self;
}
- (void)labelAnimationWithView :(UIView *)view
{
    [view addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(view);
        make.size.mas_equalTo(CGSizeMake(160, 35));
    }];
    [UIView animateWithDuration:2.5 animations:^{
        self.alpha =0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (void)labelAnimationWithViewlong :(UIView *)view
{
    CGSize size = [self.text boundingRectWithSize:CGSizeMake(kScreenWidth-80, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:16]} context:nil].size;
    [view addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(view);
        make.size.mas_equalTo(CGSizeMake(size.width+40, size.height+10));
    }];
    [UIView animateWithDuration:2.5 animations:^{
        self.alpha =0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
