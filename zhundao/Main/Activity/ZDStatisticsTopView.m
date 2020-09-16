//
//  ZDStatisticsTopView.m
//  jingjing
//
//  Created by maj on 2020/9/16.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "ZDStatisticsTopView.h"

@interface ZDStatisticsTopView()
@property (nonatomic, strong) UIView *shadowView;
@property (nonatomic, strong) UIView *cornerView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *

@end

@implementation ZDStatisticsTopView

- (instancetype)init{
    if (self = [super init]) {
        [self setupUI];
        [self initLayout];
    }
    return self;
}

#pragma mark --- lazyload
- (UIView *)shadowView {
    if (!_shadowView) {
        _shadowView = [[UIView alloc] init];
        _shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
        _shadowView.layer.shadowOffset = CGSizeMake(0, 0);
        _shadowView.layer.shadowOpacity = 0.2;
        _shadowView.layer.shadowRadius = 10;
    }
    return _shadowView;
}
- (UIView *)cornerView {
    if (!_cornerView) {
        _cornerView = [UIView new];
        _cornerView.backgroundColor = [UIColor whiteColor];
        _cornerView.layer.cornerRadius = 22;
        _cornerView.layer.masksToBounds = YES;
        _cornerView.userInteractionEnabled = YES;
    }
    return _cornerView;
}

#pragma mark --- UI
- (void)setupUI {
    
}

#pragma mark --- 布局
- (void)initLayout {
    
}

#pragma mark --- setter
- (void)setModel:(WYBaseModel *)model {
    
}

#pragma mark --- action

@end
