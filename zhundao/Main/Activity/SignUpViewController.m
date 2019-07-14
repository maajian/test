//
//  SignUpViewController.m
//  zhundao
//
//  Created by xhkj on 2018/4/24.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import "SignUpViewController.h"

#import "SignUpView.h"
#import "SGTopTitleView.h"

#import "SignUpViewModel.h"

@interface SignUpViewController ()<SGTopTitleViewDelegate> {
    NSInteger _oriIndex;
}
/*! viewmodel */
@property (nonatomic, strong) SignUpViewModel *viewModel;
/*! 界面 */
@property (nonatomic , strong) SignUpView *signUpView;
/*! 时间类型 */
@property (nonatomic, assign) DateType dataType;
/*! 开始时间 */
@property (nonatomic, strong) NSString *beginTime;
/*! 结束时间 */
@property (nonatomic, strong) NSString *endTime;
/*! 时间格式 */
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
/*! 顶部点击 */
@property (nonatomic, strong) SGTopTitleView *titleView;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*! 初始化 */
    _oriIndex = 0;
    self.dataType = DateTypeWeek;
    
    /*! 添加控件 */
    if (_chartType != ChartTypePay) {
        [self.view addSubview:self.titleView];
    }
    
    /*! 网络请求 */
    [self network];
    
}

#pragma mark --- 网络请求
- (void)network {
    
    JQIndicatorView *indicator = [[JQIndicatorView alloc]initWithType:3 tintColor: [UIColor colorWithRed:9.00f/255.0f green:187.00f/255.0f blue:7.00f/255.0f alpha:1] size:CGSizeMake(90, 70)];
    indicator.center = self.view.center;
    [self.view addSubview:indicator];
    [indicator startAnimating];
    
    __weak typeof(self) weakSelf = self;
    /*! 报名统计请求 */
    if (_chartType == ChartTypeActivityPerson) {
        [self.viewModel getActivityListDate:_activityId beginDate:_beginTime endDate:_endTime successBlock:^{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.signUpView removeFromSuperview];
                 self.signUpView = nil;
                [self.view addSubview:self.signUpView];
            });
            
            [indicator stopAnimating];
        } failBlock:^(NSString *error) {
            [indicator stopAnimating];
        }];
    }
    
    /*! 浏览人数请求 */
    else if (_chartType == ChartTypeRead) {
        [self.viewModel getActivityReadDate:_activityId beginDate:_beginTime endDate:_endTime successBlock:^{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.signUpView removeFromSuperview];
                self.signUpView = nil;
                [self.view addSubview:self.signUpView];
            });
            
            [indicator stopAnimating];
        } failBlock:^(NSString *error) {
            [indicator stopAnimating];
        }];
    }
    
    /*! 收入请求 */
    else {
        [self.viewModel getFeePeopleNoDate:_activityId successBlock:^{
            __strong typeof(self) strongSelf = weakSelf;
            [strongSelf.viewModel getEachFeeDate:weakSelf.activityId successBlock:^{
            
                [indicator stopAnimating];
                dispatch_async(dispatch_get_main_queue(), ^{
                    strongSelf.signUpView = [[SignUpView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) personArray:strongSelf.viewModel.personCountArray comeInArray:strongSelf.viewModel.dataArray];
                    [strongSelf.view addSubview:strongSelf.signUpView];
                });
                
            } failBlock:^(NSString *error) {
                [indicator stopAnimating];
            }];
            
        } failBlock:^(NSString *error) {
            [indicator stopAnimating];
            maskLabel *label = [[maskLabel alloc] initWithTitle:error];
            [label labelAnimationWithViewlong:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }];
    }
}

#pragma mark --- 懒加载
/*! 时间格式化 */
- (NSDateFormatter *)dateFormatter{
    if (!_dateFormatter) {
        _dateFormatter =[[NSDateFormatter alloc]init];
        _dateFormatter.dateFormat = @"YYYY-MM-dd";
    }
    return _dateFormatter;
}

/*! viewmodel */
- (SignUpViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[SignUpViewModel alloc] init];
    }
    return _viewModel;
}

/*! 滑动视图 */
- (SGTopTitleView *)titleView {
    if (!_titleView) {
        _titleView = [SGTopTitleView topTitleViewWithFrame:CGRectMake(0, 0, kScreenWidth, 47)];
        _titleView.staticTitleArr = @[@"7天",@"15天",@"30天"];
        _titleView.delegate_SG = self;
    }
    return _titleView;
}

- (SignUpView *)signUpView {
    if (!_signUpView) {
        _signUpView = [[SignUpView alloc]
                       initWithFrame:CGRectMake(0, 47, kScreenWidth, kScreenHeight - 64 - 47) xLabels:self.viewModel.xLabelArray dataArray:self.viewModel.dataArray title:(_chartType == ChartTypeActivityPerson) ? @"报名统计" : (_chartType == ChartTypeRead) ? @"浏览统计" : @"收入统计"];
    }
    return _signUpView;
}

#pragma mark --- SGTopTitleViewDelegate
- (void)SGTopTitleView:(SGTopTitleView *)topTitleView didSelectTitleAtIndex:(NSInteger)index {
    /*! 相等退出 */
    if (_oriIndex == index) {
        return;
    } else {
        _oriIndex = index;
    }
    
    /*! 点击事件 */
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
            /*! 一周 */
        case DateTypeWeek: {
            _endTime = [self.dateFormatter stringFromDate:[NSDate dateWithTimeInterval:24*60*60 sinceDate:[NSDate date]]];
            _beginTime = [self.dateFormatter stringFromDate:[NSDate dateWithTimeInterval:-24*60*60*6 sinceDate:[NSDate date]]];
            
            break;
        }
            
            /*! 15天 */
        case DateTypeFifteenDay: {
            _endTime = [self.dateFormatter stringFromDate:[NSDate dateWithTimeInterval:24*60*60 sinceDate:[NSDate date]]];
            _beginTime = [self.dateFormatter stringFromDate:[NSDate dateWithTimeInterval:-24*60*60*14 sinceDate:[NSDate date]]];
            
            break;
        }
            
            /*! 半个月 */
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
    // Dispose of any resources that can be recreated.
}


@end
