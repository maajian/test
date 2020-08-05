//
//  ZDSegmentView.m
//  zhundao
//
//  Created by maj on 2019/5/26.
//  Copyright © 2019 zhundao. All rights reserved.
//

#import "ZDSegmentView.h"

@interface ZDSegmentView() {
    NSInteger _priIndex;
}
@property (nonatomic, copy) NSArray *dataArray;
// 文字
@property (nonatomic, strong) NSMutableArray<UILabel *> *labelArray;
// 线
@property (nonatomic, strong) UIView *lineView;
// 底部黑线
@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation ZDSegmentView

- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArray{
    if (self = [super initWithFrame:frame]) {
        _priIndex = 0;
        self.backgroundColor = [UIColor whiteColor];
        _dataArray = dataArray;
        _labelArray = [NSMutableArray array];
        [self setupUI];
        [self initLayout];
    }
    return self;
}

#pragma mark --- UI
- (void)setupUI {
    for (int i = 0; i < _dataArray.count; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = [UIColor blackColor];
        label.text = _dataArray[i];
        label.font = [UIFont systemFontOfSize:15];
        label.userInteractionEnabled = YES;
        label.tag = 100 + i;
        label.textAlignment = NSTextAlignmentCenter;
        [label addTapGestureTarget:self action:@selector(labelAction:)];
        [self addSubview:label];
        [_labelArray addObject:label];
    }
    
    _labelArray[0].textColor = ZDMainColor;
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = ZDMainColor;
    [self addSubview:_lineView];
    // 底部黑线
    _bottomLine = [[UIView alloc] init];
    _bottomLine.backgroundColor = ZDLineColor;
    _bottomLine.hidden = YES;
    [self addSubview:_bottomLine];
}

#pragma mark --- 布局
- (void)initLayout {
    [_labelArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [_labelArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.centerX.equalTo(_labelArray[0].mas_centerX);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.height.mas_equalTo(2);
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self);
        make.height.mas_equalTo(1);
        make.bottom.equalTo(self);
    }];
}

#pragma mark --- setter
- (void)setTextFont:(UIFont *)textFont {
    for (UILabel *label in self.labelArray) {
        label.font = textFont;
    }
}
- (void)setLineWidth:(CGFloat)lineWidth {
    _lineWidth = lineWidth;
    [_lineView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(lineWidth);
    }];
}
- (void)setCurrentIndex:(NSInteger)currentIndex {
    _currentIndex = currentIndex;
    [self animationMoveWithCurrentIndex:currentIndex];
}
- (void)setShowBottomLine:(BOOL)showBottomLine {
    _showBottomLine = showBottomLine;
    self.bottomLine.hidden = NO;
}

#pragma mark --- action
- (void)labelAction:(UIGestureRecognizer *)gestureRecognizer {
    UILabel *label = (UILabel *)gestureRecognizer.view;
    NSInteger index = label.tag - 100;
    [self animationMoveWithCurrentIndex:index];
    if ([self.segmentViewDelegate respondsToSelector:@selector(segmentView:didSelectIndex:)]) {
        [self.segmentViewDelegate segmentView:self didSelectIndex:label.tag -100];
    }
}

#pragma mark --- animation
- (void)animationMoveWithCurrentIndex:(NSInteger)index {
    ZD_WeakSelf
    _labelArray[_priIndex].textColor = [UIColor blackColor];
    _labelArray[index].textColor = ZDMainColor;
    
    [UIView animateWithDuration:0.25 animations:^{
        [weakSelf.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(_lineWidth ? _lineWidth : 100);
            make.centerX.equalTo(_labelArray[index].mas_centerX);
            make.bottom.mas_equalTo(self.mas_bottom);
            make.height.mas_equalTo(2);
        }];
        [self layoutIfNeeded];
    }];
    _priIndex = index;
}

@end
