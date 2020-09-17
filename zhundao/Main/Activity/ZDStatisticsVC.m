//
//  ZDStatisticsVC.m
//  jingjing
//
//  Created by maj on 2020/9/16.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "ZDStatisticsVC.h"

#import "ZDStatisticsTopView.h"
#import "ZDStatisticsBottomView.h"

#import "ZDStatisticsModel.h"

@interface ZDStatisticsVC ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) ZDStatisticsTopView *topView;
@property (nonatomic, strong) ZDStatisticsBottomView *bottomView;
@property (nonatomic, strong) NSMutableArray<ZDStatisticsModel *> *dataSource;

@end

@implementation ZDStatisticsVC
ZDGetter_MutableArray(dataSource)

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initSet];
    [self initLayout];
    [self networkForStatistics];
}

#pragma mark --- Lazyload
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
    }
    return _scrollView;
}
- (ZDStatisticsTopView *)topView {
    if (!_topView) {
        _topView = [[ZDStatisticsTopView alloc] init];
    }
    return _topView;
}
- (ZDStatisticsBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[ZDStatisticsBottomView alloc] init];
    }
    return _bottomView;
}

#pragma mark --- Init
- (void)initSet {
    self.title = @"报名统计";
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.topView];
    [self.scrollView addSubview:self.bottomView];
}
- (void)initLayout {
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
- (void)networkForStatistics {
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
            ZDStatisticsModel *model = [ZDStatisticsModel yy_modelWithJSON:dic];
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
