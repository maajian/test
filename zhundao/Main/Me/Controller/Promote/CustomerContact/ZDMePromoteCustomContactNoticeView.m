//
//  ZDMePromoteCustomContactNoticeView.m
//  zhundao
//
//  Created by maj on 2020/1/8.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "ZDMePromoteCustomContactNoticeView.h"

@interface ZDMePromoteCustomContactNoticeView() {
    NSInteger _currentPage;
}
@property (nonatomic, strong) UIView *cornerView;
@property (nonatomic, strong) UIImageView *noticeImageView;
@property (nonatomic, strong) UILabel *noticeLabel;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *moreButton;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ZDMePromoteCustomContactNoticeView

- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
        [self initLayout];
        _timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(timeAction:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return self;
}

#pragma mark --- lazyload
- (UIView *)cornerView {
    if (!_cornerView) {
        _cornerView = [[UIView alloc] init];
        _cornerView.layer.cornerRadius = 6;
        _cornerView.backgroundColor = [UIColor whiteColor];
        _cornerView.layer.masksToBounds = YES;
    }
    return _cornerView;
}
- (UIImageView *)noticeImageView {
    if (!_noticeImageView) {
        _noticeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_me_Promote_notice"]];
    }
    return _noticeImageView;
}
- (UILabel *)noticeLabel {
    if (!_noticeLabel) {
        _noticeLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDGreenColor2 font:ZDMediumFont(12) numberOfLines:0 lineBreakMode:0 lineAlignment:0];
        _noticeLabel.text = @"公告";
    }
    return _noticeLabel;
}
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = ZDLineColor;
    }
    return _lineView;
}
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.bounces = NO;
//        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}
- (UIButton *)moreButton {
    if (!_moreButton) {
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreButton setTitle:@"更多" forState:UIControlStateNormal];
        _moreButton.titleLabel.font = ZDSystemFont(12);
        [_moreButton addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
        [_moreButton setTitleColor:ZDGrayColor2 forState:UIControlStateNormal];
    }
    return _moreButton;
}

#pragma mark --- UI
- (void)setupUI {
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowOpacity = 0.1;
    self.layer.shadowRadius = 5;
    
    [self addSubview:self.cornerView];
    [self.cornerView addSubview:self.noticeImageView];
    [self.cornerView addSubview:self.noticeLabel];
    [self.cornerView addSubview:self.scrollView];
    [self.cornerView addSubview:self.lineView];
    [self.cornerView addSubview:self.moreButton];
}

#pragma mark --- 布局
- (void)initLayout {
    [self.cornerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.noticeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(16);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(18, 14));
    }];
    [self.noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.noticeImageView.mas_trailing).offset(2);
        make.centerY.equalTo(self);
    }];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.noticeLabel.mas_trailing).offset(10);
        make.trailing.equalTo(self.moreButton.mas_leading).offset(-10);
        make.top.equalTo(self);
        make.height.mas_equalTo(37);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(2);
        make.top.equalTo(self).offset(12);
        make.bottom.equalTo(self).offset(-12);
        make.trailing.equalTo(self.moreButton.mas_leading).offset(-7);
    }];
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self).offset(-10);
        make.centerY.equalTo(self).offset(0);
    }];
}

#pragma mark --- setter
- (void)setNoticeArray:(NSMutableArray<ZDMePromoteNoticeModel *> *)noticeArray {
    _noticeArray = noticeArray;
    for (int i = 0; i< noticeArray.count; i++) {
        ZDMePromoteNoticeModel *model = noticeArray[i];
        UILabel *label = [UILabel labelWithFrame:CGRectZero textColor:ZDBlackColor font:ZDSystemFont(12) numberOfLines:0 lineBreakMode:0 lineAlignment:0];
        [label addTapGestureTarget:self action:@selector(noticeAction:)];
        label.text = model.Title;
        label.tag = 100 + i;
        _currentPage = 0;
        [_scrollView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(self.scrollView);
            make.top.equalTo(self.scrollView).offset(37 * i);
            make.height.mas_equalTo(37);
        }];
    }
    [self layoutIfNeeded];
    if (_noticeArray.count) {
        _scrollView.contentSize = CGSizeMake(self.width, 37 * noticeArray.count);
    }
}

#pragma mark --- NSTimer
- (void)timeAction:(NSTimer *)timer {
    if (_noticeArray.count > 1) {
        if (_currentPage == 0) {
            [_scrollView setContentOffset:CGPointMake(0, 37) animated:YES];
            _currentPage += 1;
        } else if (_currentPage == 1 && _noticeArray.count == 2) {
            [_scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
            _currentPage = 0;
        } else if (_currentPage == 1 && _noticeArray.count == 3) {
            [_scrollView setContentOffset:CGPointMake(0, 37 * 2 ) animated:YES];
            _currentPage += 1;
        } else {
            [_scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
            _currentPage = 0;
        }
    }
}

#pragma mark --- action
- (void)moreAction:(UIButton *)button {
    if ([self.promoteCustomContactNoticeViewDelegate respondsToSelector:@selector(promoteCustomContactNoticeView:didTapMoreButton:)]) {
        [self.promoteCustomContactNoticeViewDelegate promoteCustomContactNoticeView:self didTapMoreButton:button];
    }
}
- (void)noticeAction:(UITapGestureRecognizer *)tap {
    NSInteger index = tap.view.tag - 100;
    ZDMePromoteNoticeModel *model = _noticeArray[index];
    if ([self.promoteCustomContactNoticeViewDelegate respondsToSelector:@selector(promoteCustomContactNoticeView:didTapNotice:)]) {
        [self.promoteCustomContactNoticeViewDelegate promoteCustomContactNoticeView:self didTapNotice:model];
    }
}

@end
