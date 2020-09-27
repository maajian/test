#import "PGTitleViewWith.h"
#import "PGMePromoteMainVC.h"
#import "PGMePromoteShareVC.h"
#import "PGMePromoteCustomContactVC.h"
#import "PGMePromoteBottomView.h"
@interface PGMePromoteMainVC ()<PGMePromoteBottomViewDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) PGMePromoteShareVC *shareVC;
@property (nonatomic, strong) PGMePromoteCustomContactVC *contactVC;
@property (nonatomic, strong) PGMePromoteBottomView *bottomView;
@property (nonatomic, strong) UIScrollView *scrollView;
@end
@implementation PGMePromoteMainVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self PG_initSet];
    [self PG_initLayout];
}
#pragma mark 懒加载
- (PGMePromoteBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[PGMePromoteBottomView alloc] init];
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
- (void)PG_initSet {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = ZDBackgroundColor;
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.scrollView];
    self.title = @"准到合伙人";
    _shareVC = [[PGMePromoteShareVC alloc] init];
    _contactVC = [[PGMePromoteCustomContactVC alloc] init];
    [self addChildViewController:_shareVC];
    [self addChildViewController:_contactVC];
    [self.scrollView addSubview:_contactVC.view];
}
- (void)PG_initLayout {
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
#pragma mark --- PGMePromoteBottomViewDelegate
- (void)promoteBottomView:(PGMePromoteBottomView *)promoteBottomView didSelectMainButton:(UIButton *)button {
dispatch_async(dispatch_get_main_queue(), ^{
    UIButtonType integralRecordViewN5 = UIButtonTypeContactAdd;
        UIEdgeInsets imageSourceCopyO5 = UIEdgeInsetsZero;
    PGTitleViewWith *recordModeNormal= [[PGTitleViewWith alloc] init];
[recordModeNormal delegateMethodWithWithclippingWithView:integralRecordViewN5 photoPickerCollection:imageSourceCopyO5 ];
});
    self.title = @"准到合伙人";
     [_scrollView setContentOffset:CGPointMake(0, 0)];
}
- (void)promoteBottomView:(PGMePromoteBottomView *)promoteBottomView didSelectShareButton:(UIButton *)button {
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
