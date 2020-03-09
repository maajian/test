//
//  ConsultViewController.m
//  zhundao
//
//  Created by zhundao on 2017/8/3.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ConsultViewController.h"
#import "ConsultViewModel.h"
#import "ConsultTableViewCell.h"
#import "OneConsultViewController.h"
#import "CBHeaderChooseViewScrollView.h"
#import "MJNoDataScrollView.h"
@interface ConsultViewController ()<UITableViewDelegate,UITableViewDataSource>{
    Reachability *r;
}
/*! tableview */
@property(nonatomic,strong)UITableView *tableView;
/*! 显示出来的模型数组 */
@property(nonatomic,strong)NSMutableArray *dataArray;
/*! 控制器的viewmodel */
@property(nonatomic,strong)ConsultViewModel *viewModel;
/*! 高度数组 */
@property(nonatomic,strong)NSArray *heightArray;
/*! 时间数组 */
@property(nonatomic,strong)NSArray *timeArray;
/*! 未回复的数组 */
@property(nonatomic,strong)NSArray *notArray;
/*! 已经回复的数组 */
@property(nonatomic,strong)NSArray *hadArray;
/*! 全部内容的数组  */
@property(nonatomic,strong)NSArray *allArray;
/*! 下拉刷新 header */
@property(nonatomic,strong)MJRefreshNormalHeader *header;
/*! 滑块的index */
@property(nonatomic,assign)NSInteger selectIndex ;
/*! 空数据视图 */
@property(nonatomic,strong)MJNoDataScrollView *noDataView ;
@end

@implementation ConsultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self baseSetting];
    // Do any additional setup after loading the view.
}

#pragma mark -----基础设置

- (void)baseSetting
{
    _selectIndex = 0;
    self.title = @"咨询管理";
    [self createChoose];
    
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = ZDBackgroundColor;
    _viewModel = [[ConsultViewModel alloc]init];
    [self firstLoad];
    [self reflsh];
}

#pragma mark ----网络判断
- (void)firstLoad
{
    r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            [self notNet];
            break;
        case ReachableViaWWAN:
            // 使用3G网
            [self getAllConsult];
            break;
        case ReachableViaWiFi:
            // 使用WiFi网络
            [self getAllConsult];
            break;
    }
}

#pragma mark -----网络请求

- (void)getAllConsult
{
    NSDictionary *dic = @{@"Status":@"0",
                          @"ID":@(_acID),
                          @"title":@"",
                          @"pageSize":@"10000",
                          @"curPage":@"1"};
    __weak typeof(_viewModel) weakVM = _viewModel;
    __weak typeof(self) weakSelf = self;
    [self.viewModel getAllConsult:dic getAllBlock:^(NSArray *dataArray, NSArray *timeArray, NSArray *noAnswerArray, NSArray *hadAnswerArray) {
        _allArray = [dataArray copy];
        _hadArray = [hadAnswerArray copy];
        _notArray = [noAnswerArray copy];
        [weakSelf getDataArr];
        [[SignManager shareManager]saveData:dataArray name:[NSString stringWithFormat:@"allConsult%li",(long)self.acID]];
        [[SignManager shareManager]saveData:hadAnswerArray name:[NSString stringWithFormat:@"hadConsult%li",(long)self.acID]];
        [[SignManager shareManager]saveData:noAnswerArray name:[NSString stringWithFormat:@"notConsult%li",(long)self.acID]];
        _heightArray = [[weakVM getHeight:_dataArray]copy];
        _timeArray = [timeArray copy];
        [_tableView.mj_header endRefreshing];
        [weakSelf goTOLoadData];
    }];
}

- (void)notNet{
    _allArray = [[SignManager shareManager]getArray:[NSString stringWithFormat:@"allConsult%li",(long)self.acID]];
    _hadArray = [[SignManager shareManager]getArray:[NSString stringWithFormat:@"hadConsult%li",(long)self.acID]];
    _notArray = [[SignManager shareManager]getArray:[NSString stringWithFormat:@"notConsult%li",(long)self.acID]];
    [self getDataArr];
    [self goTOLoadData];
    
}

- (void)getDataArr {
    if (_selectIndex==0) _dataArray = [_notArray copy];
    else if (_selectIndex ==1) _dataArray = [_hadArray copy];
    else _dataArray = [_allArray copy];
}
- (void)goTOLoadData{
    if (_noDataView) {
        [_noDataView removeNoDataView];
    }
    if (_dataArray.count==0) {
        [self.tableView addSubview:self.noDataView];
    }else{
        [_tableView reloadData];
    }
}
#pragma mark ----下啦刷新

- (void)reflsh
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    __weak __typeof(self) weakSelf=self;
    
    _header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        if ((manager.networkReachabilityStatus==AFNetworkReachabilityStatusReachableViaWiFi||manager.networkReachabilityStatus==AFNetworkReachabilityStatusReachableViaWWAN)) {
            [weakSelf getAllConsult];
        }
        else{
            [weakSelf mj_headerStateWithState:MJRefreshStateNoMoreData WithHidden:YES Withinsert:0];
        }
    }];
    _tableView.mj_header = _header;
    [_header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [_header setTitle:@"释放刷新" forState:MJRefreshStatePulling];
    [_header setTitle:@"加载中，请等待 ..." forState:MJRefreshStateRefreshing];
    _header.lastUpdatedTimeLabel.hidden = YES;
}
- (void)mj_headerStateWithState:(MJRefreshState)state WithHidden:(BOOL)hidden Withinsert:(NSInteger)mj_insetT
{
    _tableView.mj_header.state = state;
    _tableView.mj_header.hidden = hidden;
    _tableView.mj_insetT=mj_insetT;
}
#pragma mark 懒加载

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth, kScreenHeight-64-40)];
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.backgroundColor = ZDBackgroundColor;
        _tableView.sectionHeaderHeight = 0.1;
        _tableView.sectionFooterHeight = 20;
        _tableView.estimatedRowHeight = 64;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        [_tableView registerNib:[UINib nibWithNibName:@"ConsultTableViewCell" bundle:nil] forCellReuseIdentifier:@"consultID"];
    }
    return _tableView;
}

- (MJNoDataScrollView *)noDataView{
    if (!_noDataView) {
        _noDataView = [[MJNoDataScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-40) imageName:@"空数据-5" topText:@"还没有人咨询留言哦" bottomText:@"刷新一下试试"];
    }
    return _noDataView;
}
#pragma mark -------UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *consultID = @"consultID";
    ConsultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:consultID];
    if (!cell) {
        cell = [[ConsultTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:consultID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.timeStr = self.timeArray[indexPath.row];
    cell.model = _dataArray[indexPath.row];
    return cell;
}
#pragma mark -------UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80+[_heightArray[indexPath.row] integerValue];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OneConsultViewController *one = [[OneConsultViewController alloc]init];
    one.model = _dataArray[indexPath.row];
    one.timeStr = _timeArray[indexPath.row];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:one animated:YES];
}

- (void)createChoose
{
    NSArray *array=@[
                     @"未回复",
                     @"已回复",
                     @"全 部",
                     ];
    CBHeaderChooseViewScrollView*headerView=[[CBHeaderChooseViewScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    [headerView setUpTitleArray:array titleColor:nil titleSelectedColor:nil titleFontSize:0];
    headerView.btnChooseClickReturn = ^(NSInteger x) {
        _selectIndex = x;
        switch (x) {
            case 0:  {              //未回复
                _dataArray = [_notArray copy];
                _heightArray = [[_viewModel getHeight:_dataArray]copy];
                [self goTOLoadData];
                break;
            }
            case 1:   {             //已回复
                _dataArray = [_hadArray copy];
                _heightArray = [[_viewModel getHeight:_dataArray]copy];
                [self goTOLoadData];
                break;
            }
            case 2:        {        //全部
                _dataArray = [_allArray copy];
                _heightArray = [[_viewModel getHeight:_dataArray]copy];
                [self goTOLoadData];
                break;
            }
            default:
                break;
        }
    };
    [self.view addSubview:headerView];
}
- (void)dealloc{
    NSLog(@"dealloc");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getAllConsult];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
