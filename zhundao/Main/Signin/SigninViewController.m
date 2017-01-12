

#import "SigninViewController.h"
#import "signinModel.h"
#import "signinTableViewCell.h"
#import "SaoYiSaoViewController.h"
#import "signinModel.h"
#import "Reachability.h"
#import "LoadAllSignViewController.h"
#import "LoadallsignModel.h"
#import "JQIndicatorView.h"
#import "NewSignViewController.h"
@interface SigninViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *accesskey;
    NSMutableArray *_dataArray;
    NSMutableArray *dataarr;
    NSMutableArray *_dataArray1;
    NSMutableArray *dataarr1;
    NSInteger flag;
    NSInteger status;
    NSInteger signid;
    Reachability *r;
    signinTableViewCell  *mycell;
    NSMutableArray *signarr;
       NSMutableArray *signarr1;
       NSMutableArray *signarr2;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmented;

@end

@implementation SigninViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    flag =0;
    
    [self createRight];
    [self getaccseekey];
     self.view.backgroundColor = [UIColor colorWithRed:235.00f/255.0f green:235.00f/255.0f blue:241.00f/255.0f alpha:1];
     [_segmented addTarget:self action:@selector(segmentedAction:) forControlEvents:UIControlEventValueChanged];
  
    [_tableView registerNib:[UINib nibWithNibName:@"signinTableViewCell" bundle:nil] forCellReuseIdentifier:@"signid"];
       _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = NO;
//     _tableView.backgroundColor = [UIColor colorWithRed:57/255.0 green:67/255.0 blue:89/255.0 alpha:1];
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifi:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
  
    [self firstload];
    
    

}



/////////。 看看
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{if (scrollView == _tableView) {
    CGFloat sectionHeaderHeight = 10;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }
    else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}
}


- (void)createRight
{
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame = CGRectMake(0, 0, 20, 20);
    [_button setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(pushAddSign) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem1 = [[UIBarButtonItem alloc]initWithCustomView:self.button];
    self.navigationItem.rightBarButtonItem = rightItem1;
    
}
- (void)pushAddSign
{
    NewSignViewController *newSign = [[NewSignViewController alloc]init];
    newSign.urlString = [NSString stringWithFormat:@"https://m.zhundao.net/CheckIn/PubCheckIn?accesskey=%@",accesskey];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:newSign animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}
- (void)firstload
{
   r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            NSLog(@"wu");
        {NSMutableArray *muarray = [NSMutableArray array];
            NSArray *array1 = [[NSUserDefaults standardUserDefaults]objectForKey:@"signdata"];
            for (NSDictionary *acdic in array1) {
                signinModel *model = [signinModel yy_modelWithJSON:acdic];
                [muarray addObject:model];
            }
            _dataArray = [muarray mutableCopy];
            NSMutableArray *muarray1 = [NSMutableArray array];
            NSArray *array2 = [[NSUserDefaults standardUserDefaults]objectForKey:@"signdata1"];
            for (NSDictionary *acdic in array2) {
                signinModel *model = [signinModel yy_modelWithJSON:acdic];
                [muarray1 addObject:model];
            }
            _dataArray1 = [muarray mutableCopy];
         
                [_tableView reloadData];
           
            self.netWorkingStatus=0;
            
            break;
        }
    
        case ReachableViaWWAN:
            // 使用3G网络
            NSLog(@"wan");
             [self reflsh];
            [self loadData];
             self.netWorkingStatus=1;
            
            
            break;
        case ReachableViaWiFi:
            // 使用WiFi网络
            NSLog(@"wifi");
            [self reflsh];
            [self loadData];
           
             self.netWorkingStatus=1;
            break;
    }
}
- (void)notifi:(NSNotification *)noti{
    NSDictionary *dic = noti.userInfo;
    
    //获取网络状态
    status = [[dic objectForKey:@"AFNetworkingReachabilityNotificationStatusItem"] integerValue];
    
    if (status==0){
        
    
        {
            if (flag==1||flag==0) {
                NSMutableArray *muarray = [NSMutableArray array];
                NSArray *array1 = [[NSUserDefaults standardUserDefaults]objectForKey:@"signdata"];
                for (NSDictionary *acdic in array1) {
                    signinModel *model = [signinModel yy_modelWithJSON:acdic];
                    [muarray addObject:model];
                }
     
                _dataArray = [muarray mutableCopy];
                if (flag==0) {
                    [_tableView reloadData];
                }
                self.netWorkingStatus=0;
            }
            if (flag==2) {
                NSMutableArray *muarray = [NSMutableArray array];
                NSArray *array1 = [[NSUserDefaults standardUserDefaults]objectForKey:@"signdata1"];
                for (NSDictionary *acdic in array1) {
                    signinModel *model = [signinModel yy_modelWithJSON:acdic];
                    [muarray addObject:model];
                }
                _dataArray1 = [muarray mutableCopy];
                self.netWorkingStatus=0;
                
                
            }
            
        }
        
    }
    else if(status==2||status==1)
    {
        self.netWorkingStatus=1;
        [self loadData];
    }
    else
    {
        NSLog(@"error");
    }
    
}
- (void)dealloc
{
     [_tableView hh_removeRefreshView];
     [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)reflsh
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
     __weak typeof (self) weakSelf = self;
    
    [self.tableView hh_addRefreshViewWithActionHandler:^{
        
        if ((flag==1||flag==0||flag==2)&&(manager.networkReachabilityStatus==AFNetworkReachabilityStatusReachableViaWiFi||manager.networkReachabilityStatus==AFNetworkReachabilityStatusReachableViaWWAN)) {
            [self loadData];
            
        }
        else{
            [weakSelf.tableView hh_removeRefreshView];
            if (flag==1||flag==0) {
                NSMutableArray *muarray = [NSMutableArray array];
                NSArray *array1 = [[NSUserDefaults standardUserDefaults]objectForKey:@"signdata"];
                for (NSDictionary *acdic in array1) {
                    signinModel *model = [signinModel yy_modelWithJSON:acdic];
                    [muarray addObject:model];
                }
                _dataArray = [muarray mutableCopy];
                if (flag==0) {
                    [weakSelf.tableView reloadData];
                }
                self.netWorkingStatus=0;
            }
            if (flag==2) {
                NSMutableArray *muarray = [NSMutableArray array];
                NSArray *array1 = [[NSUserDefaults standardUserDefaults]objectForKey:@"signdata1"];
                for (NSDictionary *acdic in array1) {
                    signinModel *model = [signinModel yy_modelWithJSON:acdic];
                    [muarray addObject:model];
                }
                _dataArray1 = [muarray mutableCopy];
                self.netWorkingStatus=1;
                
                
            }
            
            
        }
    }];
    [_tableView hh_setRefreshViewTopWaveFillColor:[UIColor lightGrayColor]];
    [_tableView hh_setRefreshViewBottomWaveFillColor:[UIColor whiteColor]];
}
- (void)segmentedAction:(UISegmentedControl *)seg{
    
    NSInteger index = seg.selectedSegmentIndex;
    switch (index) {
        case 0:
        { flag=1;
            [_tableView reloadData];
        }
            break;
            
        case 1:
        {
            flag=2;
            [_tableView reloadData];
            self.netWorkingStatus=0;
        }
            
            break;
        default:
            break;
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
- (void)loadData    //网络加载数据
{
    
    JQIndicatorView *indicator = [[JQIndicatorView alloc]initWithType:3 tintColor: [UIColor colorWithRed:9.00f/255.0f green:187.00f/255.0f blue:7.00f/255.0f alpha:1] size:CGSizeMake(90, 70)];
    indicator.center = self.view.center;
    [self.view addSubview:indicator];
    [indicator startAnimating];
    NSString *listurl = [NSString stringWithFormat:@"https://open.zhundao.net/api/CheckIn/PostCheckIn?accessKey=%@",accesskey];
    AFHTTPSessionManager *manager = [AFmanager shareManager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    NSDictionary *dic = @{@"Type":@"1",
                          @"pageSize":@"1000",
                          @"curPage":@"1"};
    [manager POST:listurl parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

       
        NSDictionary *result = [NSDictionary dictionaryWithDictionary:responseObject];
        NSArray *array1 = result[@"Data"];
        NSMutableArray *muarray = [NSMutableArray array];
         NSMutableArray *muarray1 = [NSMutableArray array];
        dataarr = [NSMutableArray array];
        dataarr1 = [NSMutableArray array];
        for (NSDictionary *acdic in array1) {
            signinModel *model = [signinModel yy_modelWithJSON:acdic];
            if (model.Status==1) {
                [muarray addObject:model];
                NSMutableDictionary *e = [NSMutableDictionary dictionary];
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
            if (model.Status==0) {
                [muarray1 addObject:model];
                NSMutableDictionary *e = [NSMutableDictionary dictionary];
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

            [indicator stopAnimating];
        }
        [[NSUserDefaults standardUserDefaults]setObject:dataarr forKey:@"signdata"];
         [[NSUserDefaults standardUserDefaults]setObject:dataarr1 forKey:@"signdata1"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        _dataArray = [muarray mutableCopy];
        _dataArray1 = [muarray1 mutableCopy];
        [_tableView reloadData];
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
    
}

- (void)clickButtonAction:(UIButton *)button{
    UIResponder *nextResponder = button.nextResponder;
    while (nextResponder) {
        if ([nextResponder isKindOfClass:[UITableViewCell class]]) {
            
            mycell  = (signinTableViewCell *)nextResponder;
            break;
        }
        
        nextResponder = nextResponder.nextResponder;
        
    }

    signid = mycell.model.ID;
    NSArray *array = [[[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"all%li",(long)mycell.model.ID]] copy];
    if (array.count==0) {

//     if (array!=nil) {
        UIAlertController *nullAlert = [UIAlertController alertControllerWithTitle:@"注意哦" message:@"尚未下载名单或无报名人员" preferredStyle:UIAlertControllerStyleAlert];
        __weak typeof (self) weakSelf = self;
        UIAlertAction *Action = [UIAlertAction actionWithTitle:@"下载" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf loadSigndata];
                    }];
            UIAlertAction *Action1 = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:nil];
        [nullAlert addAction:Action];
        [nullAlert addAction: Action1];
                    [self presentViewController:nullAlert animated:YES completion:nil];

    }
    if ([array firstObject]) {
        SaoYiSaoViewController *sao = [[SaoYiSaoViewController alloc] init];
        [self setHidesBottomBarWhenPushed:YES];
        sao.signID = mycell.model.ID;
        [self presentViewController:sao animated:YES completion:nil];
        sao.block = ^(NSString *a){
            NSInteger b ;
            NSLog(@" sss = %@",[[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"blockNumber%li",(long)mycell.model.ID]]);
            if ( [[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"blockNumber%li",(long)mycell.model.ID]]) {
                b =  [[[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"blockNumber%li",(long)mycell.model.ID]]integerValue]+[a integerValue];
                [mycell.signcountLabel setTitle:[NSString stringWithFormat:@"已签到: %li  查看",(long)b] forState:UIControlStateNormal];
                [[NSUserDefaults standardUserDefaults]setInteger:b forKey:[NSString stringWithFormat:@"blockNumber%li",(long)mycell.model.ID]];
            }
            if (![[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"blockNumber%li",(long)mycell.model.ID]]) {
                b =(long)mycell.model.NumFact + [a integerValue];
                 [mycell.signcountLabel setTitle:[NSString stringWithFormat:@"已签到: %li  查看",(long)b] forState:UIControlStateNormal];
               [ [NSUserDefaults standardUserDefaults]setInteger:b forKey:[NSString stringWithFormat:@"blockNumber%li",(long)mycell.model.ID]];
            }
       
        };
        [self setHidesBottomBarWhenPushed:NO];
    }
    
    

}

- (void)loadSigndata
{
    JQIndicatorView *indicator = [[JQIndicatorView alloc]initWithType:2 tintColor: [UIColor colorWithRed:9.00f/255.0f green:187.00f/255.0f blue:7.00f/255.0f alpha:1] size:CGSizeMake(70, 70)];
    indicator.center = self.view.center;
    
    [self.view addSubview:indicator];
    [indicator startAnimating];
    NSString *listurl = [NSString stringWithFormat:@"https://open.zhundao.net/api/CheckIn/PostCheckInList?accessKey=%@",accesskey];
    AFHTTPSessionManager *manager = [AFmanager shareManager];
    NSDictionary *dic = @{@"Type":@"0",
                          @"ID":[NSString stringWithFormat:@"%li",(long)signid],
                          @"pageSize":@"10000",
                          @"curPage":@"1"};
    SignManager *datamanager = [SignManager shareManager];
    [datamanager createDatabase];
    if ([datamanager.dataBase open]) {
        bool result = [datamanager.dataBase executeUpdate:@"CREATE TABLE IF NOT EXISTS signList(listid integer PRIMARY KEY AUTOINCREMENT,vcode TEXT NOT NULL,signID integer NOT NULL,Status integer,post integer DEFAULT 2);"];
        if (result) {
            NSLog(@"成功创建table");
        }
        else
        {
            NSLog(@"创建table失败");
        }
        [datamanager.dataBase close];
        
    }
    [manager POST:listurl parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *result = [NSDictionary dictionaryWithDictionary:responseObject];
        NSArray *array1 = result[@"Data"];
        signarr = [NSMutableArray array];
        signarr1 = [NSMutableArray array];
        signarr2 = [NSMutableArray array];
        
        if ([datamanager.dataBase open]) {
            
        
        for (NSDictionary *acdic in array1) {
            LoadallsignModel *model = [LoadallsignModel yy_modelWithJSON:acdic];
            NSMutableDictionary *e = [NSMutableDictionary dictionary];
            NSString *insertSql =[NSString stringWithFormat:@"INSERT INTO signList(vcode, signID,Status)VALUES('%@',%li,%li)",model.VCode,(long)mycell.model.ID,(long)model.Status];
            BOOL res = [datamanager.dataBase executeUpdate:insertSql];
            if (res) {
                NSLog(@"数据表插入成功");
            }
            else
            {
                NSLog(@"数据表插入失败");
            }
            
            for (NSString *keystr in acdic.allKeys) {
                
                if ([[acdic objectForKey:keystr] isEqual:[NSNull null]]) {
           
                    [e setObject:@"" forKey:keystr];
                }
                else
                {
                    [e setObject:[acdic objectForKey:keystr] forKey:keystr];
                }
            }
     
            
            if (model.Status==1) {              //签到完成的
                [signarr1 addObject:e];
            }
            if (model.Status==0) {           //还未到场的
                [signarr2 addObject:e];
            }
            
            [signarr addObject:e];
        }
            
             [datamanager.dataBase close];
        }
        [[NSUserDefaults standardUserDefaults]setObject:signarr forKey:[NSString stringWithFormat:@"all%li",(long)signid]];
        
        [[NSUserDefaults standardUserDefaults]setObject:signarr2 forKey:[NSString stringWithFormat:@"sign%li",(long)signid]];
        [[NSUserDefaults standardUserDefaults]setObject:signarr1 forKey:[NSString stringWithFormat:@"signed%li",(long)signid]];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
      
        
        
        
        
         [indicator stopAnimating];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (flag==1||flag==0) {
        return _dataArray.count;
    }
    else
        
    {
        return _dataArray1.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    signinTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"signid"];
    if (cell==nil) {
        cell = [[signinTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"signid"];
    }
    if (flag==1||flag==0) {
        cell.model = _dataArray[indexPath.section];
    }
    if (flag==2) {
        cell.model = _dataArray1[indexPath.section];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.saoButton addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.signcountLabel addTarget:self action:@selector(pushSignList:) forControlEvents:UIControlEventTouchUpInside];
    [cell.switchButton addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventTouchUpInside];
    if (flag==1||flag==0) {
        [cell.switchButton setOn:YES];
    }
    if (flag==2) {
        [cell.switchButton setOn:NO];
    }
    return  cell;
}
- (void)switchChange:(UIButton *)button
{
    UIResponder *nextResponder = button.nextResponder;
    while (nextResponder) {
        if ([nextResponder isKindOfClass:[UITableViewCell class]]) {
            
            mycell  = (signinTableViewCell *)nextResponder;
            break;
        }
        
        nextResponder = nextResponder.nextResponder;
        
    }
    NSString *listurl = [NSString stringWithFormat:@"https://open.zhundao.net/api/CheckIn/UpdateCheckIn?accessKey=%@&checkInId=%li",accesskey,(long)mycell.model.ID];
    
    AFHTTPSessionManager *manager = [AFmanager shareManager];
    [manager GET:listurl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSIndexPath *indexpath = [_tableView indexPathForCell:mycell];
        if (flag==1||flag==0)
        {
            [_dataArray1 addObject:_dataArray[indexpath.section]];
          
            [_dataArray removeObjectAtIndex:indexpath.section];
             [_tableView reloadData];
        }
        if (flag==2) {
            
            [_dataArray addObject:_dataArray1[indexpath.section]];
            [_dataArray1 removeObjectAtIndex:indexpath.section];
             [_tableView reloadData];
        }
       
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
}
- (void)pushSignList:(UIButton *)button
{
    UIResponder *nextResponder = button.nextResponder;
    while (nextResponder) {
        if ([nextResponder isKindOfClass:[UITableViewCell class]]) {
            
         mycell  = (signinTableViewCell *)nextResponder;
            break;
        }
        
        nextResponder = nextResponder.nextResponder;
        
    }
    LoadAllSignViewController *load = [[LoadAllSignViewController alloc]init];
    load.signID = mycell.model.ID;
    [self setHidesBottomBarWhenPushed:YES];
    
    
    
    
    
    
    
    
   
    
    
    
    
    
    
    
    
    

    
    
    
    [self.navigationController pushViewController:load animated:YES];
    
    [self setHidesBottomBarWhenPushed:NO];
     
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return 140;
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
//-------------------------数据库操作---------------------------



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
