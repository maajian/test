#import "PGMessageWithText.h"
#import "PGAvtivitySignUpVC.h"
#import "PGAvtivitySignUpView.h"
#import "SGTopTitleView.h"
#import "PGAvtivitySignUpViewModel.h"
@interface PGAvtivitySignUpVC ()<SGTopTitleViewDelegate> {
    NSInteger _oriIndex;
}
@property (nonatomic, strong) PGAvtivitySignUpViewModel *viewModel;
@property (nonatomic , strong) PGAvtivitySignUpView *signUpView;
@property (nonatomic, assign) DateType dataType;
@property (nonatomic, strong) NSString *beginTime;
@property (nonatomic, strong) NSString *endTime;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) SGTopTitleView *titleView;
@end
@implementation PGAvtivitySignUpVC
- (void)viewDidLoad {
dispatch_async(dispatch_get_main_queue(), ^{
    CGSize naviTitleAppearancet2 = CGSizeZero;
        CGPoint assetCellTypeC3 = CGPointZero;
    PGMessageWithText *handpickViewModel= [[PGMessageWithText alloc] init];
[handpickViewModel textAlignmentCenterWithassetResourceType:naviTitleAppearancet2 contentBackgroundColor:assetCellTypeC3 ];
});
    [super viewDidLoad];
    _oriIndex = 0;
    self.dataType = DateTypeWeek;
    if (_chartType != ChartTypePay) {
        [self.view addSubview:self.titleView];
    }
    [self network];
}
#pragma mark --- 网络请求
- (void)network {
    JQIndicatorView *indicator = [[JQIndicatorView alloc]initWithType:3 tintColor: [UIColor colorWithRed:9.00f/255.0f green:187.00f/255.0f blue:7.00f/255.0f alpha:1] size:CGSizeMake(90, 70)];
    indicator.center = self.view.center;
    [self.view addSubview:indicator];
    [indicator startAnimating];
    __weak typeof(self) weakSelf = self;
    if (_chartType == ChartTypeActivityPerson) {
        [self.viewModel getActivityListDate:_activityId beginDate:_beginTime endDate:_endTime successBlock:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.signUpView removeFromSuperview];
                 self.signUpView = nil;
                [self.view addSubview:self.PG_PGAvtivitySignUpView];
            });
            [indicator stopAnimating];
        } failBlock:^(NSString *error) {
            ZD_HUD_SHOW_ERROR_STATUS(error)
            [indicator stopAnimating];
        }];
    }
    else if (_chartType == ChartTypeRead) {
        [self.viewModel getActivityReadDate:_activityId beginDate:_beginTime endDate:_endTime successBlock:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.signUpView removeFromSuperview];
                self.signUpView = nil;
                [self.view addSubview:self.PG_PGAvtivitySignUpView];
            });
            [indicator stopAnimating];
        } failBlock:^(NSString *error) {
            [indicator stopAnimating];
        }];
    }
    else {
        [self.viewModel getFeePeopleNoDate:_activityId successBlock:^{
            __strong typeof(self) strongSelf = weakSelf;
            [strongSelf.viewModel getEachFeeDate:weakSelf.activityId successBlock:^{
                [indicator stopAnimating];
                dispatch_async(dispatch_get_main_queue(), ^{
                    strongSelf.signUpView = [[PGAvtivitySignUpView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) personArray:strongSelf.viewModel.personCountArray comeInArray:strongSelf.viewModel.dataArray];
                    [strongSelf.view addSubview:strongSelf.PG_PGAvtivitySignUpView];
                });
            } failBlock:^(NSString *error) {
                [indicator stopAnimating];
            }];
        } failBlock:^(NSString *error) {
            [indicator stopAnimating];
            PGMaskLabel *label = [[PGMaskLabel alloc] initWithTitle:error];
            [label labelAnimationWithViewlong:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }];
    }
}
#pragma mark --- 懒加载
- (NSDateFormatter *)dateFormatter{
    if (!_dateFormatter) {
        _dateFormatter =[[NSDateFormatter alloc]init];
        _dateFormatter.dateFormat = @"YYYY-MM-dd";
    }
    return _dateFormatter;
}
- (PGAvtivitySignUpViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[PGAvtivitySignUpViewModel alloc] init];
    }
    return _viewModel;
}
- (SGTopTitleView *)titleView {
    if (!_titleView) {
        _titleView = [SGTopTitleView topTitleViewWithFrame:CGRectMake(0, 0, kScreenWidth, 47)];
        _titleView.staticTitleArr = @[@"7天",@"15天",@"30天"];
        _titleView.delegate_SG = self;
    }
    return _titleView;
}
- (PGAvtivitySignUpView *)PG_PGAvtivitySignUpView {
    if (!_signUpView) {
        _signUpView = [[PGAvtivitySignUpView alloc]
                       initWithFrame:CGRectMake(0, 47, kScreenWidth, kScreenHeight - 64 - 47) xLabels:self.viewModel.xLabelArray dataArray:self.viewModel.dataArray title:(_chartType == ChartTypeActivityPerson) ? @"报名统计" : (_chartType == ChartTypeRead) ? @"浏览统计" : @"收入统计"];
    }
    return _signUpView;
}
#pragma mark --- SGTopTitleViewDelegate
- (void)titleViewDidSelectTitleAtIndex:(NSInteger)index {
    if (_oriIndex == index) {
        return;
    } else {
        _oriIndex = index;
    }
    switch (index) {
        case 0:
            self.dataType = DateTypeWeek;
            break;
        case 1:
            self.dataType = DateTypeFifteenDay;
            break;
        case 2:
            self.dataType = DateTypeMonth;
            break;
        default:
            break;
    }
    [self network];
}
#pragma mark --- 存取器重写
- (void)setDataType:(DateType)dataType {
    _dataType = dataType;
    switch (dataType) {
        case DateTypeWeek: {
            _endTime = [self.dateFormatter stringFromDate:[NSDate dateWithTimeInterval:24*60*60 sinceDate:[NSDate date]]];
            _beginTime = [self.dateFormatter stringFromDate:[NSDate dateWithTimeInterval:-24*60*60*6 sinceDate:[NSDate date]]];
            break;
        }
        case DateTypeFifteenDay: {
            _endTime = [self.dateFormatter stringFromDate:[NSDate dateWithTimeInterval:24*60*60 sinceDate:[NSDate date]]];
            _beginTime = [self.dateFormatter stringFromDate:[NSDate dateWithTimeInterval:-24*60*60*14 sinceDate:[NSDate date]]];
            break;
        }
        case DateTypeMonth: {
            _endTime = [self.dateFormatter stringFromDate:[NSDate dateWithTimeInterval:24*60*60 sinceDate:[NSDate date]]];
            _beginTime = [self.dateFormatter stringFromDate:[NSDate dateWithTimeInterval:-24*60*60*29 sinceDate:[NSDate date]]];
            break;
        }
        default:
            break;
    }
}
#pragma mark --- 视图生命周期
- (void)viewWillAppear:(BOOL)animated {
dispatch_async(dispatch_get_main_queue(), ^{
    CGSize withRootViewl0 = CGSizeMake(216,54); 
        CGPoint trackingWithTouchK0 = CGPointZero;
    PGMessageWithText *pickerImageView= [[PGMessageWithText alloc] init];
[pickerImageView textAlignmentCenterWithassetResourceType:withRootViewl0 contentBackgroundColor:trackingWithTouchK0 ];
});
    [super viewWillAppear:animated];
    switch (_chartType) {
        case ChartTypeActivityPerson:
            self.title = @"报名统计";
            break;
        case ChartTypeRead:
            self.title = @"浏览统计";
            break;
        case ChartTypePay:
            self.title = @"收入统计";
            break;
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
