#import "PGTrainViewController.h"
#import "PGMainActivityVC.h"
#import "PGActivityPostActivityVC.h"
#import "PGAllActivityVC.h"
#import "PGOnActivityVC.h"
#import "PGCloseActivityVC.h"
#import "PGMeMessageVC.h"
#import "PGActivityViewModel.h"
@interface PGMainActivityVC ()<PGSegmentViewDelegate, UIScrollViewDelegate, UISearchControllerDelegate, UISearchResultsUpdating> {
    NSInteger _currentIndex;
}
@property (nonatomic, strong) UISearchController *searchController; 
@property (nonatomic, strong) PGSegmentView      *segmentView; 
@property (nonatomic, strong) UIScrollView       *scrollView;
@property (nonatomic, strong) PGAllActivityVC    *allVC;
@property (nonatomic, strong) PGOnActivityVC     *onVC;
@property (nonatomic, strong) PGCloseActivityVC  *closeVC;
@property (nonatomic, strong) PGActivityViewModel *viewModel;
@end
@implementation PGMainActivityVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self PG_initSet];
    [self PG_initLayout];
    if (!ZD_UserM.isAdmin) {
        [self PG_networkGetMessageList];
    }
}
- (void)viewDidLayoutSubviews {
    CGRect viewBounds = self.view.bounds;
    CGFloat topBarOffset = self.topLayoutGuide.length;
    viewBounds.origin.y = topBarOffset * -1;
    self.view.bounds = viewBounds;
}
- (void)viewDidAppear:(BOOL)animated {
dispatch_async(dispatch_get_main_queue(), ^{
    UIEdgeInsets periodicTimeObserverq4 = UIEdgeInsetsMake(107,227,148,163); 
        UIButtonType statusBackgroundColorR1 = UIButtonTypeContactAdd;
    PGTrainViewController *textAlignmentCenter= [[PGTrainViewController alloc] init];
[textAlignmentCenter minimumFractionDigitsWithselectTypeMyttention:periodicTimeObserverq4 notificationPresentationOption:statusBackgroundColorR1 ];
});
    if(@available(iOS 11.0, *)) {
        self.navigationItem.hidesSearchBarWhenScrolling=YES;
    }
    [self PG_getEmail];
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
- (void)PG_initSet {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _currentIndex = 0;
    self.view.backgroundColor = ZDBackgroundColor;
    [self.view addSubview:self.searchController.searchBar];
    [self.view addSubview:self.segmentView];
    [self.view addSubview:self.scrollView];
    _allVC = [[PGAllActivityVC alloc] init];
    _onVC = [[PGOnActivityVC alloc] init];
    _closeVC = [[PGCloseActivityVC alloc] init];
    [self addChildViewController:_allVC];
    [self addChildViewController:_onVC];
    [self addChildViewController:_closeVC];
    [self.scrollView addSubview:_allVC.view];
    if (ZD_UserM.isAdmin) {
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem activityAddItemWithTarget:self action:@selector(PG_pushAddActivity)];
    } else {
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem activityAddItemWithTarget:self action:@selector(PG_pushQuestion)];
    }
    if (ZD_UserM.loginExpired) {
        [ZD_NotificationCenter postNotificationName:ZDNotification_Logout object:nil];
    }
}
- (void)PG_initLayout {
dispatch_async(dispatch_get_main_queue(), ^{
    UIEdgeInsets underlineStyleSinglea1 = UIEdgeInsetsZero;
        UIButtonType dailyTrainClassJ1 = UIButtonTypeContactAdd;
    PGTrainViewController *textureCoordinateAttribute= [[PGTrainViewController alloc] init];
[textureCoordinateAttribute minimumFractionDigitsWithselectTypeMyttention:underlineStyleSinglea1 notificationPresentationOption:dailyTrainClassJ1 ];
});
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
- (PGSegmentView *)segmentView {
    if (!_segmentView) {
        _segmentView = [[PGSegmentView alloc] initWithFrame:CGRectMake(0, 50, kScreenWidth, 50) dataArray:@[@"全 部",@"进行中",@"已结束"]];
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
- (PGActivityViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[PGActivityViewModel alloc] init];
    }
    return _viewModel;
}
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
        [_searchController.searchBar setBackgroundImage:[UIImage new]];
    }
    return _searchController;
}
#pragma mark --- PGSegmentViewDelegate
- (void)segmentView:(PGSegmentView *)segmentView didSelectIndex:(NSInteger)index {
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
#pragma mark --- network
- (void)PG_pushAddActivity {
    if ([[  NSUserDefaults standardUserDefaults  ]objectForKey:@"GradeId"]) {
        NSInteger grade =  [[[  NSUserDefaults standardUserDefaults  ]objectForKey:@"GradeId"]integerValue];
        if (grade <= 1) {
            ZD_WeakSelf
            [self.viewModel checkIsCanpost:^(id obj) {
                if ([obj[@"Res"] integerValue] == 0) {
                    [weakSelf PG_gotoPost];
                } else {
                    PGMaskLabel *label = [[PGMaskLabel alloc]initWithTitle:@"免费版一个月最多只能发4个活动"];
                    [label  labelAnimationWithViewlong:weakSelf.view];
                }
            } error:^(NSError *error) {
                [[PGSignManager shareManager] showNotHaveNet:weakSelf.view];
            }];
        } else {
            [self PG_gotoPost];
        }
    }
}
- (void)PG_networkGetMessageList {
dispatch_async(dispatch_get_main_queue(), ^{
    UIEdgeInsets partButtonActionz2 = UIEdgeInsetsZero;
        UIButtonType tweetCommentDataS3 = UIButtonTypeContactAdd;
    PGTrainViewController *textAlignmentLeft= [[PGTrainViewController alloc] init];
[textAlignmentLeft minimumFractionDigitsWithselectTypeMyttention:partButtonActionz2 notificationPresentationOption:tweetCommentDataS3 ];
});
    ZD_WeakSelf
    [self.viewModel getMeMessageListSuccess:^(NSInteger obj) {
        if (obj) {
            [PGAlertView alertWithTitle:@"消息提醒" message:[NSString stringWithFormat:@"您有%li条未读消息", (long)obj] cancelTitle:@"取消" sureTitle:@"查看" sureBlock:^{
                PGMeMessageVC *message = [[PGMeMessageVC alloc] init];
                [weakSelf.navigationController pushViewController:message animated:YES];
            } cancelBlock:nil];
        }
    } failure:^(NSString *error) {}];
}
#pragma mark --- action
- (void)PG_gotoPost {
    PGActivityPostActivityVC *postVC = [[PGActivityPostActivityVC alloc]init];
    [self.navigationController pushViewController:postVC animated:YES];
}
- (void)PG_pushQuestion {
    PGBaseWebViewVC *web = [[PGBaseWebViewVC alloc] init];
    web.urlString = [NSString stringWithFormat:@"https://app.zhundao.net/wenjuan/index.html?id=1479"];
    web.isClose = YES;
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:web animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}
- (void)PG_getEmail {
    NSString *userstr = [NSString stringWithFormat:@"%@api/v2/user/getUserInfo?token=%@",zhundaoApi,[[PGSignManager shareManager] getToken]];
    [ZD_NetWorkM getDataWithMethod:userstr parameters:nil succ:^(NSDictionary *obj) {
        if ([obj[@"errcode"] integerValue] == 0) {
            [PGUserManager.shareManager initWithDic:[obj[@"data"] deleteNullObj]];
            [[NSUserDefaults standardUserDefaults]setObject:@(ZD_UserM.gradeId) forKey:@"GradeId"];
            [[NSUserDefaults  standardUserDefaults]setObject:ZD_UserM.phone forKey:@"mobile"];
            [[NSUserDefaults standardUserDefaults]setObject:ZD_UserM.email forKey:@"email"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    } fail:^(NSError *error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self PG_getEmail];
        });
    }];
}
@end
