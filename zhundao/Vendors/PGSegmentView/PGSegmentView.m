#import "PGWillResignActive.h"
//
//  PGSegmentView.m
//  zhundao
//
//  Created by maj on 2019/5/26.
//  Copyright © 2019 zhundao. All rights reserved.
//

#import "PGSegmentView.h"

@interface PGSegmentView() {
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

@implementation PGSegmentView

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
dispatch_async(dispatch_get_main_queue(), ^{
    UIView *withSessionConfigurationq2= [[UIView alloc] initWithFrame:CGRectZero]; 
    withSessionConfigurationq2.backgroundColor = [UIColor whiteColor]; 
    withSessionConfigurationq2.layer.cornerRadius = 
    withSessionConfigurationq2.layer.masksToBounds = YES; 
        UIActivityIndicatorView *gradeViewControllerF4= [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]; 
    gradeViewControllerF4.hidden = YES; 
    gradeViewControllerF4.hidesWhenStopped = YES; 
    PGWillResignActive *indicatorViewStyle= [[PGWillResignActive alloc] init];
[indicatorViewStyle authorizationOptionAlertWithmutableCompositionTrack:withSessionConfigurationq2 guideCollectionView:gradeViewControllerF4 ];
});
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
dispatch_async(dispatch_get_main_queue(), ^{
    UIView *textFiledDelegatex0= [[UIView alloc] initWithFrame:CGRectMake(97,175,94,153)]; 
    textFiledDelegatex0.backgroundColor = [UIColor whiteColor]; 
    textFiledDelegatex0.layer.cornerRadius = 
    textFiledDelegatex0.layer.masksToBounds = YES; 
        UIActivityIndicatorView *couponsViewControllerR6= [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]; 
    couponsViewControllerR6.hidden = YES; 
    couponsViewControllerR6.hidesWhenStopped = YES; 
    PGWillResignActive *couponsInfoModel= [[PGWillResignActive alloc] init];
[couponsInfoModel authorizationOptionAlertWithmutableCompositionTrack:textFiledDelegatex0 guideCollectionView:couponsViewControllerR6 ];
});
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
dispatch_async(dispatch_get_main_queue(), ^{
    UIView *deviceOrientationPortraitf7= [[UIView alloc] initWithFrame:CGRectMake(185,163,141,69)]; 
    deviceOrientationPortraitf7.backgroundColor = [UIColor whiteColor]; 
    deviceOrientationPortraitf7.layer.cornerRadius = 
    deviceOrientationPortraitf7.layer.masksToBounds = YES; 
        UIActivityIndicatorView *imageWithColore7= [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]; 
    imageWithColore7.hidden = YES; 
    imageWithColore7.hidesWhenStopped = YES; 
    PGWillResignActive *frameCheckDisabled= [[PGWillResignActive alloc] init];
[frameCheckDisabled authorizationOptionAlertWithmutableCompositionTrack:deviceOrientationPortraitf7 guideCollectionView:imageWithColore7 ];
});
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
