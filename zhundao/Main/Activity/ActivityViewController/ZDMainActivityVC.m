//
//  ZDMainActivityVC.m
//  zhundao
//
//  Created by maj on 2019/7/6.
//  Copyright © 2019 zhundao. All rights reserved.
//

#import "ZDMainActivityVC.h"

#import "postActivityViewController.h"
#import "ZDAllActivityVC.h"
#import "ZDOnActivityVC.h"
#import "ZDCloseActivityVC.h"

#import "ZDActivityViewModel.h"

@interface ZDMainActivityVC ()<ZDSegmentViewDelegate, UIScrollViewDelegate, UISearchControllerDelegate, UISearchResultsUpdating> {
    NSInteger _currentIndex;
}
@property (nonatomic, strong) UISearchController *searchController; // 搜索
@property (nonatomic, strong) ZDSegmentView      *segmentView; // 分页
@property (nonatomic, strong) UIScrollView       *scrollView;
@property (nonatomic, strong) ZDAllActivityVC    *allVC;
@property (nonatomic, strong) ZDOnActivityVC     *onVC;
@property (nonatomic, strong) ZDCloseActivityVC  *closeVC;

@property (nonatomic, strong) ZDActivityViewModel *viewModel;

@end

@implementation ZDMainActivityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSet];
    [self initLayout];
}

- (void)viewDidLayoutSubviews {
    CGRect viewBounds = self.view.bounds;
    CGFloat topBarOffset = self.topLayoutGuide.length;
    viewBounds.origin.y = topBarOffset * -1;
    self.view.bounds = viewBounds;
}

- (void)viewDidAppear:(BOOL)animated {
    if(@available(iOS 11.0, *)) {
        self.navigationItem.hidesSearchBarWhenScrolling=YES;
    }
    [self getEmail];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.definesPresentationContext = NO;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.definesPresentationContext = YES;
}

#pragma mark --- init
- (void)initSet {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _currentIndex = 0;
    self.view.backgroundColor = ZDBackgroundColor;
    [self.view addSubview:self.searchController.searchBar];
    [self.view addSubview:self.segmentView];
    [self.view addSubview:self.scrollView];
    _allVC = [[ZDAllActivityVC alloc] init];
    _onVC = [[ZDOnActivityVC alloc] init];
    _closeVC = [[ZDCloseActivityVC alloc] init];
    [self addChildViewController:_allVC];
    [self addChildViewController:_onVC];
    [self addChildViewController:_closeVC];
    [self.scrollView addSubview:_allVC.view];
    // 添加活动
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem activityAddItemWithTarget:self action:@selector(pushAddActivity)];
    if (ZD_UserM.loginExpired) {
        [ZD_NotificationCenter postNotificationName:ZDNotification_Logout object:nil];
    }
}
- (void)initLayout {
    ZD_WeakSelf
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.segmentView.mas_bottom);
        make.bottom.equalTo(weakSelf.view);
    }];
    [self.allVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.equalTo(weakSelf.scrollView);
        make.bottom.equalTo(weakSelf.view);
        make.width.equalTo(weakSelf.scrollView);
    }];
    [self.view layoutIfNeeded];
}

#pragma mark 懒加载
- (ZDSegmentView *)segmentView {
    if (!_segmentView) {
        _segmentView = [[ZDSegmentView alloc] initWithFrame:CGRectMake(0, 50, kScreenWidth, 50) dataArray:@[@"全 部",@"进行中",@"已结束"]];
        _segmentView.segmentViewDelegate = self;
        _segmentView.textFont = [UIFont boldSystemFontOfSize:14];
        _segmentView.lineWidth = 42;
        _segmentView.showBottomLine = YES;
    }
    return _segmentView;
}
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(3 * kScreenWidth, 0);
    }
    return _scrollView;
}
- (ZDActivityViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ZDActivityViewModel alloc] init];
    }
    return _viewModel;
}
// 搜索
- (UISearchController *)searchController {
    if (!_searchController) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        _searchController.searchBar.frame = CGRectMake(0,0,kScreenWidth,40);
        _searchController.searchBar.placeholder = @"搜索";
        _searchController.searchBar.barTintColor = ZDBackgroundColor;
        _searchController.searchBar.backgroundColor = ZDBackgroundColor;
        _searchController.dimsBackgroundDuringPresentation = NO;
        _searchController.hidesNavigationBarDuringPresentation = YES;
        _searchController.delegate = self;
        _searchController.searchResultsUpdater = self;
        if (@available(iOS 11.0, *)) {
            [_searchController.searchBar setPositionAdjustment:UIOffsetMake(kScreenWidth / 2 - 50, 0) forSearchBarIcon:UISearchBarIconSearch];
        }
        //搜索时，背景变模糊
        [_searchController.searchBar setBackgroundImage:[UIImage new]];
    }
    return _searchController;
}

#pragma mark --- ZDSegmentViewDelegate
- (void)segmentView:(ZDSegmentView *)segmentView didSelectIndex:(NSInteger)index {
    __weak typeof(self) weakSelf = self;
    if (index == 0) {
        [_scrollView setContentOffset:CGPointMake(0, 0)];
        _currentIndex = 0;
    } else if (index == 1){
        if (!_onVC.view.superview) {
            [self.scrollView addSubview:_onVC.view];
            [self.onVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.scrollView);
                make.leading.equalTo(self.scrollView).offset(kScreenWidth);
//                make.height.mas_equalTo(kScreenHeight- kTopBarHeight - 49 - 95);
                make.bottom.equalTo(self.view);
                make.width.equalTo(weakSelf.scrollView);
            }];
            if (self.searchController.searchBar.text) {
                self.onVC.searchText = self.searchController.searchBar.text;
            }
        }
        _currentIndex = 1;
        [_scrollView setContentOffset:CGPointMake(kScreenWidth, 0)];
    } else {
        if (!_closeVC.view.superview) {
            [self.scrollView addSubview:_closeVC.view];
            [self.closeVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.scrollView);
                make.leading.equalTo(self.scrollView).offset(2 * kScreenWidth);
//                make.height.mas_equalTo(kScreenHeight- kTopBarHeight - 49 - 95);
                make.bottom.equalTo(self.view);
                make.width.equalTo(weakSelf.scrollView);
            }];
            if (self.searchController.searchBar.text) {
                self.closeVC.searchText = self.searchController.searchBar.text;
            }
        }
        _currentIndex = 2;
        [_scrollView setContentOffset:CGPointMake(2 * kScreenWidth, 0)];
    }
}

#pragma mark UISearchControllerDelegate 的代理
- (void)willPresentSearchController:(UISearchController *)searchController {
    if (@available(iOS 11.0, *)) {
        [_searchController.searchBar setPositionAdjustment:UIOffsetZero forSearchBarIcon:UISearchBarIconSearch];
    }
}
- (void)willDismissSearchController:(UISearchController *)searchController {
    self.allVC.active = NO;
    self.onVC.active = NO;
    self.closeVC.active = NO;
    if (@available(iOS 11.0, *)) {
        [_searchController.searchBar setPositionAdjustment:UIOffsetMake(kScreenWidth / 2 - 50, 0) forSearchBarIcon:UISearchBarIconSearch];
    }
}

#pragma mark --- UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    if (self.searchController.searchBar.text.length) {
        self.allVC.active = YES;
        self.onVC.active = YES;
        self.closeVC.active = YES;
    } else {
        self.allVC.active = NO;
        self.onVC.active = NO;
        self.closeVC.active = NO;
    }
    self.allVC.searchText = self.searchController.searchBar.text;
    self.onVC.searchText = self.searchController.searchBar.text;
    self.closeVC.searchText = self.searchController.searchBar.text;
}

#pragma mark --- UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = 0;
    if (self.scrollView.contentOffset.x == kScreenWidth) {
        index = 1;
    } else if (self.scrollView.contentOffset.x == 2 * kScreenWidth){
        index = 2;
    } else {
        index = 0;
    }
    _currentIndex = index;
    [self segmentView:nil didSelectIndex:index];
    self.segmentView.currentIndex = index;
}

#pragma mark --- action
- (void)pushAddActivity {
    if ([[  NSUserDefaults standardUserDefaults  ]objectForKey:@"GradeId"]) {
        NSInteger grade =  [[[  NSUserDefaults standardUserDefaults  ]objectForKey:@"GradeId"]integerValue];
        if (grade <= 1) {
            ZD_WeakSelf
            [self.viewModel checkIsCanpost:^(id obj) {
                if ([obj[@"Res"] integerValue] == 0) {
                    [weakSelf gotoPost];
                } else {
                    maskLabel *label = [[maskLabel alloc]initWithTitle:@"免费版一个月最多只能发4个活动"];
                    [label  labelAnimationWithViewlong:weakSelf.view];
                }
            } error:^(NSError *error) {
                [[SignManager shareManager] showNotHaveNet:weakSelf.view];
            }];
        } else {
            [self gotoPost];
        }
    }
}
- (void)gotoPost {
    postActivityViewController *postVC = [[postActivityViewController alloc]init];
    [self.navigationController pushViewController:postVC animated:YES];
}

- (void)getEmail {
    NSString *userstr = [NSString stringWithFormat:@"%@api/v2/user/getUserInfo?token=%@",zhundaoApi,[[SignManager shareManager] getToken]];
    [ZD_NetWorkM getDataWithMethod:userstr parameters:nil succ:^(NSDictionary *obj) {
        NSDictionary *data = [NSDictionary dictionaryWithDictionary:obj];
        NSDictionary  *userdic = data[@"data"];
        [[NSUserDefaults standardUserDefaults]setObject:userdic[@"email"] forKey:@"email"];
    } fail:^(NSError *error) {
        
    }];
}


@end
