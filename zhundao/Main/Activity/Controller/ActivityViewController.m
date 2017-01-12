//
//  ActivityViewController.m
//  zhundao
//
//  Created by zhundao on 2016/12/2.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import "ActivityViewController.h"
#import "ActivityModel.h"
#import "ActivityCell.h"
#import "editViewController.h"
#import "ShareView.h"
#import "UIView+TYAlertView.h"
#import "TYAlertController+BlurEffects.h"
#import "ListViewController.h"
#import "Reachability.h"
#import "JQIndicatorView.h"
#import "NewActivityViewController.h"
#import "AppDelegate.h"
#import "detailActivityViewController.h"
#import "NewView.h"
//POST api/PerActivity/PostActivityList?accessKey={accessKey}  获取活动列表
//Title
//ShareImgurl 分享图片
//TimeStart = "2016-12-12T21:50:00";//活动开始时间
//TimeStop = "2016-12-11T21:50:00";／／报名截止时间
//Amount  收入
//Status。0表示报名中 1表示时间在报名人满了    2 报名截止

@interface ActivityViewController ()<UITableViewDelegate,UITableViewDataSource>
{ActivityCell *mycell;
    NSMutableArray *_dataArray;
    NSString *accesskey;
    NSMutableArray *dataarr;
    NSMutableArray *_dataArray1;
    NSMutableArray *dataarr1;
    NSInteger flag;
    NSInteger status ;
    NSMutableDictionary *postdic;
    NSMutableArray *postArray;
    Reachability *r;
  
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmented;


@end

@implementation ActivityViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    flag=0;
    [self createRight];
     [self getaccseekey];
    self.view.backgroundColor = [UIColor colorWithRed:235.00f/255.0f green:235.00f/255.0f blue:241.00f/255.0f alpha:1];
    
    [_segmented addTarget:self action:@selector(segmentedAction:) forControlEvents:UIControlEventValueChanged];
    [_tableview registerNib:[UINib nibWithNibName:@
                             "ActivityCell" bundle:nil]
     forCellReuseIdentifier:@"ActivityCellID"];
    _tableview.separatorStyle = NO;
    _tableview.backgroundColor = [UIColor clearColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.tableview.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-150);
    
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifi:) name:AFNetworkingReachabilityDidChangeNotification object:nil];

   __weak __typeof(self) weakSelf=self;
   r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            break;
        case ReachableViaWWAN:
            // 使用3G网
           
            [weakSelf loadData];
            [self reflsh];
            break;
        case ReachableViaWiFi:
            // 使用WiFi网络
            [weakSelf loadData];
            [self reflsh];
            break;
    }
    [self post];
    NSArray *Array1 = [[NSUserDefaults standardUserDefaults]objectForKey:@"data"];
    if (Array1.count==0) {
         [self createView];
    }

}

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
- (void)hiddenView:(UITapGestureRecognizer *)tap
{
    NewView *view = (NewView *)tap.view;
    [view removeFromSuperview];
    
}
- (void)post
{     postArray = [NSMutableArray array];
    if ([r currentReachabilityStatus]==2||[r currentReachabilityStatus]==1) {
        SignManager *manager = [SignManager shareManager];
        [manager createDatabase];
        if ([manager.dataBase open]) {
            NSString *sql = @"SELECT * FROM signList";
            FMResultSet * rs = [manager.dataBase executeQuery:sql];
            while ([rs next])
            {
                NSLog(@"post = %i",[rs intForColumn:@"post"]);
                NSLog(@"status = %i",[rs intForColumn:@"Status"]);
                NSLog(@"signid = %i",[rs intForColumn:@"signID"]);
                postdic = [NSMutableDictionary dictionary];
                if ([rs intForColumn:@"post"] ==0) {
                    [postdic setValue:[rs stringForColumn:@"vcode"] forKey:@"vcode"];
                    [postdic setValue:[NSString stringWithFormat:@"%i",[rs intForColumn:@"signID"]] forKey:@"checkInid"];
                    [postArray addObject:postdic];
                }
            }
            [manager.dataBase close];
            
        }
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:postArray options:0 error:nil];
        NSString *jsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        
        NSLog(@"jsonStr = %@",jsonStr);
        NSString *postStr =[NSString stringWithFormat:@"https://open.zhundao.net/api/CheckIn/BatchCheckIn?accessKey=%@&checkJson=%@",accesskey,jsonStr];
        postStr = [postStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        AFHTTPSessionManager *afmanager = [AFmanager shareManager];
        [afmanager POST:postStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"responseObject = %@",responseObject);
            NSDictionary *msg = [NSDictionary dictionaryWithDictionary:responseObject];
            if ([msg[@"Msg"]integerValue] ==0) {
                SignManager *manager = [SignManager shareManager];
                [manager createDatabase];
                if ([manager.dataBase open]) {
                    
                    
                    
                    [manager.dataBase executeUpdate:[NSString stringWithFormat:@"UPDATE signList SET  post = '1' where post ='0';"]];
                    
                    NSString *sql = @"SELECT * FROM signList";
                    FMResultSet * rs = [manager.dataBase executeQuery:sql];
                    while ([rs next])
                    {
                        postdic = [NSMutableDictionary dictionary];
                        if ([rs intForColumn:@"post"] ==0) {
                            [postdic setValue:[rs stringForColumn:@"vcode"] forKey:@"vcode"];
                            [postdic setValue:[NSString stringWithFormat:@"%i",[rs intForColumn:@"signID"]] forKey:@"checkInid"];
                            [postArray addObject:postdic];
                        }
                    }

                    
                    
                    
                    
                }
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error = %@",error);
        }];
        
        
        
        
    }
}

- (void)createRight
{
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame = CGRectMake(0, 0, 20, 20);
    [_button setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(pushAddActivity) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem1 = [[UIBarButtonItem alloc]initWithCustomView:self.button];
    self.navigationItem.rightBarButtonItem = rightItem1;
   
    
}
//http://m.zhundao.net/Activity/PubActivity
- (void)pushAddActivity
{
    NewActivityViewController *newCtrl = [[NewActivityViewController alloc]init];
    newCtrl.urlString = [NSString stringWithFormat:@"https://m.zhundao.net/Activity/PubActivity?accesskey=%@",accesskey];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:newCtrl animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}
- (void)notifi:(NSNotification *)noti{
    NSDictionary *dic = noti.userInfo;
    
    //获取网络状态
    status = [[dic objectForKey:@"AFNetworkingReachabilityNotificationStatusItem"] integerValue];
    if (status==0){
  
        
        {
            
            if (flag==1||flag==0) {
                NSMutableArray *muarray = [NSMutableArray array];
                NSArray *array1 = [[NSUserDefaults standardUserDefaults]objectForKey:@"data"];
                for (NSDictionary *acdic in array1) {
                    ActivityModel *model = [ActivityModel yy_modelWithJSON:acdic];
                    [muarray addObject:model];
                }
                _dataArray = [muarray copy];
                if (flag==0) {
                    [_tableview reloadData];
                }
                _netWorkingStatus=0;
            }
            if (flag==2) {
                NSMutableArray *muarray = [NSMutableArray array];
                NSArray *array1 = [[NSUserDefaults standardUserDefaults]objectForKey:@"data1"];
                for (NSDictionary *acdic in array1) {
                    ActivityModel *model = [ActivityModel yy_modelWithJSON:acdic];
                    [muarray addObject:model];
                }
                _dataArray1 = [muarray copy];
                _netWorkingStatus=0;
                
                
            }
            
        }
        
    }
    else if(status==2||status==1)
    {
         _netWorkingStatus=1;
      
    }
    else
    {
        NSLog(@"error");
    }

}
- (void)getaccseekey
{
    NSString *acc =[[NSUserDefaults standardUserDefaults]objectForKey:AccessKey];
    NSString *uid = [[NSUserDefaults standardUserDefaults]objectForKey:WX_UNION_ID];
    if (acc) {
        accesskey = [acc copy];
    }
    if (uid) {
        accesskey = [uid copy];
    }
}
- (void)reflsh
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];

    [_tableview hh_addRefreshViewWithActionHandler:^{
     
        __weak __typeof(self) weakSelf=self;
        if ((flag==1||flag==0||flag==2)&&(manager.networkReachabilityStatus==AFNetworkReachabilityStatusReachableViaWiFi||manager.networkReachabilityStatus==AFNetworkReachabilityStatusReachableViaWWAN)) {
            [weakSelf loadData];
           
        }
        else{
            
                if (flag==1||flag==0) {
                    NSMutableArray *muarray = [NSMutableArray array];
                    NSArray *array1 = [[NSUserDefaults standardUserDefaults]objectForKey:@"data"];
                    for (NSDictionary *acdic in array1) {
                        ActivityModel *model = [ActivityModel yy_modelWithJSON:acdic];
                        [muarray addObject:model];
                    }
                    _dataArray = [muarray copy];
                    if (flag==0) {
                        [_tableview reloadData];
                        
                    }
                    _netWorkingStatus=0;
                }
                if (flag==2) {
                    NSMutableArray *muarray = [NSMutableArray array];
                    NSArray *array1 = [[NSUserDefaults standardUserDefaults]objectForKey:@"data1"];
                    for (NSDictionary *acdic in array1) {
                        ActivityModel *model = [ActivityModel yy_modelWithJSON:acdic];
                        [muarray addObject:model];
                    }
                    _dataArray1 = [muarray copy];
                    _netWorkingStatus=1;
                    
                    
                }
                
            
        }
    }];
    [_tableview hh_setRefreshViewTopWaveFillColor:[UIColor lightGrayColor]];
    [_tableview hh_setRefreshViewBottomWaveFillColor:[UIColor whiteColor]];
}
- (void)segmentedAction:(UISegmentedControl *)seg{
    
    
    NSInteger index = seg.selectedSegmentIndex;
    switch (index) {
        case 0:
        { flag=1;
             [_tableview reloadData];
        }
            break;
            
        case 1:
        {
                    flag =2;
                    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
                    if (manager.networkReachabilityStatus==AFNetworkReachabilityStatusNotReachable) {
                        {
                            if (flag==1||flag==0) {
                                NSMutableArray *muarray = [NSMutableArray array];
                                NSArray *array1 = [[NSUserDefaults standardUserDefaults]objectForKey:@"data"];
                                for (NSDictionary *acdic in array1) {
                                    ActivityModel *model = [ActivityModel yy_modelWithJSON:acdic];
                                    [muarray addObject:model];
                                }
                                _dataArray = [muarray copy];
            
                                [_tableview reloadData];
                            }
                            if (flag==2) {
                                NSMutableArray *muarray = [NSMutableArray array];
                                NSArray *array1 = [[NSUserDefaults standardUserDefaults]objectForKey:@"data1"];
                                for (NSDictionary *acdic in array1) {
                                    ActivityModel *model = [ActivityModel yy_modelWithJSON:acdic];
                                    [muarray addObject:model];
                                }
                                _dataArray1 = [muarray copy];
                                
                                [_tableview reloadData];
                            }
                            
                        }
                    }
                    
                    [_tableview reloadData];
                }
    
            break;
        default:
            break;
    }
    
}


- (void)loadData    //网络加载数据
{
    
    
    JQIndicatorView *indicator = [[JQIndicatorView alloc]initWithType:3 tintColor: [UIColor colorWithRed:9.00f/255.0f green:187.00f/255.0f blue:7.00f/255.0f alpha:1] size:CGSizeMake(90, 70)];
    indicator.center = self.view.center;
    [self.view addSubview:indicator];
    [indicator startAnimating];
    NSString *listurl = [NSString stringWithFormat:@"https://open.zhundao.net/api/PerActivity/PostActivityList?accessKey=%@",accesskey];
    AFHTTPSessionManager *manager = [AFmanager shareManager];
    NSDictionary *dic = @{@"Type":@"0",
                          @"pageSize":@"100",
                          @"curPage":@"1"};
    [manager POST:listurl parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     
        NSDictionary *result = [NSDictionary dictionaryWithDictionary:responseObject];
        NSArray *array1 = result[@"Data"];
 
        NSMutableArray *muarray = [NSMutableArray array];
          NSMutableArray *muarray1 = [NSMutableArray array];
    dataarr = [NSMutableArray array];
       
         dataarr1 = [NSMutableArray array];
        for (NSDictionary *acdic in array1) {
            ActivityModel *model = [ActivityModel yy_modelWithJSON:acdic];
            {
                 NSMutableDictionary *e = [NSMutableDictionary dictionary];
                if (model.Status==2) {
                    [muarray1 addObject:model];
                    for (NSString *keystr in acdic.allKeys) {
                        
                        if ([[acdic objectForKey:keystr] isEqual:[NSNull null]]) {
                            //
                            [e setObject:@"" forKey:keystr];
                        }
                        else
                        {
                            [e setObject:[acdic objectForKey:keystr] forKey:keystr];
                        }
                    }
                    
                    [dataarr1 addObject:e];
                }
            if (model.Status==0||model.Status==1) {
                [muarray addObject:model];
                for (NSString *keystr in acdic.allKeys) {
                    
                    if ([[acdic objectForKey:keystr] isEqual:[NSNull null]]) {
                        //
                        [e setObject:@"" forKey:keystr];
                    }
                    else
                    {
                        [e setObject:[acdic objectForKey:keystr] forKey:keystr];
                    }
                }
                
                [dataarr addObject:e];
            }
      
            }
     
            [indicator stopAnimating];
  }
        [[NSUserDefaults standardUserDefaults]setObject:dataarr forKey:@"data"];
         [[NSUserDefaults standardUserDefaults]setObject:dataarr1 forKey:@"data1"];
      
        [[NSUserDefaults standardUserDefaults]synchronize];
        _dataArray1 = [muarray1 copy];
        _dataArray = [muarray copy];
        [_tableview reloadData];
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
    
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
    
    if (flag==1||flag==0) {
        cell.model = _dataArray[indexPath.section];
    }
    if (flag==2) {
        cell.model = _dataArray1[indexPath.section];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushActivity:)];
    [cell addGestureRecognizer:tap];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shareAction:)];
    [cell.shareButton.superview addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(listpush:)];
    [cell.listButton.superview addGestureRecognizer:tap2];
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(morealert)];
    [cell.moreButton.superview addGestureRecognizer:tap3];
    
   
    return cell;

}
- (void)pushActivity:(UITapGestureRecognizer *)tap
{
    mycell = (ActivityCell *)tap.view;
    detailActivityViewController *detail = [[detailActivityViewController alloc]init];
    detail.model = mycell.model;
    detail.urlString = [NSString stringWithFormat:@"https://m.zhundao.net/event/%li?accesskey=%@",(long)mycell.model.ID,accesskey];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:detail animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}
- (void)morealert
{
    UIAlertController *moreAlert1 = [UIAlertController alertControllerWithTitle:@"友情提示" message:@"功能正在开发中哦" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [moreAlert1 addAction:action1];
    [self presentViewController:moreAlert1 animated:YES completion:nil];
}
- (void)showalert
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"尚未有人参加" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)listpush:(UITapGestureRecognizer *)tap
{
    UIResponder *nextResponder = tap.view.nextResponder;
    while (nextResponder) {
        if ([nextResponder isKindOfClass:[UITableViewCell class]]) {
            
            mycell = (ActivityCell *)nextResponder;
            break;
        }
        
        nextResponder = nextResponder.nextResponder;
        
    }
    if (mycell.model.HasJoinNum==0) {
         [self showalert];
    }
    else
    {
    ListViewController *list = [[ListViewController alloc]init];
    list.listID = mycell.model.ID;
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:list animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
    }
}
- (void)shareAction:(UITapGestureRecognizer *)tap
{
    UIResponder *nextResponder = tap.view.nextResponder;
    while (nextResponder) {
        if ([nextResponder isKindOfClass:[UITableViewCell class]]) {
            
           mycell = (ActivityCell *)nextResponder;
            break;
        }
        
        nextResponder = nextResponder.nextResponder;
        
    }
    


    ShareView *shareView = [ShareView createViewFromNib];
    
    TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:shareView preferredStyle:TYAlertControllerStyleAlert];
        shareView.model =mycell.model;
    // blur effect
    [alertController setBlurEffectWithView:self.view];
    [self presentViewController:alertController animated:YES completion:nil];
}
-(void)pushToEditCtr:(UITapGestureRecognizer *)tap
{
    UIResponder *nextResponder = tap.view.nextResponder;
    while (nextResponder) {
        if ([nextResponder isKindOfClass:[UITableViewCell class]]) {
            
            mycell = (ActivityCell *)nextResponder;
            break;
        }
        
        nextResponder = nextResponder.nextResponder;
        
    }
    editViewController *editctr = [[editViewController alloc]init];
    editctr.urlString =[NSString stringWithFormat: @"https://m.zhundao.net/Activity/PubActivity/%ld?accesskey=%@",(long)mycell.model.ID,accesskey];
      [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:editctr animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}









#pragma mark tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (flag==1||flag==0) {
        return _dataArray.count;
    }
    else
        
    {
        return _dataArray1.count;
    }
   
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{if (scrollView == _tableview) {
    CGFloat sectionHeaderHeight = 10;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }
    else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    view.backgroundColor =[UIColor colorWithRed:235.00f/255.0f green:235.00f/255.0f blue:241.00f/255.0f alpha:1];
    return  view;
}
- (void)dealloc {
    [_tableview hh_removeRefreshView];
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
