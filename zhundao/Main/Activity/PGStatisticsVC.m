#import "PGAssetsWithOptions.h"
#import "PGStatisticsVC.h"
#import "PGStatisticsTopView.h"
#import "PGStatisticsBottomView.h"
#import "PGStatisticsModel.h"
@interface PGStatisticsVC ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) PGStatisticsTopView *topView;
@property (nonatomic, strong) PGStatisticsBottomView *bottomView;
@property (nonatomic, strong) NSMutableArray<PGStatisticsModel *> *dataSource;
@end
@implementation PGStatisticsVC
ZDGetter_MutableArray(dataSource)
- (void)viewDidLoad {
    [super viewDidLoad];
    [self PG_initSet];
    [self PG_initLayout];
    [self PG_networkForStatistics];
}
#pragma mark --- Lazyload
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
    }
    return _scrollView;
}
- (PGStatisticsTopView *)topView {
    if (!_topView) {
        _topView = [[PGStatisticsTopView alloc] init];
    }
    return _topView;
}
- (PGStatisticsBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[PGStatisticsBottomView alloc] init];
    }
    return _bottomView;
}
#pragma mark --- Init
- (void)PG_initSet {
    self.title = @"报名统计";
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.topView];
    [self.scrollView addSubview:self.bottomView];
}
- (void)PG_initLayout {
dispatch_async(dispatch_get_main_queue(), ^{
    UISlider *remoteNotificationsWithX8= [[UISlider alloc] initWithFrame:CGRectZero]; 
    remoteNotificationsWithX8.minimumValue = 0; 
    remoteNotificationsWithX8.maximumValue = 100; 
    remoteNotificationsWithX8.value =44; 
        CGPoint imageTextureDelegateq4 = CGPointZero;
    PGAssetsWithOptions *bundleDisplayName= [[PGAssetsWithOptions alloc] init];
[bundleDisplayName textFieldViewWithpresetsCompatibleWith:remoteNotificationsWithX8 calendarUnitYear:imageTextureDelegateq4 ];
});
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.equalTo(self.scrollView);
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_equalTo(165);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom).offset(10);
        make.leading.equalTo(self.scrollView);
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_equalTo(200);
    }];
}
#pragma mark --- Network
- (void)PG_networkForStatistics {
    ZD_HUD_SHOW_WAITING
    ZD_WeakSelf
    NSString *url = [NSString stringWithFormat:@"%@jinTaData?token=%@", zhundaoLogApi, ZD_UserM.token];
    NSDictionary *dic = @{@"BusinessCode": @"GetActivityDepartDate",
                          @"Data" : @{
                                  @"ActivityId": @(self.moreModel.ID),
                         }
    };
    [ZD_NetWorkM postDataWithMethod:url parameters:dic succ:^(NSDictionary *obj) {
        ZD_HUD_DISMISS
        [weakSelf.dataSource removeAllObjects];
        weakSelf.moreModel.total = ZD_SafeIntValue(obj[@"data"][@"total"]);
        weakSelf.moreModel.yesterday = ZD_SafeIntValue(obj[@"data"][@"yesterday"]);
        for (NSDictionary *dic in obj[@"data"][@"list"]) {
            PGStatisticsModel *model = [PGStatisticsModel yy_modelWithJSON:dic];
            [weakSelf.dataSource addObject:model];
        }
        weakSelf.topView.moreModel = weakSelf.moreModel;
        weakSelf.bottomView.dataSource = weakSelf.dataSource.mutableCopy;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo((weakSelf.dataSource.count + 1) * 44 + 50);
            }];
            [weakSelf.view layoutIfNeeded];
            weakSelf.scrollView.contentSize = CGSizeMake(kScreenWidth, CGRectGetMaxY(weakSelf.bottomView.frame) + 20);
        });
    } fail:^(NSError *error) {
        ZD_HUD_SHOW_ERROR(error)
    }];
}
@end
