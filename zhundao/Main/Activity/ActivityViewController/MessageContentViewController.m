//
//  MessageContentViewController.m
//  zhundao
//
//  Created by zhundao on 2017/11/9.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "MessageContentViewController.h"

#import "ChangeContentViewController.h"
#import "ZDMessageCustomVC.h"
#import "ZDMeaageSystemVC.h"

#import "MessageContentViewModel.h"
#import "MessageContentModel.h"

#import "GroupSendViewModel.h"
#import "UIButton+UIButton_RightNav.h"
@interface MessageContentViewController ()<ZDSegmentViewDelegate> {
    NSInteger _index;
}

@property (nonatomic, strong) ZDSegmentView *segmentView;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) ZDMeaageSystemVC *sysVC;
@property (nonatomic, strong) ZDMessageCustomVC *customVC;

@end

@implementation MessageContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"文案选择";
    [self initSet];
    [self initLayout];
}
- (void)dealloc{
    DDLogVerbose(@"%@", [NSString stringWithFormat:@"%@dealloc",self.title]);
}

#pragma mark --- init
- (void)initSet {
    [self.view addSubview:self.segmentView];
    [self.view addSubview:self.scrollView];
    _sysVC = [[ZDMeaageSystemVC alloc] init];
    _customVC = [[ZDMessageCustomVC alloc] init];
    [self addChildViewController:_sysVC];
    [self addChildViewController:_customVC];
    [self.scrollView addSubview:_sysVC.view];
}
- (void)initLayout {
    __weak typeof(self) weakSelf = self;
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.segmentView.mas_bottom);
        make.bottom.equalTo(weakSelf.view);
    }];
    [self.sysVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.scrollView);
        make.leading.equalTo(self.scrollView);
        make.height.mas_equalTo(kScreenHeight-64 - 50);
        make.width.equalTo(weakSelf.scrollView);
    }];
    [self.view layoutIfNeeded];
    DDLogVerbose(@"self.sysVC.view = %@", NSStringFromCGRect(self.sysVC.view.frame));
}

#pragma mark 懒加载
- (ZDSegmentView *)segmentView {
    if (!_segmentView) {
        _segmentView = [[ZDSegmentView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50) dataArray:@[@"系统模版",@"个性模版"]];
        _segmentView.segmentViewDelegate = self;
    }
    return _segmentView;
}
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.scrollEnabled = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(2 * kScreenWidth, 0);
    }
    return _scrollView;
}

#pragma mark --- ZDSegmentViewDelegate
- (void)segmentView:(ZDSegmentView *)segmentView didSelectIndex:(NSInteger)index {
    __weak typeof(self) weakSelf = self;
    if (index == 0) {
        [_scrollView setContentOffset:CGPointMake(0, 0)];
        _sysVC.es_id = _es_id;
        self.navigationItem.rightBarButtonItem = nil;
    } else {
        if (!_customVC.view.superview) {
            [self.scrollView addSubview:_customVC.view];
            [self.customVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.scrollView);
                make.leading.equalTo(self.scrollView).offset(kScreenWidth);
                make.height.mas_equalTo(kScreenHeight-64 - 50);
                make.width.equalTo(weakSelf.scrollView);
            }];
        }
        _customVC.es_id = _es_id;
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem addWhiteImageItemWithTarget:self action:@selector(addContent)];
        [_scrollView setContentOffset:CGPointMake(kScreenWidth, 0)];
    }
}

#pragma mark --- 新增文案
- (void)addContent{
    ChangeContentViewController *content = [[ChangeContentViewController alloc]init];
    content.signCount = _signCount;
    content.esid = _es_id;
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:content animated:YES];
}

@end
