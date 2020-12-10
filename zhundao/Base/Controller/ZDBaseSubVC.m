//
//  ZDBaseSubVC.m
//  Meari
//
//  Created by 李兵 on 2016/11/18.
//  Copyright © 2016年 PPStrong. All rights reserved.
//

#import "ZDBaseSubVC.h"

#import "UIScrollView+EmptyDataSet.h"

@interface ZDBaseSubVC ()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@end
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wprotocol"

@implementation ZDBaseSubVC
#pragma mark - Private
#pragma mark -- Getter
ZDGetter_MutableArray(dataSource)
ZDGetter_MutableDictionary(dataSourceDic)
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.frame = CGRectZero;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = [UIView new];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.emptyDataSetDelegate = self;
        _tableView.emptyDataSetSource = self;
        ZDDo_Block_Safe1(self.setTableView, _tableView)
        [self.view addSubview: _tableView];
    }
    return _tableView;
}
- (CAAnimation *)emptyAnimation {
    if (!_emptyAnimation) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
        animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0) ];
        animation.duration = 0.25;
        animation.cumulative = YES;
        animation.repeatCount = MAXFLOAT;
        _emptyAnimation = animation;
    }
    return _emptyAnimation;
}
#pragma mark -- Init

#pragma mark -- Life
- (instancetype)init {
    self = [super init];
    if (self) {
        self.fromPush = NO;
        self.showEmptyImage = YES;
        self.showErrorImage = YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.fromPush = NO;
    self.showEmptyImage = YES;
    self.showErrorImage = YES;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    self.emptyElementsSpace = 10;
    self.emptyImage = [UIImage imageNamed:@"public_nodata"];
    self.errorImage = [UIImage imageNamed:@"public_nodata"];
    self.errorTitle = @"网络不大好，请稍后再试";
    self.emptyTitle = @"暂无数据";
    self.emptyImage = [UIImage imageNamed:@"public_nodata"];
    ZD_WeakSelf
    self.errorBlock = ^{
        weakSelf.isEmpty = NO;
        weakSelf.isError = YES;
        weakSelf.isLoading = NO;
        if (weakSelf.tableView) {
            [weakSelf.tableView reloadEmptyDataSet];
        }
        if (weakSelf.collectionView) {
            [weakSelf.collectionView reloadEmptyDataSet];
        }
    };
    self.errorBlockWithError = ^(NSString *obj) {
        weakSelf.isEmpty = NO;
        weakSelf.isError = YES;
        weakSelf.isLoading = NO;
        if (obj.length > 0) {
            weakSelf.errorTitle = obj;
        }
        if (weakSelf.tableView) {
            [weakSelf.tableView reloadEmptyDataSet];
        }
        if (weakSelf.collectionView) {
            [weakSelf.collectionView reloadEmptyDataSet];
        }
    };
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.emptyDataSetSource = self;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.emptyDataSetDelegate = self;
    self.collectionView.emptyDataSetSource = self;

    self.navigationController.navigationBarHidden = NO;
    if (self.fromPush) {
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem backImageItemWithTarget:self action:@selector(backAction:)];
    }
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
#pragma mark -- Network
#pragma mark -- Notification
#pragma mark -- NSTimer
#pragma mark -- Utilities
#pragma mark -- Action
- (void)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Delegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self.view endEditing:YES];
}
#pragma mark UITabelViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    return cell;
}
#pragma mark - DZNEmptyDataSetDelegate
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return self.isEmpty || self.isError;
}
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView {
    return YES;
}
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}
- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView {
    return self.isLoading;
}
- (void)emptyDataSetDidTapView:(UIScrollView *)scrollView {
    if (self.isEmpty && self.emptyViewTapedBlock) {
        self.emptyViewTapedBlock();
        return;
    }
    if (self.isError && self.errorViewTapedBlock) {
        self.errorViewTapedBlock();
    }
}
- (void)emptyDataSetDidTapButton:(UIScrollView *)scrollView {
    if (self.isEmpty && self.emptyButtonTapedBlock) {
        self.emptyButtonTapedBlock();
        return;
    }
    if (self.isError && self.errorButtonTapedBlock) {
        self.errorButtonTapedBlock();
    }
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
    if (self.isEmpty && self.emptyViewTapedBlock) {
        self.emptyViewTapedBlock();
        return;
    }
    if (self.isError && self.errorViewTapedBlock) {
        self.errorViewTapedBlock();
    }
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    if (self.isEmpty && self.emptyButtonTapedBlock) {
        self.emptyButtonTapedBlock();
        return;
    }
    if (self.isError && self.errorButtonTapedBlock) {
        self.errorButtonTapedBlock();
    }
}
- (void)emptyDataSetWillAppear:(UIScrollView *)scrollView {
    if (self.isEmpty && self.emptyViewWillAppearBlock) {
        self.emptyViewWillAppearBlock();
        return;
    }
    if (self.isError && self.errorViewWillAppearBlock) {
        self.errorViewWillAppearBlock();
    }
}
- (void)emptyDataSetDidAppear:(UIScrollView *)scrollView {
    if (self.isEmpty && self.emptyViewDidAppearBlock) {
        self.emptyViewDidAppearBlock();
        return;
    }
    if (self.isError && self.errorViewDidAppearBlock) {
        self.errorViewDidAppearBlock();
    }
}
- (void)emptyDataSetWillDisappear:(UIScrollView *)scrollView {
    if (self.isEmpty && self.emptyViewWillDisappearBlock) {
        self.emptyViewWillDisappearBlock();
        return;
    }
    if (self.isError && self.errorViewWillDisappearBlock) {
        self.errorViewWillDisappearBlock();
    }
}
- (void)emptyDataSetDidDisappear:(UIScrollView *)scrollView {
    if (self.isEmpty && self.emptyViewDidDisappearBlock) {
        self.emptyViewDidDisappearBlock();
        return;
    }
    if (self.isError && self.errorViewDidDisappearBlock) {
        self.errorViewDidDisappearBlock();
    }
}
#pragma mark - DZNEmptyDataSetSource
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    if (self.isLoading) {
        return nil;
    }
    if (self.isEmpty) {
        if (self.attributedEmptyTitle) {
            return self.attributedEmptyTitle;
        }
        if (self.emptyTitle) {
            return [NSAttributedString defaultAttributedStringWithString:self.emptyTitle fontColor:ZDGreyColorA font:ZDSystemFont(14) alignment:NSTextAlignmentCenter];
        }
    }
    if (self.isError) {
        if (self.attributedErrorTitle) {
            return self.attributedErrorTitle;
        }
        if (self.errorTitle) {
            return [NSAttributedString defaultAttributedStringWithString:self.errorTitle fontColor:ZDGreyColorA font:ZDSystemFont(14) alignment:NSTextAlignmentCenter];
        }
    }
    return nil;
}
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    if (self.isLoading) {
        return nil;
    }
    if (self.isEmpty && !self.isError) {
        return self.emptyDescription;
    }
    return self.errorDescription;
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    if (self.isLoading) {
        return self.emptyImageLoading;
    }
    if (self.showEmptyImage && !self.isError) {
        return self.isEmpty ? self.emptyImage : nil;
    }
    return self.isError ? self.errorImage : nil;
}
- (UIColor *)imageTintColorForEmptyDataSet:(UIScrollView *)scrollView {
    return self.emptyImageTintColor;
}
- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView {
    return self.emptyAnimation;
}
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    switch (state) {
        case UIControlStateNormal: {
            return self.emptyButtonTitleNormal;
            break;
        }
        case UIControlStateHighlighted: {
            return self.emptyButtonTitleHighlighted;
            break;
        }
        case UIControlStateSelected: {
            return self.emptyButtonTitleSelected;
            break;
        }
        case UIControlStateDisabled: {
            return self.emptyButtonTitleDisabled;
            break;
        }
        default:
            return nil;
            break;
    }
}
- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    switch (state) {
        case UIControlStateNormal: {
            return self.emptyButtonImageNormal;
            break;
        }
        case UIControlStateHighlighted: {
            return self.emptyButtonImageHighlighted;
            break;
        }
        case UIControlStateSelected: {
            return self.emptyButtonImageSelected;
            break;
        }
        case UIControlStateDisabled: {
            return self.emptyButtonImageDisabled;
            break;
        }
        default:
            return nil;
            break;
    }
}
- (UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    switch (state) {
        case UIControlStateNormal: {
            return self.emptyButtonBackgroundImageNormal;
            break;
        }
        case UIControlStateHighlighted: {
            return self.emptyButtonBackgroundImageHighlighted;
            break;
        }
        case UIControlStateSelected: {
            return self.emptyButtonBackgroundImageSelected;
            break;
        }
        case UIControlStateDisabled: {
            return self.emptyButtonBackgroundImageDisabled;
            break;
        }
        default:
            return nil;
            break;
    }
}
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return self.emptyViewBackgroundColor;
}
- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView {
    return self.emptyCustomView;
}
- (CGPoint)offsetForEmptyDataSet:(UIScrollView *)scrollView {
    return self.emptyContentOffset;
}
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return self.emptyVerticalOffset;
}
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
    return self.emptyElementsSpace;
}
#pragma mark - Public
- (void)setIsLoading:(BOOL)isLoading {
    if (_isLoading == isLoading) return;

    _isLoading = isLoading;
    if (self.tableView) {
        [self.tableView reloadEmptyDataSet];
    }
    if (self.collectionView) {
        [self.collectionView  reloadEmptyDataSet];
    }
}
- (void)setIsEmpty:(BOOL)isEmpty {
    _isEmpty = isEmpty;
    if (isEmpty) {
        _isError = NO;
    }
}
@end

#pragma clang diagnostic pop
