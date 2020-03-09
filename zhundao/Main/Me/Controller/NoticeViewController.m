//
//  NoticeViewController.m
//  zhundao
//
//  Created by zhundao on 2017/8/15.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "NoticeViewController.h"
#import "NoticeTableViewCell.h"
#import "NoticeViewModel.h"
#import "DetailNoticeViewController.h"
#import "Time.h"
@interface NoticeViewController ()<UITableViewDelegate,UITableViewDataSource>{
    Reachability *r;
    NSInteger page;
}
/*! tableView */
@property(nonatomic,strong)UITableView    *tableView;
/*! 数据源数组 */
@property(nonatomic,strong)NSMutableArray *dataArray ;
/*! ViewModel */
@property(nonatomic,strong)NoticeViewModel *noticeVM;
/*! 高度数据 */
@property(nonatomic,strong)NSMutableArray *heightArray ;
/*! 时间数组 */
@property(nonatomic,strong)NSMutableArray *timeArray ;

@end

@implementation NoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self baseSetting];
    [self createText];
    page = 1 ;
    // Do any additional setup after loading the view.
}
#pragma mark baseSetting 

- (void)baseSetting{
    self.title = @"通知公告";
    [self.view addSubview:self.tableView];
    _noticeVM   = [[NoticeViewModel alloc]init];
    _dataArray = [NSMutableArray array];
    _heightArray = [NSMutableArray array];
    _timeArray = [NSMutableArray array];
    [self firstLoad];
}
- (void)createText {
    UITextView * textView = [[UITextView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:textView];
}
- (void)firstLoad
{
    r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            [self cantNet];
            break;
        case ReachableViaWWAN:
            // 使用3G网
            [self networkWithPage:0];
            break;
        case ReachableViaWiFi:
            // 使用WiFi网络
            [self networkWithPage:0];
            break;
    }
}

#pragma mark ----有网没网的显示
/*! 有网 */
- (void)networkWithPage:(NSInteger)Page {
    __weak typeof(_noticeVM) weakVM = _noticeVM;
    JQIndicatorView *indicator = [[JQIndicatorView alloc]initWithType:3 tintColor: [UIColor colorWithRed:9.00f/255.0f green:187.00f/255.0f blue:7.00f/255.0f alpha:1] size:CGSizeMake(90, 70)];
        indicator.center = self.view.center;
        [self.view addSubview:indicator];
        [indicator startAnimating];
    [self.noticeVM netWorkWithPage:Page Block:^(NSArray *array) {
        if (Page == 1) {
            [_dataArray removeAllObjects];
            [_heightArray removeAllObjects];
            [_timeArray removeAllObjects];
        }
        [indicator stopAnimating];
        
        NSMutableArray *array2 = [NSMutableArray array];
        NSMutableArray *array1  = [NSMutableArray array];
        NSMutableArray *array3 = [NSMutableArray array];
        for (NSDictionary *dic in array) {
            NoticeModel *model = [NoticeModel yy_modelWithJSON:dic];
            [array1 addObject:model];
            CGSize size = [model.Title boundingRectWithSize:CGSizeMake(kScreenWidth- 12 - 28, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14] }context:nil].size;
            [array2 addObject:@(size.height)];
            Time *time = [Time bringWithTime:model.AddTime];
            [array3 addObject:time.timeStr];
        }
        [_dataArray addObjectsFromArray:array1];
        [_heightArray addObjectsFromArray:array2];
        [_timeArray addObjectsFromArray:array3];
        [_tableView reloadData];
        [weakVM sava:_dataArray];
        [weakVM saveTime:_dataArray.firstObject];
        
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];
    }];

}
/*! 没网 */
- (void)cantNet {
   _dataArray =  [[_noticeVM getData] mutableCopy];
    if (_dataArray.count==0) {
        return;
    }else{
        NSMutableArray *array2 = [NSMutableArray array];
         NSMutableArray *array3 = [NSMutableArray array];
        for (NoticeModel *model in _dataArray) {
            CGSize size = [model.Title boundingRectWithSize:CGSizeMake(kScreenWidth- 12 - 28, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14] }context:nil].size;
            [array2 addObject:@(size.height)];
            Time *time = [Time bringWithTime:model.AddTime];
            [array3 addObject:time.timeStr];
        }
        _heightArray = [array2 copy];
        _timeArray = [array3 copy];
        [_tableView reloadData];
    }
}

#pragma mark 上拉加载

- (void)loadMore {
    page = page + 1;
    [self networkWithPage:page];
}

- (void)loadNew {
    page = 1 ;
    [self networkWithPage:page];
}

#pragma mark 懒加载

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.sectionHeaderHeight = 0.1;
        _tableView.sectionFooterHeight = 0.1;
        _tableView.estimatedRowHeight = 40 + 20 ;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.backgroundColor = ZDBackgroundColor;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNew)];
        [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
        [header setTitle:@"释放刷新" forState:MJRefreshStatePulling];
        [header setTitle:@"加载中，请等待 ..." forState:MJRefreshStateRefreshing];
        header.lastUpdatedTimeLabel.hidden = YES;
        _tableView.mj_header = header;
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
        _tableView.mj_footer = footer;
    }
    return _tableView;
}


#pragma mark -------UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"noticeID";
    NoticeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[NoticeTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.timeText = _timeArray[indexPath.row];
    cell.model = _dataArray[indexPath.row];
    return cell;
}

#pragma mark -------UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 38 +[_heightArray[indexPath.row] integerValue];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailNoticeViewController *detailNotice = [[DetailNoticeViewController alloc]init];
    [self setHidesBottomBarWhenPushed:YES];
    NoticeModel *model = _dataArray[indexPath.row];
    detailNotice.detail =model.Detail;
    detailNotice.detailTitle = model.Title;
    detailNotice.ID = model.ID;
    detailNotice.time = _timeArray[indexPath.row];
    [self.navigationController pushViewController:detailNotice animated:YES];
    detailNotice.isLoadBlock = ^(BOOL isload) {
        if (isload) {
            [_tableView reloadData];
        }
    };
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)dealloc{
    NSLog(@"%@", [NSString stringWithFormat:@"%@dealloc",self.title]);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
