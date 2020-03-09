//
//  ZDMePromoteMainVC.m
//  zhundao
//
//  Created by maj on 2020/1/17.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "ZDMePromoteMainVC.h"

#import "ZDMePromoteShareVC.h"
#import "ZDMePromoteCustomContactVC.h"

#import "ZDMePromoteBottomView.h"

@interface ZDMePromoteMainVC ()<ZDMePromoteBottomViewDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) ZDMePromoteShareVC *shareVC;
@property (nonatomic, strong) ZDMePromoteCustomContactVC *contactVC;
@property (nonatomic, strong) ZDMePromoteBottomView *bottomView;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation ZDMePromoteMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSet];
    [self initLayout];
}

#pragma mark 懒加载
- (ZDMePromoteBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[ZDMePromoteBottomView alloc] init];
        _bottomView.promoteBottomViewDelegate = self;
        _bottomView.currentIndex = 0;
    }
    return _bottomView;
}
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(2 * kScreenWidth, 0);
    }
    return _scrollView;
}

#pragma mark --- init
- (void)initSet {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = ZDBackgroundColor;
    
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.scrollView];

    self.title = @"准到合伙人";
    _shareVC = [[ZDMePromoteShareVC alloc] init];
    _contactVC = [[ZDMePromoteCustomContactVC alloc] init];
    [self addChildViewController:_shareVC];
    [self addChildViewController:_contactVC];
    [self.scrollView addSubview:_contactVC.view];
    
}
- (void)initLayout {
    ZD_WeakSelf
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.mas_equalTo(49 - ZD_SAFE_BOTTOM_LAYOUT);
    }];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.bottomView.mas_top);
    }];
    [self.contactVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.equalTo(weakSelf.scrollView);
        make.bottom.equalTo(weakSelf.bottomView.mas_top);
        make.width.mas_equalTo(ZD_ScreenWidth);
    }];
    [self.bottomView refreshLayout];
}

#pragma mark --- ZDMePromoteBottomViewDelegate
- (void)promoteBottomView:(ZDMePromoteBottomView *)promoteBottomView didSelectMainButton:(UIButton *)button {
    self.title = @"准到合伙人";
     [_scrollView setContentOffset:CGPointMake(0, 0)];
}
- (void)promoteBottomView:(ZDMePromoteBottomView *)promoteBottomView didSelectShareButton:(UIButton *)button {
    self.title = @"分享";
    if (!_shareVC.view.superview) {
        [self.scrollView addSubview:_shareVC.view];
        [self.shareVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.scrollView);
            make.leading.equalTo(self.scrollView).offset(kScreenWidth);
            make.bottom.equalTo(self.bottomView.mas_top);
            make.width.mas_equalTo(kScreenWidth);
        }];
    }
    [_scrollView setContentOffset:CGPointMake(kScreenWidth, 0)];
}

#pragma mark --- UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = 0;
    if (self.scrollView.contentOffset.x == kScreenWidth) {
        index = 1;
        self.title = @"分享";
    } else {
        index = 0;
        self.title = @"准到合伙人";
    }
    self.bottomView.currentIndex = index;
}

@end
