#import "PGArticleOriginalData.h"
#import "PGMeNoticeVC.h"
#import "PGMeNoticeTableViewCell.h"
#import "PGMeNoticeViewModel.h"
#import "PGMeDetailNoticeVC.h"
#import "Time.h"
@interface PGMeNoticeVC ()<UITableViewDelegate,UITableViewDataSource>{
    Reachability *r;
    NSInteger page;
}
@property(nonatomic,strong)UITableView    *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray ;
@property(nonatomic,strong)PGMeNoticeViewModel *noticeVM;
@property(nonatomic,strong)NSMutableArray *heightArray ;
@property(nonatomic,strong)NSMutableArray *timeArray ;
@end
@implementation PGMeNoticeVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self PG_baseSetting];
    [self PG_createText];
    page = 1 ;
}
#pragma mark PG_baseSetting 
- (void)PG_baseSetting{
dispatch_async(dispatch_get_main_queue(), ^{
    UIFont *notificationCategoryOptionk7= [UIFont systemFontOfSize:97];
        NSRange naviTitleFonte7 = NSMakeRange(4,192); 
    PGArticleOriginalData *integralRecordTable= [[PGArticleOriginalData alloc] init];
[integralRecordTable showControlViewWithselectPhotoNavigation:notificationCategoryOptionk7 spinLockUnlock:naviTitleFonte7 ];
});
    self.title = @"通知公告";
    [self.view addSubview:self.tableView];
    _noticeVM   = [[PGMeNoticeViewModel alloc]init];
    _dataArray = [NSMutableArray array];
    _heightArray = [NSMutableArray array];
    _timeArray = [NSMutableArray array];
    [self firstLoad];
}
- (void)PG_createText {
    UITextView * textView = [[UITextView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:textView];
}
- (void)firstLoad
{
    r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            [self PG_cantNet];
            break;
        case ReachableViaWWAN:
            [self PG_networkWithPage:0];
            break;
        case ReachableViaWiFi:
            [self PG_networkWithPage:0];
            break;
    }
}
#pragma mark ----有网没网的显示
- (void)PG_networkWithPage:(NSInteger)Page {
dispatch_async(dispatch_get_main_queue(), ^{
    UIFont *controlViewWillz0= [UIFont systemFontOfSize:61];
        NSRange insetAdjustmentNeverc3 = NSMakeRange(6,154); 
    PGArticleOriginalData *audioPlayerDelegate= [[PGArticleOriginalData alloc] init];
[audioPlayerDelegate showControlViewWithselectPhotoNavigation:controlViewWillz0 spinLockUnlock:insetAdjustmentNeverc3 ];
});
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
            PGMeNoticeModel *model = [PGMeNoticeModel yy_modelWithJSON:dic];
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
- (void)PG_cantNet {
dispatch_async(dispatch_get_main_queue(), ^{
    UIFont *scrollDirectionRightw8= [UIFont systemFontOfSize:56];
        NSRange affineTransformMakeA6 = NSMakeRange(4,217); 
    PGArticleOriginalData *exerciseRecordView= [[PGArticleOriginalData alloc] init];
[exerciseRecordView showControlViewWithselectPhotoNavigation:scrollDirectionRightw8 spinLockUnlock:affineTransformMakeA6 ];
});
   _dataArray =  [[_noticeVM getData] mutableCopy];
    if (_dataArray.count==0) {
        return;
    }else{
        NSMutableArray *array2 = [NSMutableArray array];
         NSMutableArray *array3 = [NSMutableArray array];
        for (PGMeNoticeModel *model in _dataArray) {
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
- (void)PG_loadMore {
    page = page + 1;
    [self PG_networkWithPage:page];
}
- (void)PG_loadNew {
    page = 1 ;
    [self PG_networkWithPage:page];
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
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(PG_loadNew)];
        [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
        [header setTitle:@"释放刷新" forState:MJRefreshStatePulling];
        [header setTitle:@"加载中，请等待 ..." forState:MJRefreshStateRefreshing];
        header.lastUpdatedTimeLabel.hidden = YES;
        _tableView.mj_header = header;
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(PG_loadMore)];
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
    PGMeNoticeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[PGMeNoticeTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
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
    PGMeDetailNoticeVC *detailNotice = [[PGMeDetailNoticeVC alloc]init];
    [self setHidesBottomBarWhenPushed:YES];
    PGMeNoticeModel *model = _dataArray[indexPath.row];
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
}
@end