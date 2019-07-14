//
//  ActivityViewController.m
//  zhundao
//
//  Created by zhundao on 2016/12/2.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import "ActivityViewController.h"
#import "ActivityCell.h"
#import "editViewController.h"
#import "UIView+TYAlertView.h"
#import "TYAlertController+BlurEffects.h"
#import "ListViewController.h"
#import "NewActivityViewController.h"
#import "AppDelegate.h"
#import "detailActivityViewController.h"
#import "NewView.h"
#import "moreModalViewController.h"
#import <UMSocialCore/UMSocialCore.h>
#import <UShareUI/UShareUI.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "WXApi.h"
#import "PostSign.h"
#import "oneActivityViewController.h"
#import "postActivityViewController.h"
#import "ActivityViewModel.h"
#import "SearchViewController.h"
#import "ConsultActivitySocket.h"
#import "isReadView.h"

@interface ActivityViewController ()<UITableViewDelegate,UITableViewDataSource>
{   ActivityCell *mycell;
    NSInteger flag;
    NSInteger xiala;
    NSMutableArray *postArray;
    Reachability *r;
    MJRefreshNormalHeader *header;
   
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmented;
@property(nonatomic,strong)ActivityViewModel *activityVM;
/*! 多选弹出的视图 */
@property(nonatomic,strong)isReadView *readView;
@property (nonatomic, strong) NSMutableArray<ActivityModel *> *dataArray;
@property (nonatomic, strong) NSMutableArray<ActivityModel *> *dataArray1;
@property(nonatomic,strong)ConsultActivitySocket *socket;
 @end

@implementation ActivityViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITextView * textView = [[UITextView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:textView];
    
    flag=0;
    [self getPage];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem activityAddItemWithTarget:self action:@selector(pushAddActivity)];
    
    [_segmented addTarget:self action:@selector(segmentedAction:) forControlEvents:UIControlEventValueChanged];
    [_tableview registerNib:[UINib nibWithNibName:@
                             "ActivityCell" bundle:nil]
     forCellReuseIdentifier:@"ActivityCellID"];
    _tableview.separatorStyle = NO;
    _tableview.backgroundColor = [UIColor clearColor];
    self.tableview.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-150);
    self.tableview.mj_header = [ZDRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.tableview.mj_footer = [ZDRefreshNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadmoreData)];
    
    [self firstLoad];
     [self.tableview.mj_header beginRefreshing];
    BOOL isShowGuide = [[[NSUserDefaults alloc]init] boolForKey:[NSString stringWithFormat:@"guide_%@",kAPPVERSION]];
    if (!isShowGuide) {
        [self loadData];
         [self createView];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:@"changeaAccount" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:@"loadList" object:nil];
}

#pragma mark --- 懒加载
-(ActivityViewModel *)activityVM
{
    if (!_activityVM) {
        _activityVM =[[ ActivityViewModel alloc]init];
    }
    return _activityVM;
}

- (NSMutableArray<ActivityModel *> *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (NSMutableArray<ActivityModel *> *)dataArray1 {
    if (!_dataArray1) {
        _dataArray1 = [NSMutableArray array];
    }
    return _dataArray1;
}


#pragma mark -- network 网络判断

- (void)firstLoad {
    r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable: {
            id object = [[ZDCache sharedCache] cacheForKey:@"activity"];
            if (object) {
                NSArray *temp = (NSArray *)[[ZDCache sharedCache] cacheForKey:@"activity"];
                [self dealDataWithArray:temp];
                [_tableview reloadData];
            }
            break;
        }
        case ReachableViaWWAN:
        case ReachableViaWiFi:
            // 使用3G网
            [[PostSign alloc]postWithstr:@"signList"];
            [self loadData];
            break;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_tableview reloadData];
}

#pragma mark ---  引导视图创建
- (void)createView
{
    NewView  *view = [[NewView alloc]initWithTitle:@"点击发起活动"];
     AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    view.frame = appDelegate.window.frame;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenView:)];
    [view addGestureRecognizer:tap];
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-48, 20,44, 44)];
    label1.layer.cornerRadius = 22;
    label1.layer.masksToBounds = YES;
    label1.layer.borderWidth =1;
    label1.layer.borderColor = [[UIColor whiteColor]CGColor];
    [view addSubview:label1];
    [appDelegate.window addSubview:view];
}

- (void)hiddenView:(UITapGestureRecognizer *)tap {
    NewView *view = (NewView *)tap.view;
    [view removeFromSuperview];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:[NSString stringWithFormat:@"guide_%@",kAPPVERSION]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark ---- 右部发起活动 和 搜索
- (void)pushAddActivity
{
    if ([[  NSUserDefaults standardUserDefaults  ]objectForKey:@"GradeId"]) {
        NSInteger grade =  [[[  NSUserDefaults standardUserDefaults  ]objectForKey:@"GradeId"]integerValue];
        if (grade <= 1) {
            __weak typeof(self) weakSelf = self;
            [self.activityVM checkIsCanpost:^(id responseObject) {
                if ([responseObject[@"Res"] integerValue] == 0) {
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
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:postVC animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}

- (void)searchActivity{
    SearchViewController *search = [[SearchViewController alloc]init];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:search animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}

#pragma  mark ---- 判断是否需要刷新网络数据

#pragma mark ----  segmented 按钮切换
- (void)segmentedAction:(UISegmentedControl *)seg{
    flag = seg.selectedSegmentIndex;
    [_tableview reloadData];
}
//网络加载数据
- (void)loadmoreData {
    xiala += 1;
    [self savePage];
    NSString *xialaStr = [NSString stringWithFormat:@"%li",(long)xiala];
    NSString *listurl = [NSString stringWithFormat:@"%@api/v2/activity/getActivities?token=%@",zhundaoApi,[[SignManager shareManager] getToken]];
    AFHTTPSessionManager *manager = [AFmanager shareManager];
    NSDictionary *dic = @{@"Type":@"0",
                          @"pageSize":@"10",
                          @"pageIndex":xialaStr};
    [manager POST:listurl parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableArray *moreArray = [NSMutableArray array];
        [moreArray addObjectsFromArray:(NSArray *)[[ZDCache sharedCache] cacheForKey:@"activity"]];
        [moreArray addObjectsFromArray:responseObject[@"data"]];
        [[ZDCache sharedCache] setCache:moreArray forKey:@"activity"];
        [self dealDataWithArray:responseObject[@"data"]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableview.mj_header endRefreshing];
        self.tableview.mj_footer.state = MJRefreshStateIdle;
        [[SignManager shareManager] showNotHaveNet:self.view];
    }];
}

// 网络加载数据
- (void)loadData {
    xiala=1;
    [self savePage];
    NSString *listurl = [NSString stringWithFormat:@"%@api/v2/activity/getActivities?token=%@",zhundaoApi,[[SignManager shareManager] getToken]];
    AFmanager *manager = [AFmanager shareManager];
    NSDictionary *dic = @{@"Type":@"0",
                          @"pageSize":@"10",
                          @"pageIndex":@"1"};
    [manager POST:listurl parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[ZDCache sharedCache] setCache:responseObject[@"data"] forKey:@"activity"];
        [self.dataArray removeAllObjects];
        [self.dataArray1 removeAllObjects];
        [self dealDataWithArray:responseObject[@"data"]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableview.mj_header endRefreshing];
        self.tableview.mj_footer.state = MJRefreshStateIdle;
        [[SignManager shareManager] showNotHaveNet:self.view];
    }];
}

- (void)dealDataWithArray:(NSArray *)array {
    for (NSDictionary *acdic in array) {
        ActivityModel *model = [ActivityModel yy_modelWithJSON:acdic];
        if (model.Status==2) {
            [self.dataArray1 addObject:model];
        } else {
            [self.dataArray addObject:model];
        }
    }
    [self.tableview.mj_header endRefreshing];
    self.tableview.mj_footer.state = MJRefreshStateIdle;
    [_tableview reloadData];
}

- (void)savePage {
    [[NSUserDefaults standardUserDefaults] setInteger:xiala forKey:@"activityPage"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)getPage {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"activityPage"]) {
        xiala = [[[NSUserDefaults standardUserDefaults] objectForKey:@"activityPage"] integerValue];
    } else {
        xiala = 1;
    }
}

#pragma mark tableview delegata
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  0.25*kScreenWidth+83;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
        ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActivityCellID" ];
        if (cell ==nil) {
            cell = [[[NSBundle mainBundle ]loadNibNamed:@"ActivityCell" owner:self options:nil]lastObject];
        }
    UITapGestureRecognizer *edittap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushToEditCtr:)];
    [cell.editButton.superview addGestureRecognizer:edittap];
    
    if (flag==0) {
        cell.model = _dataArray[indexPath.section];
    } else {
        cell.model = _dataArray1[indexPath.section];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UITapGestureRecognizer *tap5 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushActivity:)];
    cell.titleLabel.userInteractionEnabled = YES;
    [cell.titleLabel addGestureRecognizer:tap5];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushActivity:)];
    cell.userImageView.userInteractionEnabled = YES;
    [cell.userImageView addGestureRecognizer:tap];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shareImagewithTap:)];
    [cell.shareButton.superview addGestureRecognizer:tap1];

    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(listpush:)];
    [cell.listButton.superview addGestureRecognizer:tap2];
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(morealert:)];
    [cell.moreButton.superview addGestureRecognizer:tap3];
    return cell;

}
- (void)shareImagewithTap:(UITapGestureRecognizer *)tap

{
     [self getMycell:tap];

    [[SignManager shareManager]shareImagewithModel:mycell.model withCTR:self Withtype:5 withImage:nil];
}
- (void)pushActivity:(UITapGestureRecognizer *)tap
{
     [self getMycell:tap];
    detailActivityViewController *detail = [[detailActivityViewController alloc]init];
    detail.model = mycell.model;
    detail.urlString = [NSString stringWithFormat:@"https://m.zhundao.net/event/%li?accesskey=%@",(long)mycell.model.ID,[[SignManager shareManager] getaccseekey]];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:detail animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}
- (void)morealert:(UITapGestureRecognizer *)tap
{
    [self getMycell:tap];
    moreModalViewController *modal = [[moreModalViewController alloc]init];
    modal.moreModel =mycell.model;
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:modal animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
    modal.backBlock = ^(NSInteger a)
    {
        if (a==1) {
            NSLog(@"删除刷新");
            [self reloadtable];
        }
    };
}
 - (void)reloadtable {
    if (flag == 0) {
        [_dataArray removeObject:mycell.model];
    } else {
        [_dataArray1 removeObject:mycell.model];
    }
    [_tableview reloadData];
}
- (ActivityCell *)getMycell:(UITapGestureRecognizer *)tap
{
    UIResponder *nextResponder = tap.view.nextResponder;
    while (nextResponder) {
        if ([nextResponder isKindOfClass:[UITableViewCell class]]) {
            
            mycell = (ActivityCell *)nextResponder;
            break;
        }
        
        nextResponder = nextResponder.nextResponder;
        
    }
    return mycell;
}
- (void)listpush:(UITapGestureRecognizer *)tap
{
    [self getMycell:tap];
    if (mycell.model.HasJoinNum==0) {
        [[SignManager shareManager]showAlertWithTitle:@"暂无人参加,请下拉刷新数据" WithMessage:nil WithCTR:self];
    }
    else
    {
    ListViewController *list = [[ListViewController alloc]init];
    list.listID = mycell.model.ID;
    list.feeArray = [mycell.model.ActivityFees copy];
    list.userInfo = mycell.model.UserInfo;
    list.HasJoinNum = mycell.model.HasJoinNum;
    list.listName = mycell.model.Title;
    list.timeStart = mycell.model.TimeStart;
    list.address = mycell.model.Address;
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:list animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
    }
}
-(void)pushToEditCtr:(UITapGestureRecognizer *)tap
{
    [self getMycell:tap];
    oneActivityViewController *one = [[oneActivityViewController alloc]init];
    [self setHidesBottomBarWhenPushed:YES];
    one.acID = mycell.model.ID;
    one.activityName = mycell.model.Title;
    [self.navigationController pushViewController:one animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}
#pragma mark tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return flag == 0 ? _dataArray.count : _dataArray1.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0 ;
    }
    else
    {
        return 10;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (flag==2) {
        if (_dataArray1.count-1==section) {
            return 10;
        }else{
            return 0.1;
        }
    } else
    {
        if (_dataArray.count-1==section) {
            return 10;
        }else{
            return 0.1;
        }
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    view.backgroundColor =[UIColor clearColor];
    return  view;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    view.backgroundColor =[UIColor colorWithRed:235.00f/255.0f green:235.00f/255.0f blue:241.00f/255.0f alpha:1];
    return  view;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 10;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }
    else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];

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
